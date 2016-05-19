//
//  ZLNavTabBarController.h
//  CustomNavigationController
//
//  Created by zhaoliang on 15/11/12.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLNavTabBar;

@interface ZLNavTabBarController : UIViewController

@property (nonatomic, assign) BOOL scrollAnimation;

@property (nonatomic, assign) BOOL mainViewBounces;

@property (nonatomic, assign) BOOL showArrayButton;

@property (nonatomic, strong) NSArray *subViewControllers;        // (the NSArray which store all the subViewControllers)

@property (nonatomic, strong) UIColor *navTabBarColor;
@property (nonatomic, strong) UIColor *navTabBarLineColor;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, assign) NSInteger unchangedToIndex;       //  default value: 0

@property (nonatomic, assign) NSInteger selectedToIndex;        //  default value: 5


/**
 *  初始化（展示子控制器） initialize (show the subViewControllers)
 *
 *  @param subViewControllers 子控制器数组 (the NSArray which store all the subViewControllers)
 *
 *  @return 实例
 */
- (instancetype)initWithSubViewControllers:(NSArray *)subViewControllers;

/**
 *  初始化（并指明父控制器） initialize (appoint the parentViewController)
 *
 *  @param viewController 父控制器 (parentViewController)
 *
 *  @return Instance
 */
- (instancetype)initWithParentViewController:(UIViewController *)viewController;

/**
 *  初始化（指明父控制器，并给子控制器赋值） initialize (assign all subViewControllers and appoint the parentViewController)
 *
 *  @param subControllers 子控制器数组 (the NSArray which store all the subViewControllers)
 *  @param viewController 父控制器 (parentViewController)
 *
 *  @return 实例
 */
- (instancetype)initWithSubViewControllers:(NSArray *)subControllers andParentViewController:(UIViewController *)viewController;

/**
 *  添加父控制器 add the parentViewController
 *
 *  @param viewController 父控制器 (parentViewController)
 */
- (void)addParentController:(UIViewController *)viewController;

@end
