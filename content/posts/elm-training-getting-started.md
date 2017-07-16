家里领导在学校当老师，每年带的本科毕业设计学生当中，都会有学生学习成绩挺好，但是几乎没有编程能力，但是因为专业的关系，大多数学生还要找一份程序员的工作。所以导致有些学习能力不错的学生，找的工作并不理想。

领导上学时也有这种困惑，除了编程之外的课程，领导都是学霸，但是面对编程时，领导不知道该如何去学习。

其实这类人都挺聪明的，能把高数，复变函数，随机过程学好的人，智商都不低，只是没有找到学习编程的方法，所以领导和我商量能否针对这类学生进行一些培训，帮助大家掌握编程的核心理念。

第一阶段，我选择Elm和C作为主语言。为什么选择Elm，请参见[我为什么选择Elm](https://meilab.github.io/elm_blog/post/why-I-choose-elm)。选择C是因为嵌入式开发，限于平台能力，一般只能用C。学习了这两种语言，也可以帮助大家在更高的维度去理解编程的本质。

## 目标

* 从更宏观的角度理解编程
  * 使用各种语言提供的语言特性解决实际的问题
  * 使用合适的语言去为我们的实际问题建模
* 理解函数式编程的核心：
  * 编程就是数据转换
  * 声明式编程：描述要什么，而不是如何做。
* 体验编程的乐趣

## 主要内容

* Elm当中我们常用的语言特性
  * 变量定义
  * 算术运算
  * 函数定义，函数调用
  * 表达式
  * Union Type
  * lambda函数
  * curry
* 几个实战项目：如何使用这些语言特性解决项目中的问题

## 前期准备的工具

* Vim
* VS Code：需要安装如下扩展
  * HTML Snippets
  * JavaScript (ES6) code snippets
  * elm
  * elm-format
* Nodejs & npm
* lr-http-server : http server with live-reloading
* elm：包含如下几项
  * elm-repl
    * :help
    * :exit
  * elm-reactor
  * elm-make
    * elm-make Main.elm --output=index.html
  * elm-package
    * elm-package install <package-name>
* elm-live
  * 安装命令：npm install --global elm elm-live
  * 常用命令：
    * elm-live Main.elm --debug --open
    * elm-live Main.elm --output=elm.js --debug --open
  * options:
    * --debug
    * --open
    * --port=PORT
    * --pushstate : client-side routing
* Chrome / Firefox
