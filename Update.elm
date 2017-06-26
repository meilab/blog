module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (..)
import Routing exposing (Route(..), parseLocation)
import Navigation exposing (Location)
import RemoteData exposing (RemoteData)
import ContentUtils
import Types exposing (Content)
import FetchContent


changeUrlCommand : Model -> Route -> Content -> Cmd Msg
changeUrlCommand model route content =
    case route of
        ArchiveRoute ->
            Cmd.none

        _ ->
            FetchContent.fetch content model.url.base_url


getContentForRoute : Route -> Maybe Content
getContentForRoute =
    ContentUtils.findByRoute ContentUtils.allContent


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            let
                tempRoute =
                    parseLocation location model.url.base_url

                ( newContent, newRoute, newCmd ) =
                    case getContentForRoute tempRoute of
                        Nothing ->
                            ( model.currentContent, NotFoundRoute, Navigation.modifyUrl (model.url.base_url ++ "/404") )

                        Just content ->
                            let
                                newContent =
                                    { content | markdown = RemoteData.Loading }

                                newCmd =
                                    changeUrlCommand model tempRoute newContent
                            in
                                ( newContent
                                , tempRoute
                                , newCmd
                                )
            in
                ( { model
                    | route = newRoute
                    , currentContent = newContent
                  }
                , newCmd
                )

        NewUrl url ->
            model
                ! [ (Navigation.newUrl url) ]

        FetchedContent response ->
            let
                currentContent =
                    model.currentContent

                newContent =
                    { currentContent | markdown = response }
            in
                ( { model | currentContent = newContent }
                , Cmd.none
                )

        NoOp ->
            ( model, Cmd.none )
