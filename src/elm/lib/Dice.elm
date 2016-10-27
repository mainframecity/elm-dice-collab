module Lib.Dice exposing (..)

import Random
import Json.Decode
import Html.Events

type DiceType
  = D4
  | D6
  | D8
  | D10
  | D12
  | D20

rollDice : DiceType -> Random.Generator Int
rollDice diceType =
  case diceType of
    D4 -> (Random.int 1 4)
    D6 -> (Random.int 1 6)
    D8 -> (Random.int 1 8)
    D10 -> (Random.int 1 10)
    D12 -> (Random.int 1 12)
    D20 -> (Random.int 1 20)

diceDecoder : Json.Decode.Decoder DiceType
diceDecoder =
  Html.Events.targetValue `Json.Decode.andThen` \val ->
    case val of
      "D4" -> Json.Decode.succeed D4
      "D6" -> Json.Decode.succeed D6
      "D8" -> Json.Decode.succeed D8
      "D10" -> Json.Decode.succeed D10
      "D12" -> Json.Decode.succeed D12
      "D20" -> Json.Decode.succeed D20
      _ -> Json.Decode.fail ("Invalid DiceType: " ++ val)

diceTypeDecoder : String -> Json.Decode.Decoder DiceType
diceTypeDecoder val =
    case val of
      "D4" -> Json.Decode.succeed D4
      "D6" -> Json.Decode.succeed D6
      "D8" -> Json.Decode.succeed D8
      "D10" -> Json.Decode.succeed D10
      "D12" -> Json.Decode.succeed D12
      "D20" -> Json.Decode.succeed D20
      _ -> Json.Decode.fail ("Invalid DiceType: " ++ val)
