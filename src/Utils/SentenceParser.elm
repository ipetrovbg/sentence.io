module Utils.SentenceParser exposing (..)

import Parser
    exposing
        ( (|.)
        , (|=)
        , Parser
        , Step(..)
        , backtrackable
        , chompIf
        , chompWhile
        , getChompedString
        , loop
        , oneOf
        , succeed
        )
import Types exposing (ValidWord(..))


isIgnorable : Char -> Bool
isIgnorable =
    not << Char.isAlphaNum


numericWord : Parser ValidWord
numericWord =
    succeed Numeric
        |. chompWhile isIgnorable
        |= (getChompedString <|
                succeed identity
                    |. chompIf Char.isDigit
                    |. chompWhile Char.isDigit
           )
        |. chompWhile isIgnorable


contraction : Parser (Maybe String)
contraction =
    (getChompedString <|
        succeed identity
            |. chompIf ((==) '\'')
            |. chompIf Char.isAlpha
            |. chompWhile Char.isAlpha
    )
        |> Parser.map Just


alphabeticWord : Parser ValidWord
alphabeticWord =
    succeed Alphabetic
        |. chompWhile isIgnorable
        |= (getChompedString <|
                succeed identity
                    |. chompIf Char.isAlphaNum
                    |. chompWhile Char.isAlpha
           )
        |= oneOf [ backtrackable contraction, succeed Nothing ]
        |. chompWhile isIgnorable


charSeparatedNumWord : Parser ValidWord
charSeparatedNumWord =
    succeed Alphabetic
        |. chompWhile isIgnorable
        |= (getChompedString <|
                succeed identity
                    |. chompIf Char.isDigit
                    |. chompWhile Char.isDigit
           )
        |= oneOf [ backtrackable contractionWithCharSeparator, succeed Nothing ]
        |. chompWhile isIgnorable


isValidCharSeparator : Char -> Bool
isValidCharSeparator char =
    char == ',' || char == '.' || char == ':'


contractionWithCharSeparator : Parser (Maybe String)
contractionWithCharSeparator =
    (getChompedString <|
        succeed identity
            |. chompIf isValidCharSeparator
            |. chompIf Char.isDigit
            |. chompWhile Char.isDigit
    )
        |> Parser.map Just


validWordHelper : List ValidWord -> Parser (Step (List ValidWord) (List ValidWord))
validWordHelper revValidWords =
    oneOf
        [ succeed (\vw -> Loop (vw :: revValidWords))
            |= oneOf
                [ backtrackable charSeparatedNumWord
                , backtrackable alphabeticWord
                , backtrackable numericWord
                ]
        , succeed () |> Parser.map (\_ -> Done (List.reverse revValidWords))
        ]


validWordToString : ValidWord -> String
validWordToString vw =
    case vw of
        Numeric word ->
            word

        Alphabetic word contraction_ ->
            contraction_
                |> Maybe.withDefault ""
                |> (++) word

        Punctuation char ->
            char


validWord : Parser (List String)
validWord =
    loop [] validWordHelper
        |> Parser.map (List.map validWordToString)
