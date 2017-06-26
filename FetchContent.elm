module FetchContent exposing (..)

import Types exposing (Content, ContentType(..))
import Messages exposing (Msg(..))
import Http
import RemoteData


fetch : Content -> String -> Cmd Msg
fetch content base_url =
    Http.getString (locForContent content base_url)
        |> Http.toTask
        |> RemoteData.asCmd
        |> Cmd.map FetchedContent


locForContent : Content -> String -> String
locForContent content base_url =
    let
        loc =
            locationForContentType content.contentType
    in
        base_url ++ "/content/" ++ loc ++ content.name ++ ".md"


locationForContentType : ContentType -> String
locationForContentType contentType =
    case contentType of
        Page ->
            "pages/"

        Post ->
            "posts/"
