module View exposing (..)

import Data exposing (..)
import Dict
import Eos.Data as Eos
import Eos.Ecc.Data as Eos
import Html exposing (..)
import Html.Attributes as A exposing (href, type_, value)
import Html.Events exposing (onClick, onInput, onSubmit)
import Html.Lazy exposing (lazy)
import State exposing (Msg(..))
import Style exposing (class, classList, classes, svgClass, svgClasses)
import Svg
import Svg.Attributes as Svg


type CssClass
    = Container
    | Header
    | Nav
    | Title
    | Icon
    | Sidebar
    | NewGameButton
    | Games
    | Game
    | Game_Selected
    | GameChallenger
    | GameStatus
    | CurrentGame
    | Board
    | BoardTile
    | BoardTile_Open
    | BoardTile_Host
    | BoardTile_Challenger


view : Model -> Html Msg
view model =
    case model.status of
        CheckingHttpEndpoint ->
            loggedOutView model [ text "Checking HTTP endpoint" ]

        HttpEndpointOffline ->
            lazy httpEndpointOfflineView model

        ContractAccountNotCreated ->
            contractAccountNotCreatedView model

        CreatingContractAccount _ _ ->
            loggedOutView model [ text "Creating contract account..." ]

        ErrorCreatingContractAccount e ->
            loggedOutView model [ text <| toString e ]

        ContractCodeNotSet ->
            contractCodeNotSetView model

        SettingContractCode _ ->
            loggedOutView model [ text "Setting contract code" ]

        ErrorSettingContractCode e ->
            loggedOutView model [ text <| toString e ]

        LoggedOut ->
            loggedOutFormView model

        InvalidCredentials err ->
            loggedOutView model
                [ text "Invalid credentials: "
                , text err
                ]

        CreatingAccount name creator keyProvider ->
            loggedOutView model [ text "Creating account" ]

        LoggedIn account ->
            loggedInView model account


httpEndpointOfflineView : Model -> Html Msg
httpEndpointOfflineView model =
    let
        name =
            "httpEndpoint"

        val =
            model.inputs
                |> Dict.get name
                |> Maybe.withDefault model.httpEndpoint
    in
    loggedOutView model
        [ h2 []
            [ text "Couldn't connect to EOS network"
            ]
        , form [ onSubmit <| SetHttpEndpoint val ]
            [ label []
                [ strong [] [ text "URL" ]
                , input
                    [ type_ "url"
                    , value val
                    , onInput <| SetInput name
                    ]
                    []
                ]
            , button [ type_ "submit" ] [ text "Connect" ]
            ]
        , p [] [ text "Until the test network is deployed you must run your own node to use this demo." ]
        , p []
            [ text "The easiest way to get a local node running is with Docker. Please see the Docker instructions in "
            , a [ href "https://github.com/EOSIO/eos/blob/master/Docker/README.md" ]
                [ text "the official EOSIO repo on Github" ]
            , text "."
            ]
        ]


initaPrivate : String
initaPrivate =
    "5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3"


contractAccountNotCreatedView : Model -> Html Msg
contractAccountNotCreatedView model =
    let
        creatorStr =
            model.inputs
                |> Dict.get "creator"
                |> Maybe.withDefault "inita"

        keyProviderStr =
            model.inputs
                |> Dict.get "keyProvider"
                |> Maybe.withDefault initaPrivate

        newStatus =
            case ( Eos.accountNameFromString creatorStr, Eos.privateKeyFromString keyProviderStr ) of
                ( Ok creator, Ok privateKey ) ->
                    CreatingContractAccount creator privateKey

                _ ->
                    model.status
    in
    loggedOutView model
        [ h2 [] [ text "Contract account does not exist" ]
        , form
            [ onSubmit <| SetStatus newStatus ]
            [ label []
                [ strong [] [ text "Contract account" ]
                , input
                    [ type_ "text"
                    , A.readonly True
                    , value <| Eos.accountNameToString model.contractAccount
                    ]
                    []
                ]
            , label []
                [ strong [] [ text "Creator" ]
                , input
                    [ type_ "text"
                    , value creatorStr
                    , onInput <| SetInput "creator"
                    ]
                    []
                ]
            , label []
                [ strong [] [ text "Key provider" ]
                , input
                    [ type_ "password"
                    , value keyProviderStr
                    , onInput <| SetInput "keyProvider"
                    ]
                    []
                ]
            , button [ type_ "submit" ] [ text "Create account" ]
            ]
        ]


contractCodeNotSetView : Model -> Html Msg
contractCodeNotSetView model =
    let
        keyProvider =
            model.inputs
                |> Dict.get "keyProvider"
                |> Maybe.withDefault initaPrivate

        newStatus =
            case Eos.privateKeyFromString keyProvider of
                Ok privateKey ->
                    SettingContractCode privateKey

                Err _ ->
                    model.status
    in
    loggedOutView model
        [ h2 [] [ text "Contract code not set" ]
        , form
            [ onSubmit <| SetStatus newStatus ]
            [ label []
                [ strong [] [ text "Key provider" ]
                , input
                    [ type_ "password"
                    , value keyProvider
                    , onInput <| SetInput "keyProvider"
                    ]
                    []
                ]
            , label []
                [ strong [] [ text "Code" ]
                , textarea [ A.readonly True ]
                    [ text model.contractCode ]
                ]
            , label []
                [ strong [] [ text "Code ABI" ]
                , textarea [ A.readonly True ]
                    [ text model.contractAbi ]
                ]
            , button [ type_ "submit" ] [ text "Set contract code" ]
            ]
        ]


loggedOutFormView : Model -> Html Msg
loggedOutFormView model =
    let
        username =
            model.inputs
                |> Dict.get "username"
                |> Maybe.withDefault "inita"

        password =
            model.inputs
                |> Dict.get "keyProvider"
                |> Maybe.withDefault initaPrivate
    in
    loggedOutView model
        [ form [ onSubmit <| Login username password ]
            [ h2 [] [ text "Login" ]
            , label []
                [ strong [] [ text "Username" ]
                , input
                    [ type_ "text"
                    , value username
                    , onInput <| SetInput "username"
                    ]
                    []
                ]
            , label []
                [ strong [] [ text "Password" ]
                , input
                    [ type_ "password"
                    , value password
                    , onInput <| SetInput "keyProvider"
                    ]
                    []
                ]
            , button [ type_ "submit" ] [ text "Login" ]
            ]
        ]


loggedOutView : Model -> List (Html Msg) -> Html Msg
loggedOutView model innerHtml =
    containerView <| headerView model :: innerHtml


loggedInView : Model -> Account -> Html Msg
loggedInView model account =
    containerView
        [ headerView model
        , sidebarView model account
        , currentGame model account
        ]


containerView : List (Html Msg) -> Html Msg
containerView =
    div [ class Container ]


headerView : Model -> Html Msg
headerView model =
    header [ class Header ]
        [ h1 [ class Title ]
            [ iconView "eos"
            , text "EOS Tic Tac Toe Demo"
            ]
        , nav [ class Nav ]
            [ a [ href "#github" ]
                [ text "View source on Github"
                , iconView "github-face"
                ]
            ]
        ]


sidebarView : Model -> Account -> Html Msg
sidebarView model account =
    aside [ class Sidebar ]
        [ a [ class NewGameButton, href "#" ] [ text "New game" ]
        , gamesView model account
        ]


gamesView : Model -> Account -> Html Msg
gamesView model account =
    div [ class Games ] <|
        if List.length account.games == 0 then
            [ text "Challenge someone to a game!" ]
        else
            List.map (gameView model account) account.games


gameView : Model -> Account -> Game -> Html Msg
gameView model account game =
    let
        isSelected =
            account.currentGame
                |> Maybe.map (\g -> g.challenger == game.challenger && g.host == game.host)
                |> Maybe.withDefault False
    in
    div
        [ classList [ ( Game, True ), ( Game_Selected, isSelected ) ]
        , onClick <| SetAccountCurrentGame game
        ]
        [ gameChallengerView game
        , gameStatusView account game
        ]


gameChallengerView : Game -> Html Msg
gameChallengerView game =
    div [ class GameChallenger ]
        [ text <| Eos.accountNameToString game.challenger ]


gameStatusView : Account -> Game -> Html Msg
gameStatusView account game =
    let
        opponent =
            if game.host == account.name then
                game.challenger
            else
                game.host

        message =
            if game.winner == account.name then
                "You won!"
            else if game.winner == opponent then
                "You lost"
            else if game.turn == account.name then
                "Your turn"
            else
                "Their turn"
    in
    div [ class GameStatus ]
        [ text message
        ]


currentGame : Model -> Account -> Html Msg
currentGame model account =
    div [ class CurrentGame ] <|
        case account.currentGame of
            Just game ->
                [ boardView account game ]

            Nothing ->
                [ text "Challenge someone" ]


boardView : Account -> Game -> Html Msg
boardView account game =
    let
        isMyTurn =
            account.name == game.turn

        board =
            game.board
    in
    div [ class Board ]
        [ tileView isMyTurn game 0 0 board.topLeft
        , tileView isMyTurn game 0 1 board.topCenter
        , tileView isMyTurn game 0 2 board.topRight
        , tileView isMyTurn game 1 0 board.centerLeft
        , tileView isMyTurn game 1 1 board.centerCenter
        , tileView isMyTurn game 1 2 board.centerRight
        , tileView isMyTurn game 2 0 board.bottomLeft
        , tileView isMyTurn game 2 1 board.bottomCenter
        , tileView isMyTurn game 2 2 board.bottomRight
        ]


tileView : Bool -> Game -> Int -> Int -> Tile -> Html Msg
tileView isMyTurn game row column tile =
    case tile of
        OpenTile ->
            openTileView isMyTurn game row column

        HostTile ->
            hostTileView

        ChallengerTile ->
            hostTileView


openTileView : Bool -> Game -> Int -> Int -> Html Msg
openTileView isMyTurn game row column =
    div
        [ classes [ BoardTile, BoardTile_Open ]
        , onClick <|
            if isMyTurn then
                Move game row column
            else
                NoOp
        ]
        [ text "" ]


hostTileView : Html Msg
hostTileView =
    div [ classes [ BoardTile, BoardTile_Host ] ]
        [ iconView "close" ]


challengerTileView : Html Msg
challengerTileView =
    div [ classes [ BoardTile, BoardTile_Challenger ] ]
        [ iconView "circle-outline" ]


iconView : String -> Html msg
iconView name =
    Svg.svg [ svgClass Icon ]
        [ Svg.use [ Svg.xlinkHref <| "#" ++ name ] [] ]
