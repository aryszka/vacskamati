module App where

import Html exposing (text)
import Signal

double : Int -> Int
double x = x + x

port testOut : Signal Int
port testOut = Signal.map double testIn

port testIn : Signal Int

main : Html.Html
main = text "Hello, world!"
