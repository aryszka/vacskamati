module Test where

import ElmTest.Test exposing (..)
import ElmTest.Runner.Console exposing (runDisplay)
import IO.IO exposing (..)
import IO.Runner exposing (Request, Response, run)

-- [placeholder] test-imports.elm

console : IO ()
console = runDisplay tests

port requests : Signal Request
port requests = run responses console

port responses : Signal Response

tests : Test
tests = suite "UI" [
-- [placeholder] test-cases.elm
    ]
