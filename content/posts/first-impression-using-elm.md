
## Part 0：Hello World project and Elm Arch

#### Hello world

```elm
import Html

main =
    Html.text "Hello, World!"
```

`main`函数是Elm程序的入口，整个程序由`main`开始执行。`import Html`将html package导入当前文件中，使得我们可以在当前文件使用html package定义的一些列操作HTML的函数，在我们的`Hello World`程序中，我们使用了`html` package中的`text`函数，这个函数将一个字符串转换成HTML，并将其加入到DOM树中。我们就可以在最终生成的Html网页看到"Hello, World!"

Elm是前端开发语言，前端的基本任务就是将内容通过Html文件显示出来，所以Elm程序的基本点也是将我们需要表达的内容转换成html，加入到最终的DOM树中，给用户呈现出来。

正式的Elm项目，必然包含了两个package:[core](http://package.elm-lang.org/packages/elm-lang/core/3.0.0/)以及[html](http://package.elm-lang.org/packages/elm-lang/html/latest),当这两个package不能满足我们项目的需求，需要引入其他package时，可以查看[这里](http://package.elm-lang.org/)，或者到Github上搜索一下elm。

Elm的[官方网站](http://elm-lang.org/docs)有很多资料供我们查看，可以常去看看。强烈推荐初学者跟着官方网站的[示例程序](http://elm-lang.org/examples)学习一下基本的Elm用法。



#### Building a Project

每个elm项目都至少有三类文件：**elm-package.json**, ***.elm**, **elm-stuff**

**elm-package.json**可以理解为整个elm项目的配置文件，比较重要的有以下几项：

* source-directories ：elm源文件的路径，编译器会从这些路径中找到`main`函数，开始编译链接整个项目。这是一个数组，需要将所有包含elm源文件的路径都包含进来。
* dependencies ： 列出了项目以来的package。

***.elm** : elm源文件，根据惯例，我们会有一个`Main.elm`文件，其中有`main`函数，作为整个程序的入口。如果是一个大项目，需要在`Main.elm`中，将其他文件**import**进来。

**elm-stuff** ：**elm-package.json**中定义的依赖package都会被下载到这个文件夹中。

```json
{
    "version": "1.0.0",
    "summary": "Photo Gallery example using Elm",
    "repository": "https://github.com/meilab/example.git",
    "license": "MIT",
    "source-directories": [
        ".",
        "static_version/",
        "dynamic_version"
    ],
    "exposed-modules": [],
    "dependencies": {
        "elm-lang/core": "5.1.1 <= v < 6.0.0",
        "elm-lang/html": "2.0.0 <= v < 3.0.0"
    },
    "elm-version": "0.18.0 <= v < 0.19.0"
}

```

#### Commands

* elm-package install
* elm-make Main.elm
* elm-live Main.elm --output=elm.js  --debug --open



`elm-package install -y` 会安装**elm-package.json**中列出的依赖package。 note：没有-y的话，程序会首选询问是否安装，-y相当于yes。

`elm-make Main.elm` 将会编译`Main.elm`，生成index.html，可以直接使用浏览器打开查看结果。带上`--output=elm.js`选项时，会生成elm.js，需要我们自己创建index.html，稍慢，但是好处是我们可以定制CSS style。

`elm-live Main.elm --output=elm.js  --debug --open`：elm-live为我们提供了live-reloading的功能，使得我们可以修改代码的同时，实时查看修改的结果。比较重要的参数选项有`output`，`debug`，`open`，`pushstate`。debug选项为程序增加了很方便的调试功能，记录了每一次Elm内部Model的变化，并且可以将整个过程导入／导出，极大地方便了问题的复现和回归测试，open帮助我们自动打开，节省时间。pushstate选项是SPA时，客户端routing使用的，我们暂时用不到。



#### Quick Start

当我们想要试用Elm构建一个工程时，我们可以先写一个简单的`Main.elm`，类似于我们的Hello World项目，然后敲击`elm-live`命令。它会帮助我们自动创建`elm-package.json`并下载需要的package，非常方便。后续需要别的package时，我们再使用`elm-package install <package-name> -y`安装即可。



## Part 1： Elm Architecture

Hello World程序是我们的一个开胃菜，显示一下对于新手而言，Elm上手简单。Hello World程序只是展示静态的字符串，所以在`main`函数中，直接通过`html`package中的`text`函数就搞定了。Elm真正的实力在于构建动态变化的复杂的**Web App**。

Elm的难能可贵之处在于上手容易，学习曲线相对平缓（当然，需要迈过函数式编程这一关，对于熟悉OO的资深程序员来讲，有一定困难，反而是编程小白会容易掌握函数式编程的理念），等学成高手之后，会发现Elm什么都可以做，而且做得有声有色，除了开发大型Web App之外，Elm还可以用来做以下事情：

* 可以将Elm和Electron结合，使用Elm开发Windows／MAC的桌面程序
* 可以使用[elm-native-ui](https://github.com/ohanhi/elm-native-ui)结合[react-native](https://facebook.github.io/react-native/)开发Android/iOS程序。

Elm开发大型Web App的利器在于**Elm Architecture**，这是一个约定的Elm编程架构。他的基本模式有三大部分：`Model`，`Update`，`View`：

* Model：存储了App的**状态**，用于View进行渲染，是整个Html渲染时的**可变部分**。
* Update：更新Model存储的**状态**。
* View：将状态转换成HTML。

Elm Architecture的核心理念在于将程序的状态统一存储于Model之中，使得数据只能单向流动，Model中的**状态**交给View进行渲染，View不能修改状态，状态只能由Update进行修改，Update由Elm Runtime发起的Command或者View中和用户交互的部分产生的Html Event触发(onClick, onInput, etc…)，Update改变Model之后，更新的State会通过View重新渲染给用户。

我们如何将Elm Architecture应用到自己的项目当中呢？我们可以从易到难分成三个步骤，构建我们的项目（BTW:这是给初学者的建议，高手可以直接通过Model, Update, View的方式直接设计程序的状态，构建项目）。

第一步：Static Version

这一步没有任何和用户的交互，只是将静态的内容提供给用户。注意：有交互的时候才有变化的状态，第一步没有用户的交互，所以不需要思考程序的状态如何设计，只需要将我们期望展现给用户的内容敲入程序即可。

第二步：Dynamic Version

这里所说的状态指的是程序中和显示相关的可变部分（比如这个Photo Gallery中的当前选择的图片）。

我们在设计和确定状态时，需要遵循两个原则：`DRY`， `Complete`，DRY原则主要是指选择状态时，考虑一下这个状态可否由其他的状态计算得来，比如说（摄氏度和华氏度），当我们使用了重复的状态时，对我们而言，不是会不会忘记的问题，而是什么时候忘记的问题，忘记之后，更新状态之类的操作就有可能有问题。Complete原则要求我们将所有变化的项放入状态中，反之，不要将不变的项放入状态中。

第三部：Inverse Data Flow

Elm程序中，有两种方式可以触发Update来改变状态，状态改变之后，View会更新渲染：

* Commands
* HTML Events




## Part 2: static version

在Static Version中，我们关注的是Elm Architecture中的View，只需要关注我们要呈现什么内容给用户，使用什么样的样式。这一版本的目标如下图所示：下半部是四张缩略图，上面是一张大图。

作为Static Version的第一步，完整程序如下：


```elm
module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (src)


main : Html msg
main =
    div []
        [ h1 [] [ text "Photo Gallery" ]
        , div []
            renderThumbnail
        ]


renderThumbnail : List (Html msg)
renderThumbnail =
    List.map renderImg imgUrls


renderImg : String -> Html msg
renderImg url =
    img [ src url ] []


imgUrls : List String
imgUrls =
    [ "https://source.unsplash.com/3Z70SDuYs5g/800x600"
    , "https://source.unsplash.com/01vFmYAOqQ0/800x600"
    , "https://source.unsplash.com/2Bjq3A7rGn4/800x600"
    , "https://source.unsplash.com/t20pc32VbrU/800x600"
    ]
```

imgUrls是一个List，包含四个字符串（图片的Url），第一步的任务是通过Elm程序将四张图片显示出来。熟悉Html的朋友应该知道显示图片，一般需要用到`div`,`h1`和`img`三种`tag`。

elm是函数式编程语言，所有的东西都是函数，包括html的各种tag，Elm中的div，h1和img就是html package提供的函数，类似的函数还有input, button等等。和html tag相关的函数需要两个参数，一个是Attributes（src， class等），一个子节点，这两个参数都是List。

Note：开始阶段我们将不涉及CSS style，所以对于html相关的三个函数div, h1, img，我们只是对img函数提供了src attribute，对于div和h1，第一个参数都是空List。

`main`函数是整个程序的入口，我们调用`div`函数，第一个参数为空List（没有提供attribute），第二个参数是一个List，包含两项：一个h1，一个div。

* h1：h1 [][ text "Photo Gallery" ]
* div：div []  renderThumbnail

Html的element是一个树形结构，每一个分支下面也可以包含子节点，这个程序中顶层是一个div，其下面有两个子节点（h1和一个div），h1的子节点text来显示字符串，子节点div通过函数renderThumbnail生成子节点，renderThumbnail的返回值为：List (Html msg)

渲染图片的函数是renderImg（renderImg : String -> Html msg），其参数是一个字符串，表征图片的网址，返回值是Html。renderImg 调用img函数，将参数字符串（url）传递给src attribute。注意：src也是一个函数（String -> [Attribute](http://package.elm-lang.org/packages/elm-lang/html/2.0.0/Html#Attribute) msg）

renderThumbnail使用了List.map高阶函数，将imgUrls中的url字符串通过renderImg函数转换成html，加入到DOM中以显示。

List.map是最常见的一个高阶函数，接收两个参数（一个转换函数，一个数据List），List.map将数据List中的每一项传入转换函数中，转换的结果（一个List）会被返回。说的有点绕，结合这个例子就明白了。List.map会将imgUrls中的每一个url传给renderImg当作参数，每一次都会返回一个html（img element），List.map会将他们整体作为一个List返回给调用方。 所以最终形成的html文件类似于：

```html
<div>
  <h1>Photo Gallery</h1>
  <div>
    <img src="https://source.unsplash.com/3Z70SDuYs5g/800x600">
    <img src="https://source.unsplash.com/01vFmYAOqQ0/800x600">
    <img src="https://source.unsplash.com/2Bjq3A7rGn4/800x600">
    <img src="https://source.unsplash.com/t20pc32VbrU/800x600">
  </div>
</div>
```

第二部：添加选中照片的大图，并修改CSS Style

```elm
main =
    div [ class "main-container" ]
        [ h1 [] [ text "Photo Gallery" ]
        , renderSelectedImg "https://source.unsplash.com/3Z70SDuYs5g/800x600"
        , renderThumbnail
        ]


renderSelectedImg : String -> Html msg
renderSelectedImg url =
    div [ class "selected-img" ]
        [ renderImg
            url
        ]


renderThumbnail : Html msg
renderThumbnail =
    div [ class "grid" ]
        (imgUrls
            |> List.map renderImg
        )


renderImg : String -> Html msg
renderImg url =
    div [ class "grid-item" ]
        [ img
            [ src url ]
            []
        ]
```

这次重构，`main`函数的主div有三个子节点：h1，renderSelectedImg和renderThumbnail分别表征标题，选中的大图和缩略图（四个小图），renderSelectedImg使用renderImg来渲染选中的大图，renderThumbnail没有变化。

需要注意的是renderImg有一个比较大的变化，在img之上套了一层div。这是因为我们需要使用flexbox来布局，"grid-item"需要放在一个div中(block element)，每个"grid-item"占24%的宽度，每个img占据父节点（"grid-item"）宽度的100%，这样可以四个缩略小图并排放在一起。具体的CSS，看下面文件。

我们期望我们的项目不仅仅是能够工作，而且要很美观并且出色，这就需要通过CSS布局来实现。

从这里开始，我们引入CSS，我们将会使用[normalize.css](http://nicolasgallagher.com/about-normalize-css/)和[flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)，可以将`normalize.css`理解为浏览器默认样式最佳实践的精华版本，为我们提供了跨浏览器的一致性（包括移动端浏览器）。`flexbox`是一种布局方式，翻译过来就是`弹性盒模型`，我们可以定义一个容器，这个容器中的子模块如何分配着个容器的空间。详细介绍推荐大家看一下CSS Tricks中关于flexbox的讲解，深入浅出，通俗易懂，还有几个栗子，[戳这里](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)。

为了使用定制化的CSS，我们就必须自己编写`index.html`并且使用如下的命令:

```shell
elm-live static_version/Main.elm --output=elm.js --open
```

```html
<!DOCTYPE html>
    <html lang="en">
        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width" />
            <title>Image Gallery</title>
            <link rel="stylesheet" href="/css/style.css" type="text/css">
            <link rel="stylesheet" href="/css/normalize.css">
            <script src="elm.js"></script>
        </head>
        <body>
            <div id="elm-container" class="container">
            </div>
            <script charset="utf-8">
                Elm.Main.fullscreen()
            </script>
        </body>
    </html>
```

通过elm-live命令，我们对elm文件的修改会实时编译成**elm.js**，在index.html中奖elm.js引入之后，我们需要在body中至少定义一个div tag，然后在script tag中通过`Elm.Main.fullscreen()`运行我们的程序，下面我们一步一步解释Elm,Main和fullscreen：

* Elm：elm.js暴漏出来的全局变量
* Main：我们这个项目`main`函数的入口在**Main.elm**中，所以我们需要通过Elm.Main来启动程序
* fullscreen()：我们有两种方式可选`fullscreen()`和`embed()`
  * fullscreen()：将elm程序全屏显示
  * embed()：将elm程序嵌入某个div中。

```html
<div id="elm-container" class="container"></div>
<script charset="utf-8">
  	var elmContainer = document.getElementById("elm-container")
    Elm.Main.fullscreen(elmContainer)
</script>
```



下面是具体的CSS文件，我们将 "main-container"设置成flexbox显示，`flex-direction`为`column`，这样就可以将title，renderSelectedImg和renderThumbnail依次纵向排列。缩略图renderThumbnail的容器为`grid`，display也是`flex`，使用默认的横向排列。总共有4个缩略图，所以我们定义"grid-item"的"flex"为24%，每个缩略图占24%的空间，四个图总共96%，留4%的冗余。

同时我们将"grid-item"也设置成flexbox，并将其`justify-content`和`align-items`都设置成**center**，这是因为在"grid-item"内是我们显示图片的`img` tag，我们的选中大图也是这种方式，我们希望选中大图能够居中排列，将图片的容器div("grid-item" class)设置为flexbox后，可以实现居中排列的效果。

我们的CSS中还有一个关键点是对于img tag的设置，`max-width: 100%;` ，`height: auto;`。这样可以可以保证图片根据容器的大小进行弹性伸缩，是responsive design的必选项。

### Make some style

```css
body {
    font-size: 16px;
    font-family: sans-serif;
    padding: 0;
    margin: 0;
}

.main-container {
    display: flex;
    flex-direction: column;
}

.grid {
    display: flex;
    justify-content: space-between;
    align-items:center;
    text-align: center;
}

.grid-item {
    flex:  24%;
    display: flex;
    justify-content: center;
    align-items :center;
}

img {
    max-width: 100%;
    height: auto;
}
```



### 

## Part 3: Dynamic Version

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



## Part 4: Inverse Data flow

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



## Part 5: Advanced: dynamic Urls, get Url from Server : Unsplash

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



## Part 6: 拆分文件

之前我们将所有的代码都放在了Main.elm当中，这并不是最佳实践。我们需要按照功能，将代码拆分到以下文件中：

* Main.elm：整个程序的入口`main`函数在其中。
* Messages.elm：`type Msg`
* Models.elm：
* Update.elm
* Views.elm

需要注意的是:

* 将所在目录加入**elm-package.json**中。
* 模块名要和文件名匹配。例如文件**Models.elm**中，定义模块为：`module Models exposing (..)`。
* 在**Main**模块中import拆分出来的几个模块。
* 拆分出来的模块，有可能需要import其它模块，比如**Update**模块需要import **Messages**和**Models**模块。需要注意的是模块之间不能循环引用。此时**Messages**模块就一定不能引用**Messages**或者**Models**模块中的函数
* 利用Elm编译器给我们的错误提示。





## Part 7: 更进一步：SPA

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

