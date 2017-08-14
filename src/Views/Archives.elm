module Views.Archives exposing (archiveView)

import Models exposing (..)
import Messages exposing (Msg(..))
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.CssHelpers exposing (withNamespace)
import Types exposing (Content)
import ViewHelpers exposing (formatDate, externalLink)
import Posts exposing (posts)
import ContentUtils exposing (filterByTitle)
import ViewHelpers exposing (formatDate, normalLinkItem)
import Styles.SharedStyles exposing (..)
import Views.SharedViews exposing (..)


{ id, class, classList } =
    withNamespace "meilab"


archiveView : Model -> Html Msg
archiveView model =
    div [ class [ ContentContainer ], onClick HideSideMenu ]
        [ hero model.currentContent.hero (class [ PostHero ])
        , renderArchives model
        , renderFooter
        ]


renderArchives : Model -> Html Msg
renderArchives model =
    div [ class [ PostPreviewContainer ] ]
        (List.map (renderPostPreview model.url.base_url) <| filterByTitle posts model.searchPost)
