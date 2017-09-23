module Styles.TagArchive exposing (..)

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
        [ class TagContainer
            [ displayFlex
            ]
        , each [ class TagItem, class TagItemActive ]
            [ flex (int 0)
            , displayFlex
            , justifyContent flexStart
            , alignItems center
            , textAlign center

            --, border3 (px 1) solid silver
            , margin (Css.em 0.3)
            , padding (Css.em 0.3)
            ]
        , class TagItemActive
            [ backgroundColor facebook
            , color snow
            ]
        ]
