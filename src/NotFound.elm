module NotFound exposing (..)

import Element
import Element.Font as Font
import Element.Region as Region
import Html exposing (Html)
import Utils.Color as Color


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
                , Font.color Color.error
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
                , Font.color Color.primary
                , Font.bold
                ]
                { url = "/"
                , label = Element.text "Go Home"
                }
            ]
        )
