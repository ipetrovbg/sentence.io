module HomePage exposing (..)

import Element
import Element.Font as Font
import Element.Region as Region
import Html exposing (Html)
import Types exposing (HomeModel, HomeMsg(..))
import Utils


init : () -> ( HomeModel, Cmd HomeMsg )
init _ =
    ( (), Cmd.none )


update : HomeMsg -> HomeModel -> ( HomeModel, Cmd HomeMsg )
update homeMsg homeModel =
    case homeMsg of
        NoOp ->
            ( homeModel, Cmd.none )


view : HomeModel -> Html HomeMsg
view model =
    Element.layout [ Element.paddingEach Utils.edges ]
        (Element.row
            [ Region.heading 1
            , Font.size 24
            ]
            [ Element.text "Sentence.io Home"
            ]
        )
