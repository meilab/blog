module Types exposing (..)

import Date exposing (Date)
import RemoteData exposing (WebData)
import Routing exposing (Route)


type alias Author =
    { name : String
    , avator : String
    , email : String
    , bio : String
    , blog : String
    , location : String
    , github : String
    }


type ContentType
    = Page
    | AuthorPage
    | Post


type TagType
    = Elm
    | Elixir
    | IoT
    | C
    | ElmTraining
    | ElmInAction
    | PhotoGallery


type alias Tags =
    List TagType


type alias Content =
    { title : String
    , name : String
    , slug : String
    , route : Route
    , publishedDate : Date
    , author : Author
    , markdown : WebData String
    , contentType : ContentType
    , preview : String
    , hero : String
    , tags : List TagType
    }


type alias ExternalContent =
    { title : String
    , name : String
    , slug : String
    , publishedDate : Date
    , author : Author
    , intro : String
    }
