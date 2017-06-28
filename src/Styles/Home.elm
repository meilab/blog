module Styles.Home exposing (..)

import Css exposing (..)
import Css.Elements exposing (..)
import Css.Colors exposing (..)
import Css.Namespace exposing (..)
import Html.CssHelpers exposing (withNamespace)
import Styles.SharedStyles exposing (..)


css : Stylesheet
css =
    (stylesheet << namespace meilabNamespace.name)
        [ html
            [ boxSizing borderBox ]
        ]
