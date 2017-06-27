module Trainings exposing (..)

import Types exposing (ExternalContent)
import Authors
import Date.Extra exposing (fromCalendarDate)
import Date exposing (Month(..))


html5Basics : ExternalContent
html5Basics =
    { slug = "https://meilab.github.io/html5-basics"
    , title = "HTML5 Basics"
    , name = "html5-basics"
    , publishedDate = fromCalendarDate 2017 Jun 27
    , author = Authors.wy
    , intro = "HTML5 basics intro"
    }


elmBasics : ExternalContent
elmBasics =
    { slug = "https://meilab.github.io/elm-basics"
    , title = "Elm Basics"
    , name = "eml-basics"
    , publishedDate = fromCalendarDate 2017 Jun 27
    , author = Authors.wy
    , intro = "ELM basics intro"
    }


trainings : List ExternalContent
trainings =
    [ html5Basics
    , elmBasics
    ]
