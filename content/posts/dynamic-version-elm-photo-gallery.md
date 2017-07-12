从Dynamic Version开始，我们引入Elm Architecture。Dynamic Version的关注点在于程序的状态，即和显示相关的可变部分。针对我们这个图片应用，目前的可变部分是选中的大图，我们期望点击缩略图后，呈现相应的大图。所以根据**DRY**和**Complete**原则，我们的state就是**selectedImg**

我们在这里引入html package中的beginnerProgram函数，它帮助我们构建Elm Architecture。beginnerProgram函数接收一个Record，这个record包含了我们所说的Elm Architecture的model， view，update。

```elm
main : Program Never Model Msg
main =
    beginnerProgram
        { model = model
        , update = update
        , view = view
        }
```

将我们的Model定义为一个Record，其中只有一项：selectedImg，由于我们的beginnerProgram的参数Record需要一个model函数，我们需要定义其为返回值为Model的函数。有两种方式为Record赋值，这里采用Record名称加参数的方式（Record名称本身就是一个函数，接收若干参数来构建Record），Model Record只有一个key，所以这里的参数"https://source.unsplash.com/3Z70SDuYs5g/800x600"会被复制给selectedImg。

```elm
type alias Model =
    { selectedImg : String }
    
model : Model
model =
    Model "https://source.unsplash.com/3Z70SDuYs5g/800x600"
```

另一种Record赋值方式，类似于我们在给beginnerProgram的参数Record赋值的方式：

```elm
model : Model
model =
    {selectedImg = "https://source.unsplash.com/3Z70SDuYs5g/800x600"} 
```

update函数负责根据不同的Msg修改Model，我们的Msg是一个[Union Type](https://guide.elm-lang.org/types/union_types.html)，当前没有任何操作，所以我们定义一个NoOp，update函数接收到NoOp之后，什么也不做，将model返回。

```elm
type Msg
    = NoOp

update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model
```

如果你跟着我的节奏也在修改代码，就会发现修改的过程中，会导致elm-live编译不成功，elm的编译器会告诉我们哪里需要修改，我们可以根据编译器的提示，一点一点修改，编译通过之后，一般而言就不会有问题了，除非你非常牛逼，整了一个elm编译器发现不了的问题。这一点非常棒，在我们需要增加功能，或者代码重构的时候，个人感觉会非常安心，只需要一点一点的根据编译器的提示修改即可，修改完了代码就直接能用，到目前为止我还没遇到什么问题。这就是所谓的: compilers as assistants

显示部分，只需要将renderSelectedImg的参数换成model.selectedImg即可。每次都会根据Model显示
