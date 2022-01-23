module HomePage exposing (..)

import Element exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Html exposing (Html)
import Parser
import Types exposing (HomeModel, HomeMsg(..))
import Utils
import Utils.Color as Color
import Utils.SentenceParser as SentenceParser


initialRawString =
    "Usually he runs 4.5 kilometers a day."


init : () -> ( HomeModel, Cmd HomeMsg )
init _ =
    ( { rowString = initialRawString
      , selectedWord = Nothing
      , sentence = Err []
      }
    , Utils.perform (OnInputRawTextChange initialRawString)
    )


update : HomeMsg -> HomeModel -> ( HomeModel, Cmd HomeMsg )
update homeMsg homeModel =
    case homeMsg of
        SelectWord word ->
            ( { homeModel | selectedWord = Just word }, Cmd.none )

        OnInputRawTextChange input ->
            ( { homeModel
                | rowString = input
                , selectedWord = Nothing
                , sentence = Parser.run SentenceParser.validWord input
              }
            , Cmd.none
            )


view : HomeModel -> Html HomeMsg
view model =
    let
        edges =
            Utils.edges
    in
    Element.layout [ Element.paddingEach Utils.edges ]
        (Element.column [ Element.width Element.fill ]
            [ Element.row
                [ Element.paddingEach
                    { edges
                        | top = 16
                        , right = 16
                        , left = 0
                        , bottom = 16
                    }
                ]
                [ Input.multiline []
                    { onChange = OnInputRawTextChange
                    , text = model.rowString
                    , spellcheck = False
                    , placeholder =
                        Just
                            (Input.placeholder []
                                (Element.text "Type your sentence...")
                            )
                    , label = Input.labelAbove [] (Element.text "Sentence:")
                    }
                ]
            , Element.row
                [ Region.heading 1
                , Font.size 24
                , Element.spacing 8
                , Element.paddingXY 0 16
                ]
                (case model.sentence of
                    Ok words ->
                        words
                            |> List.map (\w -> wordToView w model.selectedWord)

                    Err _ ->
                        [ Element.none ]
                )
            ]
        )


wordToView : String -> Maybe String -> Element HomeMsg
wordToView word maybeSelectedWord =
    case maybeSelectedWord of
        Just selectedWord ->
            case String.trim selectedWord == word of
                True ->
                    Element.el
                        [ Element.padding 8
                        , Element.pointer
                        , Background.color <|
                            Color.light Color.primary 0.1
                        , Border.rounded 8
                        , Border.widthEach { bottom = 1, top = 0, left = 0, right = 0 }
                        , Border.color <| Color.light Color.primary 0.1
                        ]
                    <|
                        Element.text word

                False ->
                    Element.el
                        [ Element.padding 8
                        , Element.pointer
                        , Events.onClick (SelectWord word)
                        , Border.widthEach { bottom = 1, top = 0, left = 0, right = 0 }
                        , Border.color Color.lightPrimary
                        ]
                    <|
                        Element.text word

        Nothing ->
            Element.el
                [ Element.padding 8
                , Element.pointer
                , Events.onClick (SelectWord word)
                , Border.widthEach { bottom = 1, top = 0, left = 0, right = 0 }
                , Border.color Color.lightPrimary
                ]
            <|
                Element.text word
