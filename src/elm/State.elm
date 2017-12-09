module State exposing (..)

import Data exposing (..)
import Decode
import Dict
import Encode
import Eos
import Eos.Data as Eos
import Eos.Ecc.Data as Eos
import Json.Decode as Decode exposing (Value)
import Task exposing (Task)
import Time exposing (Time)


type Msg
    = NoOp
    | Tick Time
    | SetHttpEndpoint String
    | SetInput String String
    | SetStatus Status
    | SetAccountCurrentGame Game
    | SetAccountGames (Result Eos.Error (List Game))
    | Login String String
    | Move Game Int Int
    | PushedAction (Result Eos.Error (Eos.PushedTransaction Action))


init : Value -> ( Model, Cmd Msg )
init flagsValue =
    case Decode.decodeValue Decode.flags flagsValue of
        Ok flags ->
            let
                model =
                    initialModel flags
            in
            model ! [ checkStatus model.httpEndpoint model.contractAccount ]

        Err err ->
            let
                _ =
                    Debug.log "Error decoding flags" err
            in
            emptyModel ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            model ! []

        Tick _ ->
            model ! [ checkAccountGames model.httpEndpoint model.contractAccount model.status ]

        SetHttpEndpoint httpEndpoint ->
            { model | httpEndpoint = httpEndpoint } ! [ checkStatus httpEndpoint model.contractAccount ]

        SetStatus status ->
            let
                cmd =
                    case status of
                        CreatingContractAccount creator keyProvider ->
                            createContractAccount model.httpEndpoint model.contractAccount creator keyProvider

                        SettingContractCode keyProvider ->
                            setContractCode
                                { httpEndpoint = model.httpEndpoint
                                , keyProvider = keyProvider
                                , account = model.contractAccount
                                , code = model.contractCode
                                , codeAbi = model.contractAbi
                                }

                        _ ->
                            Cmd.none
            in
            { model | status = status } ! [ cmd ]

        SetInput key val ->
            { model | inputs = Dict.insert key val model.inputs } ! []

        SetAccountCurrentGame game ->
            case model.status of
                LoggedIn account ->
                    let
                        status =
                            LoggedIn { account | currentGame = Just game }
                    in
                    { model | status = status } ! []

                _ ->
                    model ! []

        SetAccountGames (Ok games) ->
            case model.status of
                LoggedIn account ->
                    let
                        firstGame =
                            List.head games

                        currentGame =
                            case account.currentGame of
                                Just game ->
                                    games
                                        |> List.filter (\g -> g.challenger == game.challenger)
                                        |> List.head

                                Nothing ->
                                    firstGame

                        status =
                            LoggedIn
                                { account
                                    | games = games
                                    , currentGame =
                                        if currentGame == Nothing then
                                            firstGame
                                        else
                                            currentGame
                                }
                    in
                    { model | status = status } ! []

                _ ->
                    model ! []

        SetAccountGames (Err err) ->
            let
                _ =
                    Debug.log "Error getting games" err
            in
            model ! []

        Login accountNameStr privateKeyStr ->
            let
                status =
                    case ( Eos.accountNameFromString accountNameStr, Eos.privateKeyFromString privateKeyStr ) of
                        ( Ok accountName, Ok privateKey ) ->
                            LoggedIn
                                { name = accountName
                                , privateKey = privateKey
                                , currentGame = Nothing
                                , games = []
                                }

                        ( Err err, _ ) ->
                            InvalidCredentials err

                        ( _, Err err ) ->
                            InvalidCredentials err

                cmd =
                    checkAccountGames model.httpEndpoint model.contractAccount status
            in
            { model | status = status } ! [ cmd ]

        Move game row column ->
            case model.status of
                LoggedIn account ->
                    let
                        newStatus =
                            LoggedIn <| setMyTile account game row column

                        cmd =
                            move model.httpEndpoint
                                model.contractAccount
                                account
                                { challenger = game.challenger
                                , host = game.host
                                , by = account.name
                                , movement =
                                    { row = row
                                    , column = column
                                    }
                                }
                    in
                    { model | status = newStatus } ! [ cmd ]

                _ ->
                    model ! []

        PushedAction (Ok tx) ->
            let
                _ =
                    Debug.log "Ok pushed action" tx
            in
            model ! []

        PushedAction (Err err) ->
            let
                _ =
                    Debug.log "Error pushing action" err
            in
            model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every (Time.second * 2) Tick


checkStatus : String -> Eos.AccountName -> Cmd Msg
checkStatus httpEndpoint contractName =
    { httpEndpoint = httpEndpoint }
        |> Eos.getInfo
        |> Task.mapError (\_ -> HttpEndpointOffline)
        |> Task.andThen (\_ -> checkContract httpEndpoint contractName)
        |> setStatus


checkContract : String -> Eos.AccountName -> Task Status Status
checkContract httpEndpoint contractName =
    { httpEndpoint = httpEndpoint
    , accountName = contractName
    }
        |> Eos.getAccount
        |> Task.mapError (\_ -> ContractAccountNotCreated)
        |> Task.andThen (\_ -> checkContractCode httpEndpoint contractName)


checkContractCode : String -> Eos.AccountName -> Task Status Status
checkContractCode httpEndpoint contractName =
    { httpEndpoint = httpEndpoint
    , accountName = contractName
    }
        |> Eos.getCode
        |> Task.mapError (\_ -> ContractCodeNotSet)
        |> Task.andThen
            (\{ wast } ->
                if String.length wast == 0 then
                    Task.fail ContractCodeNotSet
                else
                    Task.succeed LoggedOut
            )


checkAccountGames : String -> Eos.AccountName -> Status -> Cmd Msg
checkAccountGames httpEndpoint contractName status =
    case status of
        LoggedIn { name } ->
            { httpEndpoint = httpEndpoint
            , scope = name
            , code = contractName
            , table = Eos.tableNameFromString "games"
            , rowDecoder = Decode.game
            }
                |> Eos.getTableRows
                |> Task.map .rows
                |> Task.attempt SetAccountGames

        _ ->
            Cmd.none


createContractAccount : String -> Eos.AccountName -> Eos.AccountName -> Eos.PrivateKey -> Cmd Msg
createContractAccount httpEndpoint account creator keyProvider =
    { httpEndpoint = httpEndpoint
    , privateKeys = [ keyProvider ]
    , creator = creator
    , name = account
    , owner = creator
    , active = creator
    , recovery = creator
    , deposit = "1 EOS"
    }
        |> Eos.newAccount
        |> Task.mapError ErrorCreatingContractAccount
        |> Task.map (\_ -> ContractCodeNotSet)
        |> setStatus


setContractCode :
    { httpEndpoint : String
    , keyProvider : Eos.PrivateKey
    , account : Eos.AccountName
    , code : String
    , codeAbi : String
    }
    -> Cmd Msg
setContractCode o =
    { httpEndpoint = o.httpEndpoint
    , privateKeys = [ o.keyProvider ]
    , account = o.account
    , vmType = 0
    , vmVersion = 0
    , code = o.code
    , codeAbi = o.codeAbi
    }
        |> Eos.setCode
        |> Task.mapError ErrorSettingContractCode
        |> Task.map (\_ -> LoggedOut)
        |> setStatus


setStatus : Task Status Status -> Cmd Msg
setStatus =
    Task.attempt
        (\result ->
            case result of
                Ok status ->
                    SetStatus status

                Err status ->
                    SetStatus status
        )


move : String -> Eos.AccountName -> Account -> MoveFields -> Cmd Msg
move httpEndpoint contractName account moveFields =
    { httpEndpoint = httpEndpoint
    , privateKeys = [ account.privateKey ]
    , scope = [ account.name, moveFields.challenger ]
    , messages =
        [ { code = contractName
          , type_ = "move"
          , authorization =
                [ { account = account.name
                  , permission = Eos.active
                  }
                ]
          , data = MoveAction moveFields
          }
        ]
    , encodeData = Encode.action
    , dataDecoder = Decode.action
    }
        |> Eos.pushTransaction
        |> Task.attempt PushedAction


setMyTile : Account -> Game -> Int -> Int -> Account
setMyTile account game row column =
    let
        myTile =
            if account.name == game.host then
                HostTile
            else
                ChallengerTile

        board =
            game.board

        newBoard =
            case ( row, column ) of
                ( 0, 0 ) ->
                    { board | topLeft = myTile }

                ( 0, 1 ) ->
                    { board | topCenter = myTile }

                ( 0, 2 ) ->
                    { board | topRight = myTile }

                ( 1, 0 ) ->
                    { board | centerLeft = myTile }

                ( 1, 1 ) ->
                    { board | centerCenter = myTile }

                ( 1, 2 ) ->
                    { board | centerRight = myTile }

                ( 2, 0 ) ->
                    { board | bottomLeft = myTile }

                ( 2, 1 ) ->
                    { board | bottomCenter = myTile }

                ( 2, 2 ) ->
                    { board | bottomRight = myTile }

                _ ->
                    board

        newGame =
            { game | board = newBoard }

        newCurrentGame =
            case account.currentGame of
                Just currentGame ->
                    if currentGame.host == game.host && currentGame.challenger == game.challenger then
                        Just newGame
                    else
                        Just currentGame

                Nothing ->
                    Nothing

        newGames =
            account.games
                |> List.filter (\g -> g.host == game.host && g.challenger == game.challenger)
                |> (::) newGame
    in
    { account | currentGame = newCurrentGame, games = newGames }
