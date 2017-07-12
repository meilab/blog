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
