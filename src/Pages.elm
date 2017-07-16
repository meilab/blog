module Pages exposing (..)

import Authors
import Date.Extra exposing (fromCalendarDate)
import Date exposing (Month(..))
import Types exposing (Content, ContentType(..))
import RemoteData exposing (RemoteData)
import Routing exposing (Route(..))


home : Content
home =
    { slug = "/"
    , route = HomeRoute
    , contentType = Page
    , name = "index"
    , title = "Meilab"
    , publishedDate = fromCalendarDate 2017 Jun 25
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , intro = ""
    , hero = "image/cover1.jpg"
    , tags = []
    }


about : Content
about =
    { slug = "/about"
    , route = AboutRoute
    , contentType = Page
    , name = "about"
    , title = "About Meilab"
    , publishedDate = fromCalendarDate 2017 Jun 25
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , intro = ""
    , hero = "image/cover5.jpg"
    , tags = []
    }


trainings : Content
trainings =
    { slug = "/trainings"
    , route = TrainingRoute
    , contentType = Page
    , name = "trainings"
    , title = "Training Slides"
    , publishedDate = fromCalendarDate 2017 Jun 27
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , intro = ""
    , hero = "image/cover6.jpg"
    , tags = []
    }


archives : Content
archives =
    { slug = "archive"
    , route = ArchiveRoute
    , contentType = Page
    , name = "archive"
    , title = "Archive"
    , publishedDate = fromCalendarDate 2017 Jun 25
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , intro = ""
    , hero = "image/cover4.jpg"
    , tags = []
    }


authors : Content
authors =
    { slug = "author"
    , route = AuthorRoute
    , contentType = AuthorPage
    , name = "author"
    , title = "Author"
    , publishedDate = fromCalendarDate 2017 Jun 28
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , intro = ""
    , hero = "image/cover7.jpg"
    , tags = []
    }


notFoundContent : Content
notFoundContent =
    { slug = "notfound"
    , route = NotFoundRoute
    , contentType = Page
    , name = "not-found"
    , title = "Couldn't find content"
    , publishedDate = fromCalendarDate 2017 Jun 25
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , intro = ""
    , hero = "image/cover3.jpg"
    , tags = []
    }


notFound404 : Content
notFound404 =
    { slug = "404"
    , route = NotFoundRoute
    , contentType = Page
    , name = "404"
    , title = "You Are lost"
    , publishedDate = fromCalendarDate 2017 Jun 25
    , author = Authors.wy
    , markdown = RemoteData.NotAsked
    , intro = ""
    , hero = "image/cover3.jpg"
    , tags = []
    }


pages : List Content
pages =
    [ home
    , about
    , trainings
    , archives
    , authors
    , notFoundContent
    , notFound404
    ]
