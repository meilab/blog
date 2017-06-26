module Main exposing (..)

import Views exposing (view)
import Messages exposing (Msg(..))
import Update exposing (..)
import Models exposing (..)
import Navigation
import Routing exposing (parseLocation)


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        base_url =
            case
                location.pathname
                    |> String.split "/"
                    |> List.reverse
                    |> List.tail
                    |> Maybe.map (List.reverse)
                    |> Maybe.map (String.join "/")
            of
                Just url ->
                    url

                Nothing ->
                    ""

        currentRoute =
            parseLocation location base_url

        url =
            { base_url = base_url }

        initModel =
            initialModel currentRoute url

        initialCommand =
            changeUrlCommand (initialModel currentRoute url) currentRoute initModel.currentContent
    in
        ( initModel, initialCommand )
