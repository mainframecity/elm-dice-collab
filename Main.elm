import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Random
import Json.Decode

import Model exposing (Model, initialModel)
import Msg exposing (..)
import Subscriptions exposing (subscriptions)

import Lib.Dice exposing (..)

import Components.History.View

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL

viewOption : DiceType -> Html Msg
viewOption diceType =
  option
    [ value <| toString diceType ]
    [ text <| toString diceType ]

init : (Model, Cmd Msg)
init =
  (initialModel, Cmd.none)

addHistory : List Int -> Int -> List Int
addHistory history newRoll =
  if List.length history == 10 then
     newRoll :: (List.take 9 history)
  else
    newRoll :: history

-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    SetDice diceType ->
      ({ model | diceType = diceType }, Cmd.none)

    Roll ->
      (model, Random.generate NewFace (rollDice model.diceType))

    NewFace newFace ->
      ({ model | dieFace = newFace, history = addHistory model.history newFace }, Cmd.none)

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ h1 [] [ text (toString model.dieFace) ]
    , button [ onClick Roll ] [ text "Roll" ]
    , select [ on "change" (Json.Decode.map SetDice diceDecoder) ]
      [ viewOption D6
      , viewOption D10
      , viewOption D20
      ]
    , Components.History.View.view model
    ]
