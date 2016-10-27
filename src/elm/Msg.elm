module Msg exposing (..)

import Lib.Dice exposing (DiceType)

type Msg
  = Roll
  | SetDice DiceType
  | NewFace Int
