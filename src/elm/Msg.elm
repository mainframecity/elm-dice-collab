module Msg exposing (..)

import Phoenix.Socket
import Json.Encode as JE

import Lib.Dice exposing (DiceType)

type Msg
  = Roll
  | SetDice DiceType
  | NewFace Int
  | SetUsername String
  | SubmitUsername
  | WSReceiveRoll JE.Value
  | PhoenixMsg (Phoenix.Socket.Msg Msg)
