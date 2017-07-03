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
            , color black
            ]
        , class Layout
            [ displayFlex
            , flexDirection column
            ]
        , class Container
            [ displayFlex
            ]
        , class ContentContainer
            [ flex (int 1)
            , displayFlex
            , flexDirection column
            ]
        , each [ class HomePageHero, class PostHero ]
            [ color snow
            , width (pct 100)
            , backgroundColor (hex "#222")
            , backgroundAttachment fixed
            , backgroundRepeat noRepeat
            , backgroundSize cover
            , displayFlex
            , flexDirection column
            , justifyContent center
            , alignItems center
            , textAlign center
            ]
        , class HomePageHero
            [ height (vh 100)
            ]
        , class PostHero
            [ height (vh 60) ]
        , each [ class MenuContainer, class MenuContainerVertical ]
            [ displayFlex
            , justifyContent spaceBetween
            , alignItems center
            ]
        , class MenuContainerVertical
            [ flexDirection column ]
        , class SideBarWrapper
            [ flex3 (int 0) (int 0) menuWidth
            , withClass MenuInActive
                [ display none ]
            ]
        , class SideBarMenu
            [ position fixed
            , width menuWidth
            , height (vh 100)
            , displayFlex
            , flexDirection column
            , justifyContent flexStart
            , backgroundColor ember
            ]
        , each [ class MenuList, class MenuListVertical, class HeaderMenuList ]
            [ displayFlex
            , justifyContent center
            , listStyle none
            , padding zero
            , margin zero
            ]
        , class MenuListVertical
            [ flexDirection column ]
        , class HeaderMenuList
            [ display block
            ]
        , class MenuItem
            [ flex (int 1)
            , padding2 zero (Css.rem 1)

            -- , border3 (px 1) solid silver
            ]
        , class MenuToggler
            [ position absolute
            , color white
            , padding (px 5)
            , left toggleMenuLeftCollapsed
            , top (px 20)
            , border3 (px 1) solid silver
            , descendants
                [ li
                    [ listStyleType none ]
                ]
            , withClass MenuActive
                [ left toggleMenuLeft ]
            , hover
                [ backgroundColor white
                , color black
                ]
            ]
        , class Spacing
            [ padding2 (px 50) zero ]
        , mediaQuery "screen and (max-width : 48em)"
            [ class HomePageHero
                [ height (vh 60)
                , minHeight (px 240)
                , padding2 (pct 15) zero
                ]
            ]
        ]
