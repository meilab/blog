module Views.SharedViews exposing (..)

import Messages exposing (Msg(..))
import Html exposing (..)
import Html.Attributes
import Html.CssHelpers exposing (withNamespace)
import Css exposing (backgroundImage, url)
import Types exposing (Content)
import ViewHelpers exposing (formatDate, normalLinkItem, footerLinkItem)
import Routing exposing (footerRoutingItem)
import Styles.SharedStyles exposing (..)
import RemoteData exposing (WebData, RemoteData(..))
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
