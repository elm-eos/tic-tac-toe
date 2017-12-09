module Eos.Ecc.Encode exposing (..)

import Eos.Ecc.Data exposing (..)
import Json.Encode exposing (..)


privateKey : PrivateKey -> Value
privateKey =
    privateKeyToString >> string


publicKey : PublicKey -> Value
publicKey =
    publicKeyToString >> string


signature : Signature -> Value
signature =
    signatureToString >> string
