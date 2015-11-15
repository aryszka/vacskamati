module DoubleTest where

import ElmTest.Test exposing (Test, suite, test)
import ElmTest.Assertion exposing (assertEqual)
import Double exposing (double)

tests : Test
tests = suite "Double"
    [ test "doubles positive" <| assertEqual (double 21) 42
    , test "doubles negative" <| assertEqual (double -21) -42
    ]
