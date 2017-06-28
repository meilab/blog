module Views exposing (view)

import Html exposing (..)
import Html.Attributes exposing (href)
import Markdown
import Messages exposing (Msg(..))
import Models exposing (..)
import ViewHelpers exposing (..)
import Html.CssHelpers exposing (withNamespace)
import Styles.SharedStyles exposing (..)
import Types exposing (..)
import RemoteData exposing (WebData, RemoteData(..))
import Routing exposing (Route(..))
import Views.Trainings exposing (renderTrainings)
import Views.Archives exposing (renderArchives)
import Views.Authors exposing (renderAuthors)


{ id, class, classList } =
    withNamespace "meilab"


view : Model -> Html Msg
view model =
    div [ class [ Layout ] ]
        [ navContainer model
        , hero
        , body model
        , footer
        ]


hero : Html Msg
hero =
    div [ class [ Hero ] ]
        [ h1 [] [ text "Meilab" ]
        , h3 [] [ text "Technology Consultant  and Training" ]
        , div [ class [ TagContainer ] ]
            [ h3 [ class [ TagItem ] ] [ text "Elm" ]
            , h3 [ class [ TagItem ] ] [ text "Elixir" ]
            , h3 [ class [ TagItem ] ] [ text "IoT" ]
            , h3 [ class [ TagItem ] ] [ text "Blockchain" ]
            ]
        ]


body : Model -> Html Msg
body model =
    section [ class [ Body ] ]
        [ mainBody model, subContent ]


mainBody : Model -> Html Msg
mainBody model =
    div []
        [ h1 [] [ text model.currentContent.title ]
        , renderMeta model.currentContent
        , renderContent model
        ]


renderMeta : Content -> Html Msg
renderMeta content =
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


renderContent : Model -> Html Msg
renderContent model =
    case model.route of
        ArchiveRoute ->
            renderArchives model

        TrainingRoute ->
            renderTrainings model

        AuthorRoute ->
            renderAuthors

        _ ->
            renderMarkdown model.currentContent.markdown


renderMarkdown : WebData String -> Html Msg
renderMarkdown markdown =
    article [ class [ MarkdownWrapper ] ]
        [ convertMarkdownToHtml markdown ]


subContent : Html Msg
subContent =
    div [ class [ SubContent ] ]
        [ p [] [ text "" ] ]


footer : Html Msg
footer =
    Html.footer [ class [ Footer ] ]
        [ text "footer" ]
