Inverse Data Flow指的是反向数据控制，也就是update更新Model，在这一步中，我们需要加入和用户的交互，用户可以通过点击切换选中的大图。

Elm程序中所有的代码逻辑部分都在update函数中，update函数接收一个message，我们可以将其想象成一个容器，这个容器中包含了我们需要完成的动作，与此同时，update函数还接收当前的model，update根据接收到的动作返回一个新的model。**注意**：Elm中所有的数据都是不可更改的，所以update不会去修改model本身，而是返回一个新的model。

我们的程序目前有两个动作，一个是选择大图，一个是什么也不干（那要他干啥呢:)，占个坑，演示一下Union Type）。

定义了如下的Msg之后，我们的update函数可以接受处理两类动作，要么是NoOp，要么是SelectImg，携带一个String表征了选择图片的url地址。

```elm
type Msg
      = NoOp
      | SelectImg String
```

当我们修改了Msg，而没有相应的修改update函数时，elm编译器会报如下错误。非常智能和人性化，已经明确的告诉我们下一步该要如何做:)

使用elm多了之后，就能体会出elm比JavaScript的优势，代码重构将会是一件愉快的事情。

```shell
This `case` does not have branches for all possibilities.

32|>    case msg of
33|>        NoOp ->
34|>            model
You need to account for the following values:

    Main.SelectImg _

Add a branch to cover this pattern!

```

我们接下来所要做的就是根据elm编译器的建议修改update即可。需要提醒新手的是，`{ model | selectedImg = url }`是修改Record的方式，如果model中有很多项，这个表达式只会修改selectedImg为url所表征的字符串。

```elm
update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        SelectImg url ->
            { model | selectedImg = url }
```

到目前为止我们只是在update中处理选择图片的动作，我们还需要让用户来触发选择图片的动作。这里我们需要onClick函数，将其加入到img的attribute中，每当用户点击图片的时候，SelectImg 的Msg就会被触发，进而会触发我们的update函数根据SelectImg中的url来调整model，model更新之后，view函数会根据新的model刷新页面，我们就能看到用户选择的大图了。

```elm
renderImg : String -> Html Msg
renderImg url =
    div [ class "grid-item" ]
        [ img
            [ src url
            , onClick (SelectImg url)
            ]
            []
        ]
```
