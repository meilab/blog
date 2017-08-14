module Views.Trainings exposing (trainingView)

import Models exposing (..)
import Messages exposing (Msg(..))
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.CssHelpers exposing (withNamespace)
import Types exposing (ExternalContent)
import ViewHelpers exposing (formatDate, externalLink)
import Trainings exposing (trainings)
import Styles.SharedStyles exposing (..)
import Views.SharedViews exposing (..)


{ id, class, classList } =
    withNamespace "meilab"


trainingView : Model -> Html Msg
trainingView model =
    renderTrainings model


renderTrainings : Model -> Html Msg
renderTrainings model =
    div [ class [ ContentContainer ] ]
        [ h4 [] [ text "Training Slides" ]
        , div [ class [ TrainingContainer ] ]
            (trainings
                |> List.map renderTrainingItem
            )
        ]


renderTrainingItem : ExternalContent -> Html Msg
renderTrainingItem content =
    div [ class [ TrainingItem ] ]
        [ h4 [] [ externalLink content.slug content.title ]
        , p []
            [ text
                ("Published on " ++ formatDate content.publishedDate ++ " by " ++ content.author.name ++ ".")
            ]
        ]
