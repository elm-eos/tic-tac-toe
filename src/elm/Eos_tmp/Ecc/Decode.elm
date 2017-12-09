module Eos.Ecc.Decode exposing (..)

import Eos.Ecc.Data exposing (..)
import Json.Decode exposing (..)


publicKey : Decoder PublicKey
publicKey =
    customDecoder publicKeyFromString string


privateKey : Decoder PrivateKey
privateKey =
    customDecoder privateKeyFromString string


signature : Decoder Signature
signature =
    map signatureFromString string


customDecoder : (b -> Result String a) -> Decoder b -> Decoder a
customDecoder toResult decoder =
    andThen (toResult >> fromResult) decoder


fromResult : Result String a -> Decoder a
fromResult result =
    case result of
        Ok a ->
            succeed a

        Err msg ->
            fail msg
