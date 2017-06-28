module Styles.General exposing (..)

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
        [ html
            [ boxSizing borderBox ]
        , body
            [ fontSize (px 16)
            , fontFamily sansSerif
            , padding zero
            , margin zero
            , backgroundColor background
            ]
        , p
            [ lineHeight (Css.em 1.6) ]
        , each [ h1, h2 ]
            [ padding zero
            , margin zero
            ]
        , h3
            [ margin2 (px 15) zero
            ]
        , img
            [ maxWidth (pct 100)
            , height auto
            ]
        , nav
            [ descendants
                [ ul
                    [ listStyleType none
                    , margin zero
                    , padding zero
                    , displayFlex
                    , justifyContent spaceBetween
                    , alignItems center
                    , textAlign center
                    ]
                ]
            ]
        , a
            [ textDecoration none
            , textAlign center
            , display block
            , padding (px 10)
            , color snow
            ]
        , class Layout
            [ displayFlex
            , flexDirection column
            ]
        , class Hero
            [ color snow
            , width (pct 100)
            , height (vh 100)
            , backgroundImage (url "/image/cover1.jpg")
            , backgroundColor (hex "#222")
            , backgroundAttachment fixed
            , backgroundRepeat noRepeat
            , backgroundSize cover
            , displayFlex
            , justifyContent center
            , alignItems center
            , textAlign center
            ]
        , class MenuContainer
            [ displayFlex
            , justifyContent spaceBetween
            , alignItems center
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

            -- , border3 (px 1) solid silver
            ]
        , class Spacing
            [ padding2 (px 50) zero ]
        ]
