module Main exposing (..)

import Browser exposing (Document)
import Browser.Navigation exposing (Key)
import Element
import Element.Font as Font
import Element.Region as Region
import Types exposing (Flags, Model, Msg(..))
import Url exposing (Url)
import Utils exposing (edges)


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url navKey =
    ( (), Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( (), Cmd.none )


layoutView =
    Element.layout [ Element.paddingEach edges ]
        (Element.row
            [ Region.heading 1
            , Font.size 24
            ]
            [ Element.text "Sentence.io"
            ]
        )


view : Model -> Document Msg
view model =
    { title = "Sentence.io"
    , body =
        [ layoutView ]
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
