module Posts exposing (..)

import Types exposing (Content, ContentType(..), TagType(..))
import Authors
import Date.Extra exposing (fromCalendarDate)
import Date exposing (Month(..))
import RemoteData exposing (RemoteData)
import Routing exposing (Route(..))


helloWorld : Content
helloWorld =
    { slug = "/hello-world-elm"
    , route = PostDetailRoute "hello-world-elm"
    , title = "Hello World"
    , name = "hello-world-elm"
    , publishedDate = fromCalendarDate 2017 Jun 25
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    , hero = "image/cover4.jpg"
    , tags = [ Elm, PhotoGallery, ElmInAction, ElmTraining ]
    }


elmArchitecture : Content
elmArchitecture =
    { slug = "/elm-architecture"
    , route = PostDetailRoute "elm-architecture"
    , title = "Elm Architecture"
    , name = "elm-architecture"
    , publishedDate = fromCalendarDate 2017 Jun 13
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    , hero = "image/cover4.jpg"
    , tags = [ Elm, PhotoGallery, ElmInAction, ElmTraining ]
    }


staticVersionElmPhotoGallery : Content
staticVersionElmPhotoGallery =
    { slug = "/static-version-elm-photo-gallery"
    , route = PostDetailRoute "static-version-elm-photo-gallery"
    , title = "Static Version"
    , name = "static-version-elm-photo-gallery"
    , publishedDate = fromCalendarDate 2017 Jul 10
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    , hero = "image/cover4.jpg"
    , tags = [ Elm, PhotoGallery, ElmInAction, ElmTraining ]
    }


dynamicVersionElmPhotoGallery : Content
dynamicVersionElmPhotoGallery =
    { slug = "/dynamic-version-elm-photo-gallery"
    , route = PostDetailRoute "dynamic-version-elm-photo-gallery"
    , title = "Dynamic Version"
    , name = "dynamic-version-elm-photo-gallery"
    , publishedDate = fromCalendarDate 2017 Jul 11
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    , hero = "image/cover4.jpg"
    , tags = [ Elm, PhotoGallery, ElmInAction, ElmTraining ]
    }


inverseDataFlowElmPhotoGallery : Content
inverseDataFlowElmPhotoGallery =
    { slug = "/inverse-data-flow-elm-photo-gallery"
    , route = PostDetailRoute "inverse-data-flow-elm-photo-gallery"
    , title = "Inverse Data Flow"
    , name = "inverse-data-flow-elm-photo-gallery"
    , publishedDate = fromCalendarDate 2017 Jun 11
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    , hero = "image/cover4.jpg"
    , tags = [ Elm, PhotoGallery, ElmInAction, ElmTraining ]
    }


dynamicUrlElmPhotoGallery : Content
dynamicUrlElmPhotoGallery =
    { slug = "/dynamic-url-elm-photo-gallery"
    , route = PostDetailRoute "dynamic-url-elm-photo-gallery"
    , title = "Dynamic Url"
    , name = "dynamic-url-elm-photo-gallery"
    , publishedDate = fromCalendarDate 2017 Jun 12
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    , hero = "image/cover4.jpg"
    , tags = [ Elm, PhotoGallery, ElmInAction, ElmTraining ]
    }


splitFileElmPhotoGallery : Content
splitFileElmPhotoGallery =
    { slug = "/split-file-elm-photo-gallery"
    , route = PostDetailRoute "split-file-elm-photo-gallery"
    , title = "Split file"
    , name = "split-file-elm-photo-gallery"
    , publishedDate = fromCalendarDate 2017 Jun 12
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    , hero = "image/cover4.jpg"
    , tags = [ Elm, PhotoGallery, ElmInAction, ElmTraining ]
    }


spaElmPhotoGallery : Content
spaElmPhotoGallery =
    { slug = "/spa-elm-photo-gallery"
    , route = PostDetailRoute "spa-elm-photo-gallery"
    , title = "SPA"
    , name = "spa-elm-photo-gallery"
    , publishedDate = fromCalendarDate 2017 Jun 13
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    , hero = "image/cover4.jpg"
    , tags = [ Elm, PhotoGallery, ElmInAction, ElmTraining ]
    }


whyIChooseElm : Content
whyIChooseElm =
    { slug = "/why-I-choose-elm"
    , route = PostDetailRoute "why-I-choose-elm"
    , title = "我为什么选择Elm"
    , name = "why-I-choose-elm"
    , publishedDate = fromCalendarDate 2017 Jun 16
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    , hero = "image/cover4.jpg"
    , tags = [ Elm, ElmTraining ]
    }


elmTrainingGettingStarted : Content
elmTrainingGettingStarted =
    { slug = "/elm-training-getting-started"
    , route = PostDetailRoute "elm-training-getting-started"
    , title = "Elm培训"
    , name = "elm-training-getting-started"
    , publishedDate = fromCalendarDate 2017 Jun 16
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , contentType = Post
    , intro = "Hello World in Elm and Elxir"
    , hero = "image/cover4.jpg"
    , tags = [ Elm, ElmTraining ]
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
    , whyIChooseElm
    , elmTrainingGettingStarted
    ]
