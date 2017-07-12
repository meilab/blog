module Posts exposing (..)

import Types exposing (Content, ContentType(..))
import Authors
import Date.Extra exposing (fromCalendarDate)
import Date exposing (Month(..))
import RemoteData exposing (RemoteData)
import Routing exposing (Route(..))


helloWorld : Content
helloWorld =
    { slug = "/post/hello-world-elm"
    , route = PostDetailRoute "hello-world-elm"
    , title = "Hello World"
    , name = "hello-world-elm"
    , publishedDate = fromCalendarDate 2017 Jun 25
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    , hero = "/image/cover4.jpg"
    }


elmArchitecture : Content
elmArchitecture =
    { slug = "/post/elm-architecture"
    , route = PostDetailRoute "elm-architecture"
    , title = "Elm Architecture"
    , name = "elm-architecture"
    , publishedDate = fromCalendarDate 2017 Jun 13
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    , hero = "/image/cover4.jpg"
    }


staticVersionElmPhotoGallery : Content
staticVersionElmPhotoGallery =
    { slug = "/post/static-version-elm-photo-gallery"
    , route = PostDetailRoute "static-version-elm-photo-gallery"
    , title = "Static Version"
    , name = "static-version-elm-photo-gallery"
    , publishedDate = fromCalendarDate 2017 Jul 10
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    , hero = "/image/cover4.jpg"
    }


dynamicVersionElmPhotoGallery : Content
dynamicVersionElmPhotoGallery =
    { slug = "/post/dynamic-version-elm-photo-gallery"
    , route = PostDetailRoute "dynamic-version-elm-photo-gallery"
    , title = "Dynamic Version"
    , name = "dynamic-version-elm-photo-gallery"
    , publishedDate = fromCalendarDate 2017 Jul 11
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    , hero = "/image/cover4.jpg"
    }


inverseDataFlowElmPhotoGallery : Content
inverseDataFlowElmPhotoGallery =
    { slug = "/post/inverse-data-flow-elm-photo-gallery"
    , route = PostDetailRoute "inverse-data-flow-elm-photo-gallery"
    , title = "Inverse Data Flow"
    , name = "inverse-data-flow-elm-photo-gallery"
    , publishedDate = fromCalendarDate 2017 Jun 11
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    , hero = "/image/cover4.jpg"
    }


dynamicUrlElmPhotoGallery : Content
dynamicUrlElmPhotoGallery =
    { slug = "/post/dynamic-url-elm-photo-gallery"
    , route = PostDetailRoute "dynamic-url-elm-photo-gallery"
    , title = "Dynamic Url"
    , name = "dynamic-url-elm-photo-gallery"
    , publishedDate = fromCalendarDate 2017 Jun 12
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    , hero = "/image/cover4.jpg"
    }


splitFileElmPhotoGallery : Content
splitFileElmPhotoGallery =
    { slug = "/post/split-file-elm-photo-gallery"
    , route = PostDetailRoute "split-file-elm-photo-gallery"
    , title = "Split file"
    , name = "split-file-elm-photo-gallery"
    , publishedDate = fromCalendarDate 2017 Jun 12
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    , hero = "/image/cover4.jpg"
    }


spaElmPhotoGallery : Content
spaElmPhotoGallery =
    { slug = "/post/spa-elm-photo-gallery"
    , route = PostDetailRoute "spa-elm-photo-gallery"
    , title = "SPA"
    , name = "spa-elm-photo-gallery"
    , publishedDate = fromCalendarDate 2017 Jun 13
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    , hero = "/image/cover4.jpg"
    }


posts : List Content
posts =
    [ helloWorld
    , elmArchitecture
    , staticVersionElmPhotoGallery
    , dynamicVersionElmPhotoGallery
    , inverseDataFlowElmPhotoGallery
    , dynamicUrlElmPhotoGallery
    , splitFileElmPhotoGallery
    , spaElmPhotoGallery
    ]
