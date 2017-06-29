module Helpers exposing (..)

import Task


{-| Lift any value of type 'msg' to a 'Cmd msg'
-}
cmd : msg -> Cmd msg
cmd msg =
    Task.perform (always msg) (Task.succeed msg)
