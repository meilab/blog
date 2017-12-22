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


ghProjectName : String
ghProjectName =
    ""


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        base_url =
            case
                location.pathname
                    |> String.split "/"
                    |> List.member ghProjectName
            of
                True ->
                    "/" ++ ghProjectName

                False ->
                    ""

        currentRoute =
            parseLocation location base_url

        url =
            { base_url = base_url }
    in
        changeUrlProcedure (initialModel currentRoute url)
            currentRoute
