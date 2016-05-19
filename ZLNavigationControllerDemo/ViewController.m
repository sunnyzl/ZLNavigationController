//
//  ViewController.m
//  ZLNavigationControllerDemo
//
//  Created by zhaoliang on 15/12/9.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ViewController.h"
#import "ZLNavTabBarController.h"
#import "ZLTableViewController.h"
#import "ZLTestViewController.h"
#import "ZLCommonConst.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
    navTabBarController.navTabBarColor = [UIColor whiteColor];
    navTabBarController.mainViewBounces = YES;
    navTabBarController.selectedToIndex = 5;
    navTabBarController.unchangedToIndex = 2;
    navTabBarController.showArrayButton = YES;
    [navTabBarController addParentController:self];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
