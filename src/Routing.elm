module Routing exposing (..)

import Navigation exposing (Location)
import UrlParser exposing (..)


type Route
    = HomeRoute
    | AboutRoute
    | ArchiveRoute
    | PostDetailRoute String
    | TrainingRoute
    | AuthorRoute
    | NotFoundRoute


parseBaseUrl : String -> Parser a a -> Parser a a
parseBaseUrl base_url item =
    case base_url of
        "" ->
            item

        _ ->
            base_url
                |> String.dropLeft 1
                |> String.split "/"
                |> List.map (s)
                |> List.reverse
                |> List.foldl (</>) (item)


matchers : String -> Parser (Route -> a) a
matchers base_url =
    oneOf
        [ map HomeRoute (parseBaseUrl base_url top)
        , map AboutRoute (parseBaseUrl base_url (s "about"))
        , map ArchiveRoute (parseBaseUrl base_url (s "archive"))
        , map TrainingRoute (parseBaseUrl base_url (s "training"))
        , map AuthorRoute (parseBaseUrl base_url (s "author"))
        , map PostDetailRoute (parseBaseUrl base_url top </> string)
        ]


parseLocation : Location -> String -> Route
parseLocation location base_url =
    case (parsePath (matchers base_url) location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute


urlFor : String -> Route -> String
urlFor base_url route =
    case route of
        HomeRoute ->
            base_url ++ "/"

        AboutRoute ->
            base_url ++ "/about"

        ArchiveRoute ->
            base_url ++ "/archive"

        TrainingRoute ->
            base_url ++ "/training"

        AuthorRoute ->
            base_url ++ "/author"

        PostDetailRoute slug ->
            base_url ++ slug

        NotFoundRoute ->
            base_url


routingItem : String -> List ( String, String, Route, String )
routingItem base_url =
    [ ( "Posts", "", ArchiveRoute, base_url ++ "/archive" )
    , ( "Training", "", TrainingRoute, base_url ++ "/training" )
    , ( "Portfolio", "", AboutRoute, base_url ++ "/about" )
    , ( "Authors", "", AuthorRoute, base_url ++ "/author" )
    ]


footerRoutingItem : List ( String, String, String )
footerRoutingItem =
    [ ( "Github", "fa fa-github fa-stack-1x fa-inverse", "https://github.com/meilab" )

    --, ( "Wechat", "fa fa-weixin fa-stack-1x fa-inverse", "https://weixin.com" )
    , ( "Weibo", "fa fa-weibo fa-stack-1x fa-inverse", "http://weibo.com/meilab" )
    , ( "Linkedin", "fa fa-linkedin fa-stack-1x fa-inverse", "https://linkedin.com/in/meilab" )
    ]
