module Views.Archives exposing (renderArchives)

import Models exposing (..)
import Messages exposing (Msg(..))
import Html exposing (..)
import Html.CssHelpers exposing (withNamespace)
import Types exposing (Content)
import ViewHelpers exposing (formatDate, externalLink)
import Posts exposing (posts)
import ContentUtils exposing (filterByTitle)
import ViewHelpers exposing (formatDate, normalLinkItem)
import Styles.SharedStyles exposing (..)


{ id, class, classList } =
    withNamespace "meilab"


renderArchives : Model -> Html Msg
renderArchives model =
    div []
        [ h4 [] [ text "Posts of meilab" ]
        , ul []
            (List.map (renderArchive model.url.base_url) <| filterByTitle posts model.searchPost)
        ]


renderArchive : String -> Content -> Html Msg
renderArchive base_url content =
    li [ class [ MenuItem ] ]
        [ h4 [] [ normalLinkItem base_url content.slug content.title ]
        , p []
            [ text
                ("Published on " ++ formatDate content.publishedDate ++ " by " ++ content.author.name ++ ".")
            ]
        ]
