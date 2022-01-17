module NotFound exposing (..)

import Element
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import Utils


blue =
    Element.rgb255 26 48 92


white =
    Element.rgb255 242 242 242


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
            [ Element.el [ Element.centerY, Element.centerX, Font.size 220 ] <| Element.text "404"
            , Element.el [ Element.centerY, Element.centerX ] <| Element.text "Page not found."
            , Element.link [ Font.underline, Element.centerY, Element.centerX ]
                { url = "/"
                , label = Element.text "Go Home"
                }

            --, Input.button
            --    [ Background.color blue
            --    , Border.rounded 8
            --
            --    --, Element.focused [ Background.color purple ]
            --    , Element.paddingEach Utils.edges
            --    , Font.color white
            --    ]
            --    { onPress = Nothing
            --    , label = Element.text "My Button"
            --    }
            ]
        )
