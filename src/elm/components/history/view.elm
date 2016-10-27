module Components.History.View exposing (view)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

import Css.Main
import Model exposing (Model)
import Msg exposing (Msg)

view : Model -> Html Msg
view model =
  div [class "historyComponent"] (List.map (\number -> h1 [] [ text (toString number) ]) model.history)
