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
