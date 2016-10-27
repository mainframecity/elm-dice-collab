module Msg exposing (..)

import Lib.Dice exposing (DiceType)
import Phoenix.Socket

type Msg
  = Roll
  | SetDice DiceType
  | NewFace Int
  | PhoenixMsg (Phoenix.Socket.Msg Msg)
