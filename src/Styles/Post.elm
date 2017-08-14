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
        , class PostContainer
            [ padding (Css.em 1.5) ]
        , class PostPreviewContainer
            [ displayFlex
            , width (pct 100)
            , flexDirection column
            , justifyContent center
            , alignItems center
            , maxWidth (px 759)
            ]
        , class PostPreview
            [ displayFlex
            , width (pct 100)
            , borderBottom3 (px 1) solid silver
            , flexDirection column
            , alignItems flexStart
            , children
                [ a
                    [ color (hex "#404040")
                    , hover
                        [ textDecoration none
                        , color (hex "0085a1")
                        ]
                    , focus
                        [ textDecoration none
                        , color (hex "0085a1")
                        ]
                    ]
                ]
            ]
        , class PostPreviewTitle
            [ fontSize (px 21)
            , lineHeight (Css.em 1.3)
            , marginTop (px 30)
            , marginBottom (px 8)
            ]
        , class PostPreviewSubtitle
            [ fontSize (px 15)
            , lineHeight (Css.em 1.3)
            , fontWeight (int 300)
            , marginBottom (px 10)
            ]
        , class PostPreviewMeta
            [ fontFamily sansSerif
            , color (hex "#808080")
            , fontSize (px 16)
            , fontStyle italic
            , marginTop zero
            ]
        , class MorePostsLink
            [ margin2 (Css.em 3) zero
            , displayFlex
            , flexDirection column
            , alignItems flexEnd
            , textAlign right
            , descendants
                [ a
                    [ color (hex "#404040")
                    , textDecoration underline
                    , border3 (px 1) solid silver
                    , hover
                        [ textDecoration none
                        , color (hex "0085a1")
                        ]
                    , focus
                        [ textDecoration none
                        , color (hex "0085a1")
                        ]
                    ]
                ]
            ]
        , class PostContentPreview
            [ fontSize (px 13)
            , fontStyle italic
            , color (hex "#a3a3a3")
            , hover [ color (hex "#0085a1") ]
            ]
        , class PostHead
            []
        , mediaQuery "screen and (min-width : 48em)"
            [ class PostContainer
                [ padding2 zero (pct 12) ]
            ]
        ]
