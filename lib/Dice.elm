module Lib.Dice exposing (..)

import Random
import Json.Decode
import Html.Events

type DiceType
  = D6
  | D10
  | D20

rollDice : DiceType -> Random.Generator Int
rollDice diceType =
  case diceType of
    D6 -> (Random.int 1 6)
    D10 -> (Random.int 1 10)
    D20 -> (Random.int 1 20)

diceDecoder : Json.Decode.Decoder DiceType
diceDecoder =
  Html.Events.targetValue `Json.Decode.andThen` \val ->
    case val of
      "D6" -> Json.Decode.succeed D6
      "D10" -> Json.Decode.succeed D10
      "D20" -> Json.Decode.succeed D20
      _ -> Json.Decode.fail ("Invalid DiceType: " ++ val)
