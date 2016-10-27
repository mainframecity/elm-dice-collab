module Model exposing (Model, Roll, initialModel)

import Phoenix.Socket

import Lib.Dice exposing (..)
import Msg exposing (..)

type alias Roll =
  { username: String
  , diceType: DiceType
  , diceRoll: Int
  }

type alias Model =
  { dieFace : Int
  , diceType : DiceType
  , history : List Roll
  , phxSocket : Phoenix.Socket.Socket Msg
  , isConnected : Bool
  , username : String
  , usernameTextfield : String
  }

initialModel : Model
initialModel =
  { dieFace = 1
  , diceType = D4
  , history = []
  , phxSocket = Phoenix.Socket.init "ws://localhost:4000/socket/websocket"
  , isConnected = False
  , username = "Unnamed"
  , usernameTextfield = ""
  }
