module Utils.Color exposing (..)

import Element


primary =
    Element.rgb255 7 79 222


white =
    Element.rgb255 242 242 242


error =
    Element.rgb255 162 16 43


lightPrimary =
    light primary 0.3


gray =
    Element.rgb255 203 203 203


light color to =
    Element.toRgb color
        |> (\c -> Element.fromRgb { c | alpha = to })
