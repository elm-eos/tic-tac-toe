module Eos.Ecc.Data exposing (..)

import Eos.Ecc.Internal as Internal


type Signature
    = Signature String


signatureToString : Signature -> String
signatureToString (Signature str) =
    str


signatureFromString : String -> Signature
signatureFromString =
    Signature


type PublicKey
    = PublicKey String


publicKeyToString : PublicKey -> String
publicKeyToString (PublicKey str) =
    str


publicKeyFromString : String -> Result String PublicKey
publicKeyFromString str =
    if Internal.isValidPublicKey str then
        Ok <| PublicKey str
    else
        Err <| "Invalid public key '" ++ str ++ "'"


type PrivateKey
    = PrivateKey String


privateKeyToString : PrivateKey -> String
privateKeyToString (PrivateKey str) =
    str


privateKeyFromString : String -> Result String PrivateKey
privateKeyFromString str =
    if Internal.isValidPrivateKey str then
        Ok <| PrivateKey str
    else
        Err <| "Invalid private key '" ++ str ++ "'"
