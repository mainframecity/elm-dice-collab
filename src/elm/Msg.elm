module Msg exposing (..)

import Lib.Dice exposing (DiceType)
import Phoenix.Socket

type Msg
  = Roll
  | SetDice DiceType
  | NewFace Int
  | SetUsername String
  | SubmitUsername
  | PhoenixMsg (Phoenix.Socket.Msg Msg)
