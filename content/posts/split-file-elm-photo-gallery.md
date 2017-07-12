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