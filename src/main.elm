module Main where

import Html exposing (text)
import Signal
import Double exposing (double)

port testOut : Signal Int
port testOut = Signal.map double testIn

port testIn : Signal Int

main : Html.Html
main = text "Hello, world!"
