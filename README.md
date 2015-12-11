# ZLNavigationController
仿头条导航栏，可存储状态

## 更新2015年12月12日02:24:02
### 1.增加弹出框隐藏功能、优化标题尺寸（全部标题尺寸不超过滚动条的frame时平均计算宽度，超过则按原方法）
navTabBarController.showArrayButton = YES; // yes为显示 no为隐藏
![](https://raw.githubusercontent.com/sunnyzl/ZLNavigationController/master/demo1.gif)
### 2.增加不可改变功能
navTabBarController.unchangedToIndex = 1;// 此值需要比selectedToIndex小
![](https://raw.githubusercontent.com/sunnyzl/ZLNavigationController/master/demo3.gif)
### 3.优化了标题滚动
当点击的标题超过整个滚动条中间时便执行滚动
![](https://raw.githubusercontent.com/sunnyzl/ZLNavigationController/master/demo2.gif)
##使用方法
    UIViewController *oneViewController = [[UIViewController alloc] init];
    oneViewController.title = @"新闻";
    oneViewController.view.backgroundColor = [UIColor brownColor];
    
    UIViewController *twoViewController = [[UIViewController alloc] init];
    twoViewController.title = @"体育";
    twoViewController.view.backgroundColor = [UIColor purpleColor];
    
    ZLTableViewController *threeViewController = [[ZLTableViewController alloc] init];
    threeViewController.title = @"图片";
    threeViewController.view.backgroundColor = [UIColor orangeColor];
    
    UIViewController *fourViewController = [[UIViewController alloc] init];
    fourViewController.title = @"文化";
    fourViewController.view.backgroundColor = [UIColor magentaColor];
    
    UIViewController *fiveViewController = [[UIViewController alloc] init];
    fiveViewController.title = @"二手车";
    fiveViewController.view.backgroundColor = [UIColor yellowColor];
    
    UIViewController *sixViewController = [[UIViewController alloc] init];
    sixViewController.title = @"政治";
    sixViewController.view.backgroundColor = [UIColor cyanColor];
    
    UIViewController *sevenViewController = [[UIViewController alloc] init];
    sevenViewController.title = @"读书";
    sevenViewController.view.backgroundColor = [UIColor blueColor];
    
    UIViewController *eightViewController = [[UIViewController alloc] init];
    eightViewController.title = @"游戏";
    eightViewController.view.backgroundColor = [UIColor greenColor];
    
    UIViewController *ninghtViewController = [[UIViewController alloc] init];
    ninghtViewController.title = @"动漫动画";
    ninghtViewController.view.backgroundColor = [UIColor redColor];
    
    ZLNavTabBarController *navTabBarController = [[ZLNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[oneViewController, twoViewController, threeViewController, fourViewController, fiveViewController, sixViewController, sevenViewController, eightViewController, ninghtViewController];
    navTabBarController.mainViewBounces = YES;
    navTabBarController.selectedToIndex = 5;
    navTabBarController.unchangedToIndex = 1;
    navTabBarController.showArrayButton = NO;
    [navTabBarController addParentController:self];
    可根据需要创建相应的控制器
    