# CEScrollMenue

上篇博客我们聊了[《资讯类App常用分类控件的封装与实现(CollectionView+Swift3.0)》](http://www.cnblogs.com/ludashi/p/6638942.html)，今天的这篇博客就在上篇博客的基础上做些东西。做一个完整的资讯类App中的分类展示、分类切换、分类编辑这一套东西。当然，主要我们还是使用灵活多变的CollectionView来实现。下方我们将会给出程序的运行效果，然后给出核心的代码实现，在文章的末尾我们会给出github上源代码的分享链接。


### 一、运行效果展示

下方的GIF动图就是本篇博客所涉及Demo的运行效果了。首先我们点击第一个页面的“Show Menu Scroll”按钮Push到我们的主菜单页面。主菜单页面上方就是我们的菜单选项了，点击相应的菜单项，会显示相应的内容。当然你对下方内容进行滑动，菜单项也会随之改变。

点击菜单右边的加号，Present出菜单的编辑页面，该页面也就是我们上篇博客所介绍的页面。在该页面我们可以添加新的菜单项，并对已经添加的菜单项进行拖动排序。具体效果如下所示。

![](http://images2015.cnblogs.com/blog/545446/201703/545446-20170331110222102-2041088892.gif)

　　

 

 

### 二、工程目录介绍

下方截图中是本篇博客所涉及到 工程目录。本部分将会对下方的目录进行介绍，从而对整个工程进行了解。

* 1、CEMenuScrollController：CEMenuScrollController控制类就是上面有菜单下方是内容的类，该类是整个实例的主控制器，起到整体的调度作用，负责将各个组件拼接到一块。
* 2、CEContentConllectionView: 该视图就是下方内容展示的视图，主要是随着菜单的改变而显示不同的内容。
* 3、CEScrollMenu: 该组件就是上面那个可以横向滚动的菜单了。
* 4、CESelectTheme: 该组件就是上篇博客所介绍的，负责编辑菜单的组件。
本部分先整体上看一下，下方将会逐步的对每个组件的具体实现进行介绍。
![](http://images2015.cnblogs.com/blog/545446/201703/545446-20170331112912070-485115622.png)

　　

 

 

 

### 三、CEScrollMenu组件的介绍

该组件就是本示例上面横向滚动的菜单项，该组件的右边有一个“+”号按钮，点击该按钮将会通过闭包的形式将按钮的点击事件回调给CEMenuScrollController控制器，由该控制器Present出CESelectTheme组件进行数据源的操作。接下来我们将聊一下CEScrollMenu组件的核心代码。

 

##### 1、点击Cell的操作

下方是位于CEMenuCollectionView中的代码段，也就是点击菜单对应的Cell时所执行的方法。在该方法中主要做了两件事情，第一件事情是点击的Cell如果可以移动到屏幕的中点。然后将Cell的点击事件回调给CEMenuCollectionView的使用者，在回调时，要传入当前点击Cell的indexPath。

![](http://images2015.cnblogs.com/blog/545446/201703/545446-20170331142728664-923825582.png)
　　

 

##### 2、计算菜单Cell的宽度

下方代码段是CEMenuCollectionView中设置Cell尺寸的布局回调。Cell的宽度是从我们的数据源中获取的，我们的Model中有一个itemWidth()方法用来提供显示该item的Cell的宽度。当然该宽度是根据我们菜单名字的个数来获取的。

![](http://images2015.cnblogs.com/blog/545446/201703/545446-20170331150042727-1420540607.png)
　　

 

##### 3、点击菜单项将其置为选择状态

下方代码是CEMenuCollectionViewCell中负责根据Cell的Select状态来修改Cell的显示方案的，具体代码如下所示。当然，Cell是否处于Select状态，我们将此状态是记录在我们的Model中的，这就避免了因为Cell的重用机制而出现的状态不一致的问题。

![](http://images2015.cnblogs.com/blog/545446/201703/545446-20170331150856102-1784832402.png)

 

下方代码就是CEMenuCollectionViewCell初始化时所进行的处理。从下方我们可以看出Cell的isSelected状态是从item中加载的，加载后，调用上述updateStelectState()方法。具体做法如下所示：

![](http://images2015.cnblogs.com/blog/545446/201703/545446-20170331151212664-1803754237.png)
　　

 

关于CEScrollMenu组件的介绍，本篇博客就先介绍这么多，更详细的代码请移步于文章后方的github地址。

 

 

### 四、CEContentCollectionView的介绍

CEContentCollectionView的主要功能是根据Menu的切换来显示相应的内容的，该视图中的内容比较简单。下方是对其核心技术点的介绍。

##### 1、确定用户左右滑动后当前显示的页面

下方三个代理方法是用来确定用户左右滑动内容页后，所显示的Cell。当用户拖动后切换了相应的Cell时，会执行下方的的currentShowCellClosure()闭包，然后将当前显示Cell的indexPath回调给使用者。然后我们可以根据该IndexPath改变Menu当前显示的菜单项。

![](http://images2015.cnblogs.com/blog/545446/201703/545446-20170331151750461-1312544841.png)


 
