module Posts exposing (..)

import Types exposing (Content, ContentType(..))
import Authors
import Date.Extra exposing (fromCalendarDate)
import Date exposing (Month(..))
import RemoteData exposing (RemoteData)
import Routing exposing (Route(..))


helloWorld : Content
helloWorld =
    { slug = "/post/hello-world"
    , route = PostDetailRoute "hello-world"
    , title = "Hello World"
    , name = "hello-world"
    , publishedDate = fromCalendarDate 2017 Jun 25
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    }


posts : List Content
posts =
    [ helloWorld ]
