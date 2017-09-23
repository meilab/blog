module Messages exposing (..)

import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Types exposing (TagType)


type Msg
    = OnLocationChange Location
    | NewUrl String
    | FetchedContent (WebData String)
    | UpdateTitleFilter String
    | UpdateTagFilter TagType
    | NoOp
