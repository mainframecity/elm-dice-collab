module Lib.Websocket exposing (..)

import Json.Encode as JE

import Phoenix.Socket
import Phoenix.Push
import Phoenix.Channel

import Model exposing (Model)
import Msg exposing (..)

type alias PhxSocketWithCmd =
  ( Phoenix.Socket.Socket Msg, Cmd (Phoenix.Socket.Msg Msg) )

type alias PhxSocket =
  Phoenix.Socket.Socket Msg

-- Joins a Phoenix Channel when given a phxSocket.
joinChannel : PhxSocket -> String -> PhxSocketWithCmd
joinChannel phxSocket channelString =
  let
    channel =
      Phoenix.Channel.init channelString

    (phxSocket, phxCmd) = Phoenix.Socket.join channel phxSocket
  in
    (phxSocket, phxCmd)

-- Binds the socket for different event handlers.
bindSocket : PhxSocket -> PhxSocket
bindSocket phxSocket =
  phxSocket
    |> Phoenix.Socket.withDebug
    |> Phoenix.Socket.on "new:roll" "room:lobby" WSReceiveRoll

-- Sets username from a string
submitUsername : PhxSocket -> String -> PhxSocketWithCmd
submitUsername phxSocket name =
  let
    payload = (JE.object [ ("username", JE.string name) ])
    push' =
      Phoenix.Push.init "set:username" "room:lobby"
        |> Phoenix.Push.withPayload payload
    (phxSocket, phxCmd) = Phoenix.Socket.push push' phxSocket
  in
    (phxSocket, phxCmd)

-- Pushes a 'new:roll' message when given a model.
pushNewRoll : Model -> PhxSocketWithCmd
pushNewRoll model =
  let
    payload = (JE.object [ ("diceRoll", JE.int model.dieFace), ("diceType", JE.string (toString model.diceType)) ])
    push' =
      Phoenix.Push.init "new:roll" "room:lobby"
        |> Phoenix.Push.withPayload payload
    (phxSocket, phxCmd) = Phoenix.Socket.push push' model.phxSocket
  in
    (phxSocket, phxCmd)
