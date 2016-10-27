module Lib.Websocket exposing (..)

import Json.Encode as JE

import Phoenix.Socket
import Phoenix.Push
import Phoenix.Channel

import Model exposing (Model)
import Msg exposing (..)

-- Joins a Phoenix Channel when given a phxSocket.
joinChannel : Phoenix.Socket.Socket Msg -> String -> ( Phoenix.Socket.Socket Msg, Cmd (Phoenix.Socket.Msg Msg) )
joinChannel phxSocket channelString =
  let
    channel =
      Phoenix.Channel.init channelString

    (phxSocket, phxCmd) = Phoenix.Socket.join channel phxSocket
  in
    (phxSocket, phxCmd)

-- Pushes a 'new:roll' message when given a model.
pushNewRoll : Model -> ( Phoenix.Socket.Socket Msg, Cmd (Phoenix.Socket.Msg Msg) )
pushNewRoll model =
  let
    payload = (JE.object [ ("roll", JE.int model.dieFace), ("diceType", JE.string (toString model.diceType)) ])
    push' =
      Phoenix.Push.init "new:roll" "room:lobby"
        |> Phoenix.Push.withPayload payload
    (phxSocket, phxCmd) = Phoenix.Socket.push push' model.phxSocket
  in
    (phxSocket, phxCmd)
