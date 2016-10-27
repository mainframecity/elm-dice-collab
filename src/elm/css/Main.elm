module Css.Main exposing (..)

import Css exposing (..)
import Html.Attributes

toCss =
  Css.asPairs >> Html.Attributes.style

mainWrapperStyle =
  [ position relative
  , marginTop (pct 10)
  , marginLeft auto
  , marginRight auto
  , width (px 250)
  , textAlign center
  , verticalAlign center
  ]

buttonStyle =
  [ borderStyle none
  , height (px 26)
  , fontSize (px 11)
  , cursor pointer
  , color (hex "555")
  , backgroundColor transparent
  , border3 (px 1) solid (hex "bbb")
  , borderRadius (px 4)
  , paddingTop (px 0)
  , paddingBottom (px 0)
  , paddingLeft (px 30)
  , paddingRight (px 30)
  , margin (px 5)
  ]

selectStyle =
  [ height (px 38)
  , padding2 (px 6) (px 10)
  , backgroundColor (hex "fff")
  , border3 (px 1) solid (hex "d1d1d1")
  , borderRadius (px 4)
  , boxShadow none
  , boxSizing borderBox
  , margin (px 5)
  ]
