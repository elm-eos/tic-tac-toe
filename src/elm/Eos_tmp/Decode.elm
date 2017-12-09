module Eos.Decode exposing (..)

import Date exposing (Date)
import Eos.Data exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)


accountName : Decoder AccountName
accountName =
    customDecoder accountNameFromString string


permissionName : Decoder PermissionName
permissionName =
    map permissionNameFromString string


tableRows : Decoder row -> Decoder (TableRows row)
tableRows rowDecoder =
    decode TableRows
        |> required "rows" (list rowDecoder)
        |> required "more" bool


info : Decoder Info
info =
    decode Info
        |> required "server_version" string
        |> required "head_block_num" int
        |> required "last_irreversible_block_num" int
        |> required "head_block_id" string
        |> required "head_block_time" date
        |> required "head_block_producer" accountName
        |> required "recent_slots" string
        |> required "participation_rate" string


block : Decoder Block
block =
    decode Block
        |> required "previous" string
        |> required "timestamp" date
        |> required "trasaction_merkle_root" string
        |> required "producer" accountName
        |> required "producer_signature" string
        |> required "id" string
        |> required "block_num" int
        |> required "ref_block_prefix" int


account : Decoder Account
account =
    decode Account
        |> required "account_name" accountName
        |> required "eos_balance" string
        |> required "staked_balance" string
        |> required "unstaking_balance" string
        |> required "last_unstaking_time" date


code : Decoder Code
code =
    decode Code
        |> required "account_name" accountName
        |> required "code_hash" string
        |> required "wast" string


pushedCode : Decoder PushedCode
pushedCode =
    decode PushedCode
        |> required "account" accountName
        |> required "vm_type" int
        |> required "vm_version" int
        |> required "code" string



-- |> required "code_abi" string


message : (String -> Decoder data) -> Decoder (Message data)
message data =
    decode Message
        |> required "code" accountName
        |> required "type" string
        |> required "authorization" (list accountPermission)
        |> custom
            (field "type" string
                |> andThen (\type_ -> field "data" <| data type_)
            )


accountPermission : Decoder AccountPermission
accountPermission =
    decode AccountPermission
        |> required "account" accountName
        |> required "permission" permissionName


transaction : (String -> Decoder data) -> Decoder (Transaction data)
transaction data =
    decode Transaction
        |> required "ref_block_num" int
        |> required "ref_block_prefix" int
        |> required "expiration" date
        |> required "scope" (list accountName)
        |> required "messages" (list <| message data)
        |> required "signatures" (list string)


pushedTransaction : (String -> Decoder data) -> Decoder (PushedTransaction data)
pushedTransaction data =
    decode PushedTransaction
        |> required "transaction_id" string
        |> required "transaction" (transaction data)


createdAccount : Decoder CreatedAccount
createdAccount =
    decode CreatedAccount
        |> required "creator" accountName
        |> required "name" accountName
        |> required "deposit" string



-- UTILS


date : Decoder Date
date =
    customDecoder Date.fromString string


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
