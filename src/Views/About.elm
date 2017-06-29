module Views.About exposing (aboutView)

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


aboutView : Model -> Html Msg
aboutView model =
    div
        [ class [ ContentContainer ]
        , onClick HideSideMenu
        ]
        [ hero model.currentContent.hero (class [ PostHero ])
        , renderMarkdown
            model.currentContent.markdown
        , Views.SharedViews.footer
        ]
