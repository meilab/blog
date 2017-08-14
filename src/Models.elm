module Models exposing (..)

import Routing exposing (Route)
import Types exposing (Content)
import Pages


type alias Url =
    { base_url : String }


type alias Ui =
    { sideMenuActive : Bool }


type alias Model =
    { route : Route
    , url : Url
    , currentContent : Content
    , searchPost : Maybe String
    }


initialModel : Route -> Url -> Model
initialModel route url =
    { route = route
    , url = url
    , currentContent = Pages.home
    , searchPost = Nothing
    }
