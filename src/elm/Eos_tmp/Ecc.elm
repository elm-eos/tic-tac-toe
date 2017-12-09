module Eos.Ecc exposing (..)

import Eos.Ecc.Data exposing (..)
import Eos.Ecc.Decode as Decode
import Eos.Ecc.Encode as Encode
import Eos.Ecc.Internal as Internal
import Json.Decode as Decode
import Json.Encode as Encode exposing (Value)
import Random exposing (Generator)


isValidPrivateKey : String -> Bool
isValidPrivateKey =
    Internal.isValidPrivateKey


isValidPublicKey : String -> Bool
isValidPublicKey =
    Internal.isValidPublicKey


privateToPublicKey : PrivateKey -> PublicKey
privateToPublicKey privateKey =
    Internal.callSync
        { method = "privateToPublic"
        , params = [ Encode.privateKey privateKey ]
        , decoder = Decode.publicKey
        }


seedPrivateKey : String -> PrivateKey
seedPrivateKey seed =
    Internal.callSync
        { method = "seedPrivate"
        , params = [ Encode.string seed ]
        , decoder = Decode.privateKey
        }


keyGenerator : Generator PrivateKey
keyGenerator =
    Random.map
        (List.map Basics.toString
            >> String.join "-"
            >> seedPrivateKey
        )
        (Random.list 10 <| Random.int Random.minInt Random.maxInt)


sign : PrivateKey -> Value -> Signature
sign privateKey data =
    Internal.callSync
        { method = "sign"
        , params =
            [ Encode.string <| Encode.encode 0 data
            , Encode.privateKey privateKey
            ]
        , decoder = Decode.signature
        }


verify : PublicKey -> Value -> Signature -> Bool
verify publicKey data signature =
    Internal.callSync
        { method = "verify"
        , params =
            [ Encode.signature signature
            , Encode.string <| Encode.encode 0 data
            , Encode.publicKey publicKey
            ]
        , decoder = Decode.bool
        }
