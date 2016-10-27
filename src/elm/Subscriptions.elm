module Subscriptions exposing (subscriptions)

import Phoenix.Socket
import Phoenix.Channel
import Phoenix.Push

import Model exposing (Model)
import Msg exposing (..)

subscriptions : Model -> Sub Msg
subscriptions model =
  Phoenix.Socket.listen model.phxSocket PhoenixMsg
