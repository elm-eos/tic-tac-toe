module Eos exposing (..)

import Eos.Data exposing (..)
import Eos.Decode as Decode
import Eos.Ecc.Data exposing (..)
import Eos.Encode as Encode
import Eos.Internal as Internal
import Erl
import Http
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import Set
import Task exposing (Task)


getInfo :
    { httpEndpoint : String }
    -> Task Error Info
getInfo { httpEndpoint } =
    httpRequest
        { method = "GET"
        , httpEndpoint = httpEndpoint
        , pathSegments = [ "v1", "chain", "get_info" ]
        , body = Nothing
        , decoder = Decode.info
        }


getBlock :
    { httpEndpoint : String
    , blockNumOrId : String
    }
    -> Task Error Block
getBlock { httpEndpoint, blockNumOrId } =
    Internal.request
        { httpEndpoint = httpEndpoint
        , privateKeys = []
        , method = "getBlock"
        , params =
            [ Encode.object [ ( "block_num_or_id", Encode.string blockNumOrId ) ] ]
        , decoder = Decode.block
        }


getAccount :
    { httpEndpoint : String
    , accountName : AccountName
    }
    -> Task Error Account
getAccount { httpEndpoint, accountName } =
    Internal.request
        { httpEndpoint = httpEndpoint
        , privateKeys = []
        , method = "getAccount"
        , params =
            [ Encode.object [ ( "account_name", Encode.accountName accountName ) ] ]
        , decoder = Decode.account
        }


getTableRows :
    { httpEndpoint : String
    , scope : AccountName
    , code : AccountName
    , table : TableName
    , rowDecoder : Decoder row
    }
    -> Task Error (TableRows row)
getTableRows { httpEndpoint, scope, code, table, rowDecoder } =
    Internal.request
        { httpEndpoint = httpEndpoint
        , privateKeys = []
        , method = "getTableRows"
        , params =
            [ Encode.object
                [ ( "json", Encode.bool True )
                , ( "scope", Encode.accountName scope )
                , ( "code", Encode.accountName code )
                , ( "table", Encode.tableName table )
                ]
            ]
        , decoder = Decode.tableRows rowDecoder
        }


getCode :
    { httpEndpoint : String
    , accountName : AccountName
    }
    -> Task Error Code
getCode { httpEndpoint, accountName } =
    Internal.request
        { httpEndpoint = httpEndpoint
        , privateKeys = []
        , method = "getCode"
        , params =
            [ Encode.object
                [ ( "account_name", Encode.accountName accountName ) ]
            ]
        , decoder = Decode.code
        }


newAccount :
    { httpEndpoint : String
    , privateKeys : List PrivateKey
    , creator : AccountName
    , name : AccountName
    , owner : AccountName
    , active : AccountName
    , recovery : AccountName
    , deposit : String
    }
    -> Task Error (PushedTransaction CreatedAccount)
newAccount o =
    Internal.request
        { httpEndpoint = o.httpEndpoint
        , privateKeys = o.privateKeys
        , method = "newaccount"
        , params =
            [ Encode.object
                [ ( "creator", Encode.accountName o.creator )
                , ( "name", Encode.accountName o.name )
                , ( "owner", Encode.accountName o.owner )
                , ( "active", Encode.accountName o.active )
                , ( "recovery", Encode.accountName o.recovery )
                , ( "deposit", Encode.string o.deposit )
                ]
            ]
        , decoder = Decode.pushedTransaction (\_ -> Decode.createdAccount)
        }


setCode :
    { httpEndpoint : String
    , privateKeys : List PrivateKey
    , account : AccountName
    , vmType : Int
    , vmVersion : Int
    , code : String
    , codeAbi : String
    }
    -> Task Error (PushedTransaction PushedCode)
setCode o =
    Internal.request
        { httpEndpoint = o.httpEndpoint
        , privateKeys = o.privateKeys
        , method = "setcode"
        , params =
            [ Encode.object
                [ ( "account", Encode.accountName o.account )
                , ( "vm_type", Encode.int o.vmType )
                , ( "vm_version", Encode.int o.vmVersion )
                , ( "code", Encode.string o.code )
                , ( "code_abi", Encode.string o.codeAbi )
                ]
            ]
        , decoder = Decode.pushedTransaction (\_ -> Decode.pushedCode)
        }


pushTransaction :
    { httpEndpoint : String
    , privateKeys : List PrivateKey
    , scope : List AccountName
    , messages : List (Message data)
    , encodeData : data -> Value
    , dataDecoder : String -> Decoder data
    }
    -> Task Error (PushedTransaction data)
pushTransaction o =
    Internal.request
        { httpEndpoint = o.httpEndpoint
        , privateKeys = o.privateKeys
        , method = "transaction"
        , params =
            [ Encode.object
                [ ( "scope"
                  , o.scope
                        |> List.map accountNameToString
                        |> Set.fromList
                        |> Set.toList
                        |> List.sort
                        |> List.map Encode.string
                        |> Encode.list
                  )
                , ( "messages"
                  , Encode.list <|
                        List.map (Encode.message o.encodeData) o.messages
                  )
                ]
            ]
        , decoder = Decode.pushedTransaction o.dataDecoder
        }


httpRequest :
    { method : String
    , httpEndpoint : String
    , pathSegments : List String
    , body : Maybe Value
    , decoder : Decoder a
    }
    -> Task Error a
httpRequest r =
    { method = r.method
    , headers = []
    , url =
        r.httpEndpoint
            |> Erl.parse
            |> Erl.appendPathSegments r.pathSegments
            |> Erl.toString
    , body =
        case r.body of
            Just value ->
                Http.jsonBody value

            Nothing ->
                Http.emptyBody
    , expect = Http.expectJson r.decoder
    , timeout = Nothing
    , withCredentials = False
    }
        |> Http.request
        |> Http.toTask
        |> Task.mapError httpError
