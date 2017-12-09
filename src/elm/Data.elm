module Data exposing (..)

import Dict exposing (Dict)
import Eos.Data as Eos
import Eos.Ecc.Data as Eos


type alias Flags =
    { httpEndpoint : Maybe String
    , contractAccount : Eos.AccountName
    , contractCode : String
    , contractAbi : String
    }


type alias Model =
    { httpEndpoint : String
    , status : Status
    , contractAccount : Eos.AccountName
    , contractCode : String
    , contractAbi : String
    , inputs : Dict String String
    }


emptyModel : Model
emptyModel =
    { httpEndpoint = ""
    , status = CheckingHttpEndpoint
    , contractAccount = Eos.AccountName ""
    , contractCode = ""
    , contractAbi = ""
    , inputs = Dict.empty
    }


initialModel : Flags -> Model
initialModel flags =
    { emptyModel
        | httpEndpoint = Maybe.withDefault localEndpoint flags.httpEndpoint
        , contractAccount = flags.contractAccount
        , contractCode = flags.contractCode
        , contractAbi = flags.contractAbi
    }


localEndpoint : String
localEndpoint =
    "http://127.0.0.1:8888"


type Status
    = CheckingHttpEndpoint
    | HttpEndpointOffline
    | ContractAccountNotCreated
    | CreatingContractAccount Eos.AccountName Eos.PrivateKey
    | ErrorCreatingContractAccount Eos.Error
    | ContractCodeNotSet
    | SettingContractCode Eos.PrivateKey
    | ErrorSettingContractCode Eos.Error
    | LoggedOut
    | InvalidCredentials String
    | CreatingAccount Eos.AccountName Eos.AccountName Eos.PrivateKey
    | LoggedIn Account


type alias Account =
    { name : Eos.AccountName
    , privateKey : Eos.PrivateKey
    , currentGame : Maybe Game
    , games : List Game
    }


type alias Game =
    { challenger : Eos.AccountName
    , host : Eos.AccountName
    , turn : Eos.AccountName
    , winner : Eos.AccountName
    , board : Board
    }


type alias Board =
    { topLeft : Tile
    , topCenter : Tile
    , topRight : Tile
    , centerLeft : Tile
    , centerCenter : Tile
    , centerRight : Tile
    , bottomLeft : Tile
    , bottomCenter : Tile
    , bottomRight : Tile
    }


type Tile
    = OpenTile
    | HostTile
    | ChallengerTile


emptyBoard : Board
emptyBoard =
    { topLeft = OpenTile
    , topCenter = OpenTile
    , topRight = HostTile
    , centerLeft = OpenTile
    , centerCenter = HostTile
    , centerRight = OpenTile
    , bottomLeft = ChallengerTile
    , bottomCenter = OpenTile
    , bottomRight = ChallengerTile
    }


type Action
    = CreateAction CreateFields
    | RestartAction RestartFields
    | CloseAction CloseFields
    | MoveAction MoveFields


type alias CreateFields =
    { challenger : Eos.AccountName
    , host : Eos.AccountName
    }


type alias RestartFields =
    { challenger : Eos.AccountName
    , host : Eos.AccountName
    , by : Eos.AccountName
    }


type alias CloseFields =
    { challenger : Eos.AccountName
    , host : Eos.AccountName
    }


type alias MoveFields =
    { challenger : Eos.AccountName
    , host : Eos.AccountName
    , by : Eos.AccountName
    , movement : Movement
    }


type alias Movement =
    { row : Int
    , column : Int
    }
