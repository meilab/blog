module Views exposing (view)

import Html exposing (..)
import Html.Events exposing (onClick)
import Markdown
import Messages exposing (Msg(..))
import Models exposing (..)
import ViewHelpers exposing (..)
import Html.CssHelpers exposing (withNamespace)
import Styles.SharedStyles exposing (..)
import Types exposing (..)
import RemoteData exposing (WebData, RemoteData(..))
import Routing exposing (Route(..))
import Views.Trainings exposing (trainingView)
import Views.Archives exposing (archiveView)
import Views.Authors exposing (authorView)
import Views.Home exposing (homeView)
import Views.About exposing (aboutView)
import Views.Page exposing (pageView)


{ id, class, classList } =
    withNamespace "meilab"


view : Model -> Html Msg
view model =
    let
        contentView =
            case model.route of
                HomeRoute ->
                    homeView model

                TrainingRoute ->
                    trainingView model

                AboutRoute ->
                    aboutView model

                AuthorRoute ->
                    authorView model

                ArchiveRoute ->
                    archiveView model

                _ ->
                    pageView model

        sideMenuClass =
            case model.ui.sideMenuActive of
                True ->
                    MenuActive

                False ->
                    MenuInActive
    in
        div [ class [ Container ] ]
            [ toggleMenu sideMenuClass
            , div [ class [ SideBarWrapper, sideMenuClass ] ]
                [ verticalNav model
                ]
            , contentView
            ]
