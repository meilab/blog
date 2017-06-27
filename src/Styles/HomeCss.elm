module Styles.HomeCss exposing (..)

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
        , body
            [ fontSize (px 16)
            , fontFamily sansSerif
            , padding zero
            , margin zero
            , backgroundColor gray
            ]
        , class Layout
            [ displayFlex
            , flexDirection column
            ]
        , class Header
            [ backgroundColor (hex "#fff")
            , flex3 (int 0) (int 0) (px 64)
            , displayFlex
            , justifyContent spaceBetween
            , alignItems center
            , overflow hidden
            ]
        , each [ class MenuList, class HeaderMenuList ]
            [ displayFlex
            , justifyContent center
            , listStyle none
            , padding zero
            , margin zero
            , descendants
                [ a
                    [ textDecoration none
                    , color black
                    ]
                ]
            ]
        , class HeaderMenuList
            [ display block
            ]
        , class MenuItem
            [ flex (int 1)
            , padding2 zero (Css.rem 1)
            , border3 (px 1) solid silver
            ]
        , class Footer
            [ backgroundColor black
            , color (hex "#fff")
            , flex3 (int 0) (int 0) (px 64)
            , displayFlex
            , justifyContent center
            , alignItems center
            , textAlign center
            ]
        , class ImgResponsive
            [ width auto
            , height (pct 100)
            ]
        ]
