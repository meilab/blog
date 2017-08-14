module Views.SharedViews exposing (..)

import Messages exposing (Msg(..))
import Html exposing (..)
import Html.Attributes exposing (src, href, seamless, width, height)
import Html.CssHelpers exposing (withNamespace)
import Css exposing (backgroundImage, url)
import Types exposing (Content)
import ViewHelpers exposing (formatDate, normalLinkItem, footerLinkItem, navigationOnClick)
import Routing exposing (footerRoutingItem)
import Styles.SharedStyles exposing (..)
import RemoteData exposing (WebData, RemoteData(..))
import Config exposing (siteName, siteTime)
import Markdown


{ id, class, classList } =
    withNamespace "meilab"


styles =
    Css.asPairs >> Html.Attributes.style


renderFooter : Html Msg
renderFooter =
    footer [ class [ Footer ] ]
        [ ul [ class [ MenuList ] ]
            (footerRoutingItem
                |> List.map footerLinkItem
            )
        , p [ class [ CopyRight ] ]
            [ text "All code for this site is open source and written in Elm. "
            , text "! — © 2017 Meilab"
            , iframe
                [ class [ GithubIframe ]
                , width 100
                , height 20
                , src "https://ghbtns.com/github-btn.html?user=meilab&repo=elm_blog&type=star&count=true"
                ]
                []
            ]
        ]


renderMarkdown : WebData String -> Html Msg
renderMarkdown markdown =
    article [ class [ MarkdownWrapper ] ]
        [ convertMarkdownToHtml markdown ]


convertMarkdownToHtml : WebData String -> Html Msg
convertMarkdownToHtml markdown =
    case markdown of
        Success data ->
            Markdown.toHtml [ class [ MarkdownContent ] ] data

        Failure err ->
            Debug.log (toString (err))
                text
                "There was an error"

        _ ->
            text "Loading"


renderPageMeta : Content -> Html Msg
renderPageMeta content =
    case content.contentType of
        Types.Post ->
            div [ class [ ContentMeta ] ]
                [ p []
                    [ text
                        ("Published on " ++ ViewHelpers.formatDate content.publishedDate ++ " by " ++ content.author.name ++ ".")
                    ]
                ]

        _ ->
            div [] []


renderPostMeta : String -> Content -> Html Msg
renderPostMeta base_url content =
    li [ class [ MenuItem ] ]
        [ h4 [] [ normalLinkItem base_url content.slug content.title ]
        , p []
            [ text
                ("Published on " ++ formatDate content.publishedDate ++ " by " ++ content.author.name ++ ".")
            ]
        ]


renderPostPreview : String -> Content -> Html Msg
renderPostPreview base_url content =
    let
        slug =
            content.slug

        onClickCmd =
            (NewUrl (base_url ++ slug))
    in
        div [ class [ PostPreview ] ]
            [ a
                [ href slug
                , navigationOnClick (onClickCmd)
                ]
                [ h2 [ class [ PostPreviewTitle ] ] [ text content.title ]
                , p [ class [ PostContentPreview ] ] [ text content.preview ]
                ]
            , p [ class [ PostPreviewMeta ] ]
                [ text
                    ("Published on " ++ formatDate content.publishedDate ++ " by " ++ content.author.name ++ ".")
                ]
            ]


hero : String -> Attribute Msg -> Html Msg
hero src heroClass =
    div
        [ heroClass
        , styles
            [ backgroundImage (url src)
            ]
        ]
        [ h1 [] [ text "Meilab" ]
        , h3 [] [ text "Technology Consultant  and Training" ]
        , div [ class [ TagContainer ] ]
            [ h3 [ class [ TagItem ] ] [ text "Elm" ]
            , h3 [ class [ TagItem ] ] [ text "Elixir" ]
            , h3 [ class [ TagItem ] ] [ text "IoT" ]
            , h3 [ class [ TagItem ] ] [ text "Blockchain" ]
            ]
        ]
