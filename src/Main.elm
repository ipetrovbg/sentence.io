module Main exposing (..)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key, load, pushUrl)
import HomePage
import Html
import NotFound
import Router
import Types exposing (Flags, Model, Msg(..), Route(..))
import Url exposing (Url)
import Url.Parser exposing (parse)


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init _ url navKey =
    let
        ( homeInit, homeCmd ) =
            HomePage.init ()
    in
    ( { route = parse Router.routeParser url
      , home = homeInit
      , navKey = navKey
      }
    , Cmd.batch
        [ Cmd.map HomeMsg homeCmd
        , Router.urlToCmd url
        ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeUrl url ->
            ( { model | route = parse Router.routeParser url }, Router.urlToCmd url )

        HomeMsg homeMsg ->
            case homeMsg of
                _ ->
                    let
                        ( homeModel, homeCmd ) =
                            HomePage.update homeMsg model.home
                    in
                    ( { model | home = homeModel }, Cmd.map HomeMsg homeCmd )

        ClickLink request ->
            case request of
                Internal url ->
                    ( model, pushUrl model.navKey <| Url.toString url )

                External url ->
                    ( model, load url )


view : Model -> Document Msg
view model =
    { title = "Sentence.io"
    , body =
        [ case model.route of
            Just route ->
                case route of
                    HomeRoute ->
                        Html.map HomeMsg (HomePage.view model.home)

            Nothing ->
                NotFound.view
        ]
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
