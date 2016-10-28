import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Json.Decode as JD
import Random

import Phoenix.Socket

import Model exposing (Model, initialModel)
import Msg exposing (..)
import Subscriptions exposing (subscriptions)

import Css.Main
import Lib.Dice exposing (..)
import Lib.Websocket as Websocket

import Components.History.View

main : Program Never
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

-- Initially connect to the 'room:lobby' channel.
init : (Model, Cmd Msg)
init =
  let
    (phxSocket, phxCmd) = Websocket.joinChannel initialModel.phxSocket "room:lobby"
  in
    ({ initialModel | phxSocket = Websocket.bindSocket phxSocket }
    , Cmd.map PhoenixMsg phxCmd
    )

addHistory : List LoggedRoll -> LoggedRoll -> List LoggedRoll
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
      ( { model | diceType = diceType }
      , Cmd.none
      )

    Msg.Roll ->
      ( model
      , Random.generate NewFace (rollDice model.diceType)
      )

    NewFace newFace ->
      let
        model = { model | dieFace = newFace }
        (phxSocket, phxCmd) = Websocket.pushNewRoll model
      in
        ( { model | phxSocket = phxSocket }
        , Cmd.map PhoenixMsg phxCmd
        )

    PhoenixMsg msg ->
      let
        ( phxSocket, phxCmd ) = Phoenix.Socket.update msg model.phxSocket
      in
        ( { model | phxSocket = phxSocket }
        , Cmd.map PhoenixMsg phxCmd
        )

    SetUsername username ->
      ( { model | usernameTextfield = username }
      , Cmd.none
      )

    SubmitUsername ->
      let
        (phxSocket, phxCmd) = Websocket.submitUsername model.phxSocket model.usernameTextfield
      in
        ({model | phxSocket = phxSocket, username = model.usernameTextfield}, Cmd.map PhoenixMsg phxCmd)

    WSReceiveRoll raw ->
      case JD.decodeValue loggedRollDecoder raw of
        Ok roll ->
          ( { model | history = addHistory model.history roll }
          , Cmd.none
          )
        Err error ->
          (model, Cmd.none)

-- VIEW

view : Model -> Html Msg
view model =
  div [ (class "diceRollerContainer"), (Css.Main.toCss Css.Main.mainWrapperStyle) ]
    [ h1 [ ] [ text (toString model.dieFace) ]
    , button [ (Css.Main.toCss Css.Main.buttonStyle), (onClick Msg.Roll) ] [ text "Roll" ]
    , select [ (Css.Main.toCss Css.Main.selectStyle), (on "change" (JD.map SetDice diceDecoder)) ]
      [ viewOption D4
      , viewOption D6
      , viewOption D8
      , viewOption D10
      , viewOption D12
      , viewOption D20
      ]
    , div [class "usernameForm"]
      [ div [class "usernameDisplay"] [ text ("Username: " ++ model.username) ]
      , div [class "usernameInput"]
        [ input [ placeholder "Username", onInput SetUsername ] []
        , button [ (Css.Main.toCss Css.Main.buttonStyle), (onClick SubmitUsername) ] [ text "Set Username" ]
        ]
      ]
    , Components.History.View.view model
    ]
