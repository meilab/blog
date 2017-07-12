在之前的例子中，我们将需要展示的图片存储在**imgUrls**中，我们希望能够让这个项目更进一步，从网络上获取图片，并且可以有图片搜索功能，获取制定关键词的图片。这个需求，就要求我们需要根据关键词从网络上获取图片的地址，然后将它们显示出来。所以我们的**Model**也需要增加一个topic和一个图片地址的列表。

```elm
type alias Model =
      { topic : String
      , urls : List String
      , selectedImg : String
      }
```

根据新的需求，我们的`view`也需要发生变化，需要有一个输入框，我们可以输入搜索的关键词，需要有一个按钮，点击之后开始搜索。

相应的，我们的Msg也要跟着做出改变，需要有一个`TopicChange`每当用户输入关键词时触发，这个`TopicChange`会附带一个String表征用户输入的关键词，我们期望`TopicChange`的Msg发生时，在update函数中改变Model中的`topic`。另一个需求是每当用户点击搜索按钮时，我们需要从网络获取图片地址，这就需要一个Http request。在Elm中，Http request是一个**Command**，当我们需要触发一个**Command**时，我们只是告诉Elm runtime，这是我们需要的**Command**，然后等待Elm runtime来执行这个**Command**，然后返回给我们结果。这就是所谓的声明式编程(Declarative)，我们只是指出**What**，而不是明确的说明**How to**，这就好比我们想吃饭时，到了餐厅，只需要告诉服务员，我想要一份宫保鸡丁，厨师会负责做出这道菜，由服务员给我们上菜。对我们而言，好处是我们只需要关注我们的核心业务，一些复杂繁琐的业务实现，由Elm runtime来完成，减轻了开发者的大脑负担，程序的bug会减少。

所以需要增加的两个Msg，一个是`GetPics`一个是`NewPics (Result Http.Error (List ReturnPic))`。当用户点击搜索按钮时，`GetPics` Msg被触发，在update中我们发出一个Http Request交由 Elm runtime处理，图片搜索结果返回之后，Elm runtime会触发`NewPics` Msg，我们在update中对返回结果进行处理，更新我们Model中的urls。需要注意的是`NewPics`是一个`Result`，这个Result将有两种可能的结果：1，成功的返回一个图片Url的List。2，Http.Error（服务器down机，无效的Url等）

```elm
type Msg
      = SelectImg String
      | TopicChange String
      | GetPics
      | NewPics (Result Http.Error (List String))
```

注：Result是一个Union Type，用于描述一个可能失败的逻辑，有两个可能的值。

```elm
type Result error value
  = Err error
  | Ok value
```

因为需要Http Request，我们需要安装http package：

```shell
elm-package install elm-lang/http -y
```



### program函数: 

在新一版的程序中，我们需要将使用 `program` 来替代 `beginnerProgram`，program最大的不同在于其update函数，返回值不只是**Model**，而是一个**Tuple**： `( Model, Cmd Msg )`。

原因有两点：

* 当用户点击搜索按钮时，我们需要触发一个**Command**
* 我们需要一个初始**Command**来获取一些随机图片地址来显示。

```elm
main : Program Never Model Msg
  main =
      program
          { init = init
          , update = update
          , view = view
          , subscriptions = subscriptions
          }
```



### 扩充update函数

修改了Msg之后，**elm-live**就会给我们报错，告知我们在update中，没有对所有的可能Msg进行处理，这一点就是Elm编译器和Union Type配合起来的强大之处，在添加新功能，或者做代码重构时，编译器会帮助我们找到我们遗漏的点，并且以很人性化的方式提示我们，Elm的编译器错误提示信息非常直观，有效。

对于`TopicChange` Msg，在update中将新的topic赋值给model。

对于`GetPics`，我们暂时什么都不变，保证编译通过，后续再触发Http Request。

对于`NewPics`，有两种可能性，发生错误时（`(Err error)`），我们假装什么都没发生:)。

收到成功的返回时（`(Ok urls)`），我们将收到的url地址复制给model。

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        SelectImg url ->
            ( { model | selectedImg = url }, Cmd.none )

        TopicChange topic ->
            ( { model | topic = topic }, Cmd.none )

        GetPics ->
            ( model, Cmd.none )

        NewPics (Err error) ->
            ( model, Cmd.none )

        NewPics (Ok urls) ->
            ( { model | urls = urls }, Cmd.none )
```



### 添加搜索框

为我们的程序添加一个搜索框，由三部分组成，一个`label`用来提示用户搜索框的用途。一个`input`用来接收用户的输入，我们为其加入`onInput`的attribute，每当用户输入字符时，`TopicChange` Msg就会被触发将用户的输入传入update函数，update函数更新Model中的topic状态，第三部分是一个`button`，我们为其加入`onClick`的attribute，每当用户点击这个`button`时，`GetPics` Msg就会被触发，update函数中，我们就需要根据记录的**topic**来发起Http Request来获取相关的图片url。

```elm
topicSelector : Html Msg
topicSelector =
    div [ class "topic-selector" ]
        [ label [] [ text "主题" ]
        , input [ onInput TopicChange ] []
        , button [ onClick GetPics ] [ text "搜索" ]
        ]
```

我们期望搜索框居中显示，所以将其容器"topic-selector"设置为`display:flex;`，我们期望"topic-selector"的剩余空间都分配给`input`，label和button只占据其本身的大小，所以设置其`flex:1;`，添加一些`padding`和`margin`方便用户查看。

注意：`.topic-selector input`指的是class topic-selector的子节点中的input，不会影响其它input的样式。

```css
.topic-selector {
    display:flex;
    justify-content:center;
    align-items:center;
    padding: 1.5em;
}

.topic-selector input {
    flex:1;
    margin: 0 1em;
}
```



### 添加Http Request

我们需要先做一些准备工作，了解一下**unsplash**。

我们这一阶段的目标是从网络获取和关键词有关的图片地址，然后显示出来，可以满足我们这个需求的方式有多种，比如unsplash，flickr，甚至搜索引擎等方式。我试了几种，觉得unsplash比较方便易用，且免费。所以这里选择**unsplash**。

需要首先申请成为**unsplash**的开发者，[戳这里](https://unsplash.com/developers)。然后[在这里](https://unsplash.com/oauth/applications)创建一个App，就可以得到AppId和Secret。我们就可以开始我们的**unsplash**之旅了。

其API基地址为：https://api.unsplash.com/。当我们需要获取公共信息（不包含用户等的私有信息），相对简单，我们只需要将我们获取的AppId通过header或者query param的方式带给**unsplash**即可。比如：https://api.unsplash.com/photos/?client_id=YOUR_APPLICATION_ID。

我们这一步的需求是搜索对应关键词的图片，其地址为：/search/photos，也就是https://api.unsplash.com/search/photos/?client_id=YOUR_APPLICATION_ID出了携带AppId之外，我们还需要在**query params**中携带我们需要查询的关键词(query)。当我们查询关键词为**cat**时，REST 请求地址为：

https://api.unsplash.com/search/photos/?client_id=YOUR_APPLICATION_ID&query=cat

注意：query params需要两项：

* client_id：申请到的AppId
* query：查询的关键词

前面简单介绍了**unsplash**的用法，下面开始真正的激动人心的Http Request的处理。

相关程序如下：

```elm
client_id : String
client_id =
    Your AppId


getPictureCmd : String -> Cmd Msg
getPictureCmd topic =
    let
        url =
            "https://api.unsplash.com/search/photos/"
                ++ "?query="
                ++ topic
                ++ "&client_id="
                ++ client_id
    in
        Http.send NewPics (Http.get url picsDecoder)


picsDecoder : JD.Decoder (List String)
picsDecoder =
    JD.at [ "results" ] (JD.list itemDecoder)


itemDecoder : JD.Decoder String
itemDecoder =
    JD.at [ "id" ] JD.string
```



发送Http Request有两个关键步骤。第一步，我们通过`Http.get`构建一个Http Request，第二步，通过`Http.send`将其转换成一个Command，交给Elm runtime。

* `Http.get : String -> Decode.Decoder value -> Http.Request value`

Http.get接收两个参数，第一个是REST请求的URL地址，第二个参数是[JSON Decoder](https://guide.elm-lang.org/interop/json.html)，我会在其他文章中详述JSON Decoder，目前我们只需要理解它将服务器返回给我们的JSON对象转换成Elm内部的可用的数据。我们的目标是提取出服务器返回值当中每个图片的id，然后根据这个id，拼装出图片的URL。**unsplash**给我们的返回值是一个JSON对象，其中的result包含一个数组，数组的每一项是一个对象，其中有一项是我们需求的id。

tips：我们可以先使用Postman或者Chrome的REST API扩展，来测试一下unsplash的API，查看他的返回值的结构，确定我们需要哪些项。

* `Http.send : (Result Error value -> msg) -> Http.Request value -> Cmd msg`

Http.send将我们构建的Http Request转换成一个Command，第二个参数是我们生成的Http Request，第一个参数是一个函数，用来构造Http结果的Msg：NewPics。



### 更新Update

根据`picsDecoder`的定义，我们构建的Http Request成功返回时，会携带搜索到图片的id，我们在update函数中通过id构建图片的URL，这里用到了List.map以及匿名函数来实现。

```elm
GetPics ->
            ( model, getPictureCmd model.topic )

NewPics (Ok ids) ->
            let
                urls =
                    ids
                        |> List.map (\id -> "https://source.unsplash.com/" ++ id ++ "/800x600")
            in
                ( { model | urls = urls }, Cmd.none )
```



`renderThumbnail`将不在渲染固定的图片，需要根据获取的图片url来显示。

```elm
renderThumbnail : Model -> Html Msg
renderThumbnail model =
    div [ class "grid" ]
        (model.urls
            |> List.map renderImg
        )
```

### 构建初始随机图片

目前我们可以搜索特定主题的图片，但是有个小遗憾，在刚进入这个页面时，我们还没有点击搜索按钮，没有任何图片供缩略图显示。我们需要更改`init`函数，在开始阶段获取一些随机图片供用户欣赏。

新的Command：`getRandomPicCmd`和之前的`getPictureCmd`相比，区别仅在于REST请求的URL不一样，decoder不一样。decoder是根据网络的返回值来确定。random图片请求，unsplash服务器发回来的直接就是一个数组，所以我们的`randomPicDecoder`相对更简单一些。

```elm
init : ( Model, Cmd Msg )
init =
    ( initModel, getRandomPicCmd )
```



```elm
getRandomPicCmd : Cmd Msg
getRandomPicCmd =
    let
        url =
            "https://api.unsplash.com/photos/random/"
                ++ "?count=10"
                ++ "&client_id="
                ++ client_id
    in
        Http.send NewPics (Http.get url randomPicDecoder)


randomPicDecoder : JD.Decoder (List String)
randomPicDecoder =
    JD.list itemDecoder
```
