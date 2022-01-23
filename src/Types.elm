module Types exposing
    ( Flags
    , HomeModel
    , HomeMsg(..)
    , Model
    , Msg(..)
    , Route(..)
    , ValidWord(..)
    )

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Parser exposing (DeadEnd)
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
    = SelectWord String
    | OnInputRawTextChange String


type alias HomeModel =
    { rowString : String
    , selectedWord : Maybe String
    , sentence : Result (List DeadEnd) (List ValidWord)
    }


type ValidWord
    = Numeric String (Maybe String)
    | Alphabetic String (Maybe String)
    | WordWithPunctuation String String


type Msg
    = ChangeUrl Url
    | ClickLink UrlRequest
    | HomeMsg HomeMsg
