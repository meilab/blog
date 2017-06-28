module Styles.HeaderFooter exposing (..)

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
        [ each [ class Footer, class Header ]
            [ backgroundColor background
            , color snow
            , padding2 (px 10) zero
            ]
        , class Header
            [ backgroundColor snow
            , flex3 (int 0) (int 0) (px 64)
            , displayFlex
            , justifyContent spaceBetween
            , alignItems center
            , overflow hidden
            ]
        , class Footer
            [ backgroundColor (hex "#134374")
            , color white
            , clear
            , padding2 (Css.em 3) (pct 10)
            , textAlign center
            , flex3 (int 0) (int 0) (px 64)
            , displayFlex
            , justifyContent center
            , alignItems center
            , descendants
                [ a
                    [ color (rgba 255 255 255 0.5)
                    , hover
                        [ color (rgba 255 255 255 0.3) ]
                    , focus
                        [ color (rgba 255 255 255 0.3) ]
                    ]
                ]
            ]
        ]
