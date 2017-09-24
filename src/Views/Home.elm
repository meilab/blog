module Views.Home exposing (homeView)

import Models exposing (..)
import Routing exposing (Route(..), urlFor)
import Authors
import Messages exposing (Msg(..))
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (href)
import Html.CssHelpers exposing (withNamespace)
import Posts exposing (posts)
import ContentUtils exposing (filterByTitle, filterByTag)
import Types exposing (Author)
import ViewHelpers exposing (formatDate, navigationOnClick, externalLink)
import Styles.SharedStyles exposing (..)
import Views.SharedViews exposing (..)


{ id, class, classList } =
    withNamespace "meilab"


homeView : Model -> Html Msg
homeView model =
    content model


content : Model -> Html Msg
content model =
    div [ class [ ContentContainer ] ]
        [ h1 [] [ text model.currentContent.title ]
        , renderPageMeta model.currentContent
        , renderMarkdown model.currentContent.markdown
        , renderPosts model
        , morePostsLink model
        , renderTags model.tagFilter model.tags
        , renderProjects
        ]


renderPosts : Model -> Html Msg
renderPosts model =
    div [ class [ ContentContainer ] ]
        (posts
            |> filterByTitle model.titleFilter
            |> filterByTag model.tagFilter
            |> List.take 5
            |> List.map (renderPostPreview model.url.base_url)
        )


morePostsLink : Model -> Html Msg
morePostsLink model =
    let
        slug =
            urlFor model.url.base_url ArchiveRoute
    in
        div [ class [ MorePostsLink ] ]
            [ a
                [ href slug
                , navigationOnClick (NewUrl slug)
                ]
                [ text "View All Posts"
                , i [ Html.Attributes.class "fa fa-arrow-right" ] []
                ]
            ]


renderProjects : Html Msg
renderProjects =
    div []
        []
