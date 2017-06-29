module Messages exposing (..)

import Navigation exposing (Location)
import RemoteData exposing (WebData)


type Msg
    = OnLocationChange Location
    | NewUrl String
    | FetchedContent (WebData String)
    | ToggleSideMenu
    | HideSideMenu
    | NoOp
