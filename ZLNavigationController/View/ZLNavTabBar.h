//
//  ZLNavTabBar.h
//  CustomNavigationController
//
//  Created by zhaoliang on 15/11/11.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLNavTabBarDelegate <NSObject>

@optional

- (void)itemDidSelectedWithIndex:(NSInteger)index;

//- (void)popViewAboveNavTabBarDidClickBackButton;

@end

@interface ZLNavTabBar : UIView

@property (nonatomic, weak) id  <ZLNavTabBarDelegate>delegate;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger unchangedToIndex;
@property (nonatomic, strong) NSArray *totalItemTitles;
@property (nonatomic, strong) NSArray *selectedItemTitles;
@property (nonatomic, assign) NSInteger selectedToIndex;
@property (nonatomic, strong) UIColor *lineColor;

@end
