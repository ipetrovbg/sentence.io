module Main exposing (..)

import Browser exposing (Document)
import Browser.Navigation exposing (Key)
import Html
import Types exposing (Flags, Model, Msg(..))
import Url exposing (Url)


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url navKey =
    ( (), Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( (), Cmd.none )


view : Model -> Document Msg
view model =
    { title = "Sentence.io"
    , body = [ Html.text "Hello Sentence.io" ]
    }


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = ClickLink
        , onUrlChange = ChangeUrl
        }
