Article Series:

part1: Hello World project and Elm Arch (You are here!)

[Part 2: Static Version]()

#### Hello world

```elm
import Html

main =
    Html.text "Hello, World!"
```

`main`函数是Elm程序的入口，整个程序由`main`开始执行。`import Html`将html package导入当前文件中，使得我们可以在当前文件使用html package定义的一些列操作HTML的函数，在我们的`Hello World`程序中，我们使用了`html` package中的`text`函数，这个函数将一个字符串转换成HTML，并将其加入到DOM树中。我们就可以在最终生成的Html网页看到"Hello, World!"

Elm是前端开发语言，前端的基本任务就是将内容通过Html文件显示出来，所以Elm程序的基本点也是将我们需要表达的内容转换成html，加入到最终的DOM树中，给用户呈现出来。

正式的Elm项目，必然包含了两个package: [core](http://package.elm-lang.org/packages/elm-lang/core/3.0.0/) and [html](http://package.elm-lang.org/packages/elm-lang/html/latest),当这两个package不能满足我们项目的需求，需要引入其他package时，可以查看[这里](http://package.elm-lang.org/)，或者到Github上搜索一下elm。

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

