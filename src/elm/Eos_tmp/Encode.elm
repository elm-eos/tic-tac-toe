module Eos.Encode exposing (..)

import Eos.Data as Eos
import Json.Encode exposing (..)


accountName : Eos.AccountName -> Value
accountName =
    Eos.accountNameToString >> string


permissionName : Eos.PermissionName -> Value
permissionName =
    Eos.permissionNameToString >> string


message : (data -> Value) -> Eos.Message data -> Value
message encodeData msg =
    object
        [ ( "code", accountName msg.code )
        , ( "type", string msg.type_ )
        , ( "authorization", list <| List.map accountPermission msg.authorization )
        , ( "data", encodeData msg.data )
        ]


accountPermission : Eos.AccountPermission -> Value
accountPermission { account, permission } =
    object
        [ ( "account", accountName account )
        , ( "permission", permissionName permission )
        ]


tableName : Eos.TableName -> Value
tableName =
    Eos.tableNameToString >> string
