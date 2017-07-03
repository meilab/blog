module Styles.Post exposing (..)

import Css exposing (..)
import Css.Elements exposing (..)
import Css.Colors exposing (..)
import Css.Namespace exposing (..)
import Html.CssHelpers exposing (withNamespace)
import Styles.SharedStyles exposing (..)
import Styles.Colors exposing (..)
import Styles.SharedVariables exposing (..)


css : Stylesheet
css =
    (stylesheet << namespace meilabNamespace.name)
        [ class BlogPost
            [ maxWidth (px 759)
            , marginLeft auto
            , marginRight auto
            ]
        , mediaQuery "screen and (min-width : 48em)"
            []
        ]
