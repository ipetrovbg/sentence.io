module Utils exposing (edges, perform)

import Task


edges =
    { top = 16
    , right = 16
    , bottom = 16
    , left = 16
    }


perform : msg -> Cmd msg
perform =
    Task.perform identity << Task.succeed
