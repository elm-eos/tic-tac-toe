module Decode exposing (..)

import Data exposing (..)
import Eos.Decode exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)


flags : Decoder Flags
flags =
    decode Flags
        |> optional "httpEndpoint" (maybe string) Nothing
        |> required "contractAccount" accountName
        |> required "contractCode" string
        |> required "contractAbi" string


game : Decoder Game
game =
    decode Game
        |> required "challenger" accountName
        |> required "host" accountName
        |> required "turn" accountName
        |> required "winner" accountName
        |> required "board" board


board : Decoder Board
board =
    decode Board
        |> custom (index 0 tile)
        |> custom (index 1 tile)
        |> custom (index 2 tile)
        |> custom (index 3 tile)
        |> custom (index 4 tile)
        |> custom (index 5 tile)
        |> custom (index 6 tile)
        |> custom (index 7 tile)
        |> custom (index 8 tile)


tile : Decoder Tile
tile =
    andThen
        (\i ->
            if i == 0 then
                succeed OpenTile
            else if i == 1 then
                succeed HostTile
            else if i == 2 then
                succeed ChallengerTile
            else
                fail <| "Invalid tile number '" ++ Basics.toString i ++ "'"
        )
        int


action : String -> Decoder Action
action type_ =
    case String.toLower type_ of
        "create" ->
            map CreateAction createFields

        "restart" ->
            map RestartAction restartFields

        "close" ->
            map CloseAction closeFields

        "move" ->
            map MoveAction moveFields

        _ ->
            fail <| "Invalid action type '" ++ type_ ++ "'"


createFields : Decoder CreateFields
createFields =
    decode CreateFields
        |> required "challenger" accountName
        |> required "host" accountName


restartFields : Decoder RestartFields
restartFields =
    decode RestartFields
        |> required "challenger" accountName
        |> required "host" accountName
        |> required "by" accountName


closeFields : Decoder CloseFields
closeFields =
    decode CloseFields
        |> required "challenger" accountName
        |> required "host" accountName


moveFields : Decoder MoveFields
moveFields =
    decode MoveFields
        |> required "challenger" accountName
        |> required "host" accountName
        |> required "by" accountName
        |> required "movement" movement


movement : Decoder Movement
movement =
    decode Movement
        |> required "row" int
        |> required "column" int
