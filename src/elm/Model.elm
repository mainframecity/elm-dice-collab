module Model exposing (Model, initialModel)

import Lib.Dice exposing (..)

type alias Model =
  { dieFace : Int
  , diceType : DiceType
  , history : List Int
  }

initialModel =
  { dieFace = 1
  , diceType = D6
  , history = []
  }
