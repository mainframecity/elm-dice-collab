module Model exposing (Model, initialModel)

import Lib.Dice exposing (..)

type alias Model =
  { dieFace : Int
  , diceType : DiceType
  , history : List (DiceType, Int)
  }

initialModel : Model
initialModel =
  { dieFace = 1
  , diceType = D6
  , history = []
  }
