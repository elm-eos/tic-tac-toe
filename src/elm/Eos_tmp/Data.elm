module Eos.Data exposing (..)

import Date exposing (Date)
import Http
import Regex
import Set


-- ERROR


type Error
    = Error String
    | HttpError Http.Error


httpError : Http.Error -> Error
httpError =
    HttpError



-- ACCOUNT NAME


type AccountName
    = AccountName String


accountNameToString : AccountName -> String
accountNameToString (AccountName str) =
    str


accountNameFromString : String -> Result String AccountName
accountNameFromString str =
    if String.length str > 13 then
        Err <| "Account name must be 13 characters or less"
    else
        let
            matches =
                str
                    |> Regex.find Regex.All (Regex.regex "[^a-zA-Z\\d\\.]")
                    |> List.map .match
                    |> Set.fromList
                    |> Set.toList
        in
        if List.length matches > 0 then
            Err <| "Account name contains invalid characters: " ++ String.join ", " matches
        else
            Ok <| AccountName str



-- PERMISSION NAME


type PermissionName
    = PermissionName String


permissionNameToString : PermissionName -> String
permissionNameToString (PermissionName str) =
    str


permissionNameFromString : String -> PermissionName
permissionNameFromString =
    PermissionName


active : PermissionName
active =
    permissionNameFromString "active"



-- MESSAGE


type alias Message data =
    { code : AccountName
    , type_ : String
    , authorization : List AccountPermission
    , data : data
    }


type alias AccountPermission =
    { account : AccountName
    , permission : PermissionName
    }



-- TABLE NAME


type TableName
    = TableName String


tableNameToString : TableName -> String
tableNameToString (TableName str) =
    str


tableNameFromString : String -> TableName
tableNameFromString =
    TableName



-- TABLE ROWS


type alias TableRows row =
    { rows : List row
    , more : Bool
    }



-- INFO


type alias Info =
    { serverVersion : String
    , headBlockNum : Int
    , lastIrreversibleBlockNum : Int
    , headBlockId : String
    , headBlockTime : Date
    , headBlockProducer : AccountName
    , recentSlots : String
    , participationRate : String
    }



-- ACCOUNT


type alias Account =
    { accountName : AccountName
    , eosBalance : String
    , stakedBalance : String
    , unstakingBalance : String
    , lastUnstakingTime : Date

    -- , permissions : List AccountPermission
    }


type alias Block =
    { previous : String
    , timestamp : Date
    , transactionMerkleRoot : String
    , producer : AccountName
    , producerSignature : String
    , id : String
    , blockNum : Int
    , refBlockPrefix : Int
    }



-- CODE


type alias Code =
    { accountName : AccountName
    , codeHash : String
    , wast : String

    -- abi
    }


type alias PushedCode =
    { account : AccountName
    , vmType : Int
    , vmVersion : Int
    , code : String

    -- , codeAbi : Value
    }



-- TRANSACTION


type alias Transaction data =
    { refBlockNum : Int
    , refBlockPrefix : Int
    , expiration : Date
    , scope : List AccountName

    --, readScope
    , messages : List (Message data)
    , signatures : List String
    }


type alias PushedTransaction data =
    { transactionId : String
    , transaction : Transaction data
    }


type alias CreatedAccount =
    { creator : AccountName
    , name : AccountName

    --, owner
    --, active
    --, recovery
    , deposit : String
    }
