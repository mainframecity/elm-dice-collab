module Components.History.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Model exposing (Model)
import Msg exposing (Msg)

import Lib.Dice exposing (..)

view : Model -> Html Msg
view model =
    div [ class "historyComponent" ]
        (List.map
            (\roll ->
                li [ class "historyRoll" ]
                    [ p [ class "username" ] [ text (toString roll.username) ]
                    , p [ class "diceRoll" ] [ text (toString roll.diceRoll) ]
                    , p [ class "diceType" ] [ text (toString roll.diceType) ]
                    ]
            )
            model.history
        )
