module Types exposing (..)

import Date exposing (Date)
import RemoteData exposing (WebData)
import Routing exposing (Route)


type alias Author =
    { name : String
    , avator : String
    , email : String
    }


type ContentType
    = Page
    | Post


type alias Content =
    { title : String
    , name : String
    , slug : String
    , route : Route
    , publishedDate : Date
    , author : Author
    , markdown : WebData String
    , contentType : ContentType
    , intro : String
    }


type alias ExternalContent =
    { title : String
    , name : String
    , slug : String
    , publishedDate : Date
    , author : Author
    , intro : String
    }
