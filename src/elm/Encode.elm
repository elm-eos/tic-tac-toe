module Encode exposing (..)

import Data exposing (..)
import Eos.Encode exposing (..)
import Json.Encode exposing (..)


action : Action -> Value
action a =
    case a of
        CreateAction f ->
            createFields f

        RestartAction f ->
            restartFields f

        CloseAction f ->
            closeFields f

        MoveAction f ->
            moveFields f


createFields : CreateFields -> Value
createFields a =
    object
        [ ( "challenger", accountName a.challenger )
        , ( "host", accountName a.host )
        ]


restartFields : RestartFields -> Value
restartFields a =
    object
        [ ( "challenger", accountName a.challenger )
        , ( "host", accountName a.host )
        , ( "by", accountName a.by )
        ]


closeFields : CloseFields -> Value
closeFields a =
    object
        [ ( "challenger", accountName a.challenger )
        , ( "host", accountName a.host )
        ]


moveFields : MoveFields -> Value
moveFields a =
    object
        [ ( "challenger", accountName a.challenger )
        , ( "host", accountName a.host )
        , ( "by", accountName a.by )
        , ( "movement", movement a.movement )
        ]


movement : Movement -> Value
movement m =
    object
        [ ( "row", int m.row )
        , ( "column", int m.column )
        ]
