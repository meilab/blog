现代的网站的一个趋势是SPA（Single Page Application），站点内部的网页跳转由客户端进行处理，不会向服务器发起请求重新刷新整个页面，只是向服务器发一些请求（REST等）获取需要展示的资源信息。非SPA方式下，每次刷新页面，都需要重新请求资源（html，Javascript，Css等文件）并刷新整个页面，比较耗时，SPA的好处是页面跳转时，几乎无需等待，用户体验比较好。

我们这一步的目标是一个SPA WebApp：

* 进入我们的页面时，以花瓣网的方式显示一些图片。
* 用户可以搜索特定主题的图片
* 用户点击某一图片时，以全屏大图的方式显示图片。

我们当前将缩略图和选择的大图在同一个页面下显示，我们接下来的目标需要两个页面，一个以瀑布流（类似花瓣网）的方式展示缩略图，另一个页面显示用户点击的大图。

SPA的核心概念是路由，网页客户端要构建一个路由体系，可以使得用户在不同的页面之间跳转，并且根据不同的路由，给用户展示不同的内容。我们需要使用两个新的package来构建SPA体系：

```elm
elm-package install elm-lang/navigation -y
elm-package install evancz/url-parser -y
```

* Navigation帮助我们解析URL地址，并且在URL地址发生变化时，触发相应的update动作来改变我们的Model进而改变我们的View。
* UrlParser为我们提供了一个一些列函数，使得我们可以通过URL地址得到当前路由（在Elm内部表示为Union Type）。

我们之前的入口函数`main` 使用的是Http.program，Navigation其实是在其基础上增加了和以下路由相关的能力：

* 监听浏览器地址的变化。
* 地址发生变化时，触发一个消息。
* 为我们的Elm程序提供了更改浏览器地址的方法。

所以我们需要将`Http.program`换成`Navigation.program OnLocationChange`，每当浏览器地址发生变化时，`OnLocationChange`消息就会被触发，附带Location。相应的，我们需要在Msg中增加`OnLocationChange Location`，同时不同的路由，我们需要呈现给用的内容有所不同，所以需要讲路由（route）加入Model中。

```elm
type Msg
    = NoOp
    | OnLocationChange Location
    | SelectImg String
    | TopicChange String
    | GetPics
    | NewPics (Result Http.Error (List String))
```

```elm
type alias Model =
    { selectedImg : String
    , route : Route
    , topic : String
    , urls : List String
    }


initModel : Route -> Model
initModel route =
    { selectedImg = "https://source.unsplash.com/3Z70SDuYs5g/800x600"
    , route = route
    , topic = "cat"
    , urls = []
    }
```

使用`Navigation.program`后，`init`函数需要做相应的更改，和之前相比，多了一个参数`Location`，Navigation会将初始的浏览器位置传给init函数，我们需要根据浏览器地址解析出当前的路由，然后构建初始Model和Command。路由解析函数`parseLocation`后文讲解。

```elm
init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        currentRoute =
            parseLocation location
    in
        ( initModel currentRoute, getRandomPicCmd )
```

根据Elm Architecture，我们增加了Msg，和Model之后，需要相应的修改update函数，增加对新Msg的处理。

```elm
        OnLocationChange location ->
            let
                route =
                    parseLocation location
            in
                ( { model | route = route }, Cmd.none )
```

上面是和Navigation相关的前期准备工作，修改了程序入口函数，增加了路由相关的Model和Msg，下面我们需要增加路由相关的Union Type以及从地址到路由的匹配。

```elm
module Routing exposing (..)

import Navigation exposing (..)
import UrlParser exposing (..)


type Route
    = HomeRoute
    | PhotoDetailRoute String
    | NotFoundRoute


matchers =
    oneOf
        [ map HomeRoute top
        , map PhotoDetailRoute (s "photo" </> string)
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parsePath matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
```

下面我们详细分析一下相关代码：

#### Route

首先我们使用Union Type定义了我们程序内部的所有可能路由，`NotFoundRoute`作为默认路由，当其他浏览器地址都不能匹配时，匹配到`NotFoundRoute`。使用Union type的好处是，后期增加或者修改`Route`，使用`case of`时，Elm编译器都会帮我们把关，减少出错的可能。

```elm
type Route
    = HomeRoute
    | PhotoDetailRoute String
    | NotFoundRoute
```

#### matchers：

根据定义的`Route`，我们需要两个匹配器(matcher)。

* 将网站的基地址（例如：www.github.com）映射为`HomeRoute`
* /photo/id地址映射为`PhotoDetailRoute String`

```elm
matchers =
    oneOf
        [ map HomeRoute top
        , map PhotoDetailRoute (s "photo" </> string)
        ]
```

#### parseLocation

`parseLocation`根据传入的地址参数，使用之前定义的`matchers`进行匹配，解析出对应的`Route`，如果匹配失败，则返回`NotFoundRoute`。

`parseLocation`会在update函数和init函数中使用，通过location解析出Route，更改Model，从而影响View。

```elm
parseLocation : Location -> Route
parseLocation location =
    case (parsePath matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
```

### 根据Route展示不同的view

上面的更改做完之后，程序应该可以使用，但是和我们之前做的没有任何区别，没有体现出SPA到底是什么东东。

下一步我们就该体现SPA的威力了，根据不同的Route，给用户显示不同的内容，并且在程序中，我们可以更改浏览器地址。

首先是第一步，根据`Route`来显示内容。

```elm
view : Model -> Html Msg
view model =
    case model.route of
        HomeRoute ->
            homeview model

        PhotoDetailRoute id ->
            photoDetailView model

        NotFoundRoute ->
            notFoundView
```

第二步需要根据选择的图片更改浏览器地址，当用户点击缩略图时，`SelectImg` Msg会被触发，我们在update函数处理时，使用`Navigation.newUrl`根据id更改浏览器地址即可。我们需要从`SelectImg`附带的图片URL中获取到图片的id。

```elm
        SelectImg url ->
            let
                id =
                    url
                        |> String.split ("/")
                        |> List.reverse
                        |> List.head
                        |> Maybe.withDefault ""
            in
                ( { model | selectedImg = url }, Navigation.newUrl ("/photo/" ++ id) )
```

