module Eos.Ecc.Internal exposing (..)

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import Native.Eos.Ecc


type alias SyncConfig a =
    { method : String
    , params : List Value
    , decoder : Decoder a
    }


callSync : SyncConfig a -> a
callSync { method, params, decoder } =
    Native.Eos.Ecc.callSync
        { method = method
        , params = Encode.list params
        , toResult = Decode.decodeString decoder
        }


isValidPrivateKey : String -> Bool
isValidPrivateKey str =
    callSync
        { method = "isValidPrivate"
        , params = [ Encode.string str ]
        , decoder = Decode.bool
        }


isValidPublicKey : String -> Bool
isValidPublicKey str =
    callSync
        { method = "isValidPublic"
        , params = [ Encode.string str ]
        , decoder = Decode.bool
        }
