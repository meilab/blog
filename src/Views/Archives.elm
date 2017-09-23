module Views.Archives exposing (archiveView)

import Models exposing (..)
import Messages exposing (Msg(..))
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.CssHelpers exposing (withNamespace)
import Types exposing (Content)
import ViewHelpers exposing (formatDate, externalLink)
import Posts exposing (posts)
import ContentUtils exposing (filterByTitle, filterByTag)
import ViewHelpers exposing (formatDate, normalLinkItem)
import Styles.SharedStyles exposing (..)
import Views.SharedViews exposing (..)


{ id, class, classList } =
    withNamespace "meilab"


archiveView : Model -> Html Msg
archiveView model =
    renderArchives model


renderArchives : Model -> Html Msg
renderArchives model =
    div [ class [ PostPreviewContainer ] ]
        (posts
            |> filterByTitle model.titleFilter
            |> filterByTag model.tagFilter
            |> List.map (renderPostPreview model.url.base_url)
        )
