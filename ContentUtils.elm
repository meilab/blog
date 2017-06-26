module ContentUtils exposing (..)

import Types exposing (Content, ContentType(..))
import List
import Pages
import Posts
import Date.Extra
import String
import Routing exposing (Route)


allContent : List Content
allContent =
    Pages.pages ++ Posts.posts


findByRoute : List Content -> Route -> Maybe Content
findByRoute contentList route =
    contentList
        |> List.filter (\item -> item.route == route)
        |> List.head


findBySlug : List Content -> String -> Maybe Content
findBySlug contentList slug =
    contentList
        |> List.filter (\item -> item.slug == slug)
        |> List.head


filterByContentType : List Content -> ContentType -> List Content
filterByContentType contentList contentType =
    contentList
        |> List.filter (\item -> item.contentType == contentType)


filterByTitle : List Content -> Maybe String -> List Content
filterByTitle contentList title =
    case title of
        Just title ->
            contentList
                |> List.filter
                    (\item ->
                        String.contains (String.toLower title) (String.toLower item.title)
                    )

        Nothing ->
            sortByDate contentList


findPosts : List Content -> List Content
findPosts contentList =
    filterByContentType contentList Post


latest : List Content -> Content
latest =
    sortByDate >> List.head >> Maybe.withDefault Pages.notFoundContent


sortByDate : List Content -> List Content
sortByDate =
    List.sortWith (flip contentByDateComparison)


contentByDateComparison : Content -> Content -> Order
contentByDateComparison a b =
    Date.Extra.compare a.publishedDate b.publishedDate
