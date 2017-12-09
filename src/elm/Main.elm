module Main exposing (..)

import Data exposing (Model)
import Html
import Json.Decode exposing (Value)
import State exposing (Msg, init, subscriptions, update)
import View exposing (view)


main : Program Value Model Msg
main =
    Html.programWithFlags
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
