module Lib.Dice exposing (..)

import Random
import Json.Decode as JD exposing ((:=))
import Html.Events

type DiceType
  = D4
  | D6
  | D8
  | D10
  | D12
  | D20

type alias LoggedRoll =
  { username: String
  , diceType: DiceType
  , diceRoll: Int
  }

loggedRollDecoder : JD.Decoder LoggedRoll
loggedRollDecoder =
  JD.object3 LoggedRoll
    ("username" := JD.string)
    ("diceType" := JD.string `JD.andThen` diceTypeDecoder)
    ("diceRoll" := JD.int)

rollDice : DiceType -> Random.Generator Int
rollDice diceType =
  case diceType of
    D4 -> (Random.int 1 4)
    D6 -> (Random.int 1 6)
    D8 -> (Random.int 1 8)
    D10 -> (Random.int 1 10)
    D12 -> (Random.int 1 12)
    D20 -> (Random.int 1 20)

diceDecoder : JD.Decoder DiceType
diceDecoder =
  Html.Events.targetValue `JD.andThen` \val ->
    case val of
      "D4" -> JD.succeed D4
      "D6" -> JD.succeed D6
      "D8" -> JD.succeed D8
      "D10" -> JD.succeed D10
      "D12" -> JD.succeed D12
      "D20" -> JD.succeed D20
      _ -> JD.fail ("Invalid DiceType: " ++ val)

diceTypeDecoder : String -> JD.Decoder DiceType
diceTypeDecoder val =
    case val of
      "D4" -> JD.succeed D4
      "D6" -> JD.succeed D6
      "D8" -> JD.succeed D8
      "D10" -> JD.succeed D10
      "D12" -> JD.succeed D12
      "D20" -> JD.succeed D20
      _ -> JD.fail ("Invalid DiceType: " ++ val)
