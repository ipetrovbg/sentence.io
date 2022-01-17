module NotFound exposing (..)

import Element
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Html exposing (Html)
import Utils


link =
    Element.rgb255 6 66 235


white =
    Element.rgb255 242 242 242


error =
    Element.rgb255 162 16 43


purple =
    Element.rgb255 115 11 217


view : Html msg
view =
    Element.layout []
        (Element.column
            [ Element.height Element.fill
            , Element.centerX
            , Element.centerY
            , Element.spacing 16
            ]
            [ Element.el
                [ Element.centerY
                , Element.centerX
                , Font.size 220
                , Font.color error
                , Region.heading 1
                , Font.extraBold
                ]
              <|
                Element.text "404"
            , Element.el
                [ Element.centerY
                , Element.centerX
                ]
              <|
                Element.text "Oops! Page not found."
            , Element.link
                [ Element.centerY
                , Element.centerX
                , Font.size 14
                , Font.color link
                , Font.bold
                ]
                { url = "/"
                , label = Element.text "Go Home"
                }
            ]
        )
