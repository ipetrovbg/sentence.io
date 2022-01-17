module Router exposing (..)

import Task exposing (perform)
import Types exposing (Msg(..), Route(..))
import Url exposing (Url)
import Url.Parser exposing (Parser, map, oneOf, parse, s, top)


routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map HomeRoute top
        , map HomeRoute (s "home")
        ]


urlToCmd : Url -> Cmd Msg
urlToCmd url =
    case parse routeParser url of
        Just HomeRoute ->
            Cmd.none

        _ ->
            Cmd.none
