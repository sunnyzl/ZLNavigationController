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

@property (nonatomic, assign)   BOOL        scrollAnimation;            // 默认值: NO
@property (nonatomic, assign)   BOOL        mainViewBounces;            // 默认值: NO

@property (nonatomic, strong)   NSArray     *subViewControllers;        // 子控制器

@property (nonatomic, strong)   UIColor     *navTabBarColor;            // 不能设置为[UIColor clearColor]
@property (nonatomic, strong)   UIColor     *navTabBarLineColor;

@property (nonatomic, assign) NSInteger unchangedToIndex;

@property (nonatomic, assign) NSInteger selectedToIndex;


/**
 *  初始化（展示子控制器）
 *
 *  @param subViewControllers 子控制器数组
 *
 *  @return 实例
 */
- (instancetype)initWithSubViewControllers:(NSArray *)subViewControllers;

/**
 *  初始化（并指明父控制器）
 *
 *  @param viewController 父控制器
 *
 *  @return Instance
 */
- (instancetype)initWithParentViewController:(UIViewController *)viewController;

/**
 *  初始化（指明父控制器，并给子控制器赋值）
 *
 *  @param subControllers 子控制器数组
 *  @param viewController 父控制器
 *
 *  @return 实例
 */
- (instancetype)initWithSubViewControllers:(NSArray *)subControllers andParentViewController:(UIViewController *)viewController;

/**
 *  添加父控制器
 *
 *  @param viewController 父控制器
 */
- (void)addParentController:(UIViewController *)viewController;

@end
