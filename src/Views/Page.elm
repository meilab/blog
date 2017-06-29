module Views.Page exposing (pageView)

import Models exposing (..)
import Authors
import Messages exposing (Msg(..))
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.CssHelpers exposing (withNamespace)
import Types exposing (Author)
import ViewHelpers exposing (formatDate, externalLink)
import Styles.SharedStyles exposing (..)
import Views.SharedViews exposing (..)


{ id, class, classList } =
    withNamespace "meilab"


pageView : Model -> Html Msg
pageView model =
    div
        [ class [ ContentContainer ]
        , onClick HideSideMenu
        ]
        [ hero model.currentContent.hero (class [ PostHero ])
        , content model
        , Views.SharedViews.footer
        ]


content : Model -> Html Msg
content model =
    div []
        [ h1 [] [ text model.currentContent.title ]
        , renderPageMeta model.currentContent
        , renderMarkdown model.currentContent.markdown
        ]
