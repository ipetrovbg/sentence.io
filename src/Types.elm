module Types exposing (Flags, HomeModel, HomeMsg(..), Model, Msg(..), Route(..))

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Url exposing (Url)


type alias Flags =
    ()


type Route
    = HomeRoute


type alias Model =
    { route : Maybe Route
    , navKey : Key
    , home : HomeModel
    }


type HomeMsg
    = NoOp


type alias HomeModel =
    ()


type Msg
    = ChangeUrl Url
    | ClickLink UrlRequest
    | HomeMsg HomeMsg
