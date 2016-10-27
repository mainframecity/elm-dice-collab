module Components.History.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)

import Model exposing (Model)
import Msg exposing (Msg)

view : Model -> Html Msg
view model =
  div [class "historyComponent"] (
    List.map (\(diceType, diceRoll) ->
      li [class "historyRoll"] [
                                 p [class "diceRoll"] [ text (toString diceRoll) ]
                               , p [class "diceType"] [ text (toString diceType) ]
                               ]
    ) model.history
  )
