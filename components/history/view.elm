module Components.History.View exposing (view)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)

import Model exposing (Model)
import Msg exposing (Msg)

view : Model -> Html Msg
view model =
  div [] (List.map (\number -> h1 [] [ text (toString number) ]) model.history)
