module Utils.SentenceParser exposing (..)

import Parser exposing ((|.), (|=), Parser, Step(..), backtrackable, chompIf, chompUntil, chompUntilEndOr, chompWhile, getChompedString, loop, oneOf, succeed, symbol)
import Types exposing (ValidWord(..))


isIgnorable : Char -> Bool
isIgnorable =
    not << Char.isAlphaNum



--numericWord : Parser ValidWord
--numericWord =
--    succeed Numeric
--        |. chompWhile isIgnorable
--        |= (getChompedString <|
--                succeed identity
--                    |. chompIf Char.isDigit
--                    |. chompWhile Char.isDigit
--           )
--        |. chompWhile isIgnorable


whitespace : Parser ()
whitespace =
    chompWhile (\c -> c == ' ')


contraction : Parser (Maybe String)
contraction =
    (getChompedString <|
        succeed identity
            |. chompIf ((==) '\'')
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


isValidCharSeparator : Char -> Bool
isValidCharSeparator char =
    char == ',' || char == '.' || char == ':'


isValidPunctuationSeparator : Char -> Bool
isValidPunctuationSeparator char =
    char
        == '!'
        || char
        == '.'
        || char
        == '?'
        || char
        == ','


contractionWithCharSeparator : Parser (Maybe String)
contractionWithCharSeparator =
    (getChompedString <|
        succeed identity
            |. chompIf isValidCharSeparator
            |. chompIf Char.isDigit
            |. chompWhile Char.isDigit
    )
        |> Parser.map Just


charSeparatedNumWord : Parser ValidWord
charSeparatedNumWord =
    succeed Numeric
        |. chompWhile isIgnorable
        |= (getChompedString <|
                succeed identity
                    |. chompIf Char.isDigit
                    |. chompWhile Char.isDigit
           )
        |= oneOf [ backtrackable contractionWithCharSeparator, succeed Nothing ]
        |. chompWhile isIgnorable


wordWithPunctuationHelper : Parser String
wordWithPunctuationHelper =
    getChompedString <|
        succeed identity
            |. chompIf isValidPunctuationSeparator


wordWithPunctuation : Parser ValidWord
wordWithPunctuation =
    succeed WordWithPunctuation
        |. chompWhile isIgnorable
        |= (getChompedString <|
                succeed identity
                    |. chompIf Char.isAlphaNum
                    |. chompWhile Char.isAlpha
                    |. whitespace
           )
        |= backtrackable wordWithPunctuationHelper
        |. chompWhile isIgnorable


validWordHelper : List ValidWord -> Parser (Step (List ValidWord) (List ValidWord))
validWordHelper revValidWords =
    oneOf
        [ succeed (\vw -> Loop (vw :: revValidWords))
            |= oneOf
                [ backtrackable charSeparatedNumWord
                , backtrackable wordWithPunctuation
                , backtrackable alphabeticWord
                ]
        , succeed () |> Parser.map (\_ -> Done (List.reverse revValidWords))
        ]


validWord : Parser (List ValidWord)
validWord =
    loop [] validWordHelper



--|> Parser.map (List.map validWordToString)
