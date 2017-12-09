module Eos.Internal exposing (..)

import Eos.Data as Eos
import Eos.Ecc.Data as Ecc
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import Native.Eos
import Task exposing (Task)


type alias Request a =
    { httpEndpoint : String
    , privateKeys : List Ecc.PrivateKey
    , method : String
    , params : List Value
    , decoder : Decoder a
    }


request : Request a -> Task Eos.Error a
request r =
    Native.Eos.request
        { httpEndpoint = r.httpEndpoint
        , privateKeys = r.privateKeys
        , method = r.method
        , params = Encode.list r.params
        , toResult = Decode.decodeString r.decoder
        }
