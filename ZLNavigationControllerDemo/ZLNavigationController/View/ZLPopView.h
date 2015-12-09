//
//  ZLPopView.h
//  CustomNavigationController
//
//  Created by zhaoliang on 15/11/9.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLPopViewDelegate <NSObject>

@optional

- (void)itemPressedWithIndex:(NSInteger)index;

@end

@interface ZLPopView : UIView

@property (nonatomic, weak)     id      <ZLPopViewDelegate>delegate;
@property (nonatomic, assign)   NSInteger selectedToIndex;
@property (nonatomic, strong)   NSArray *titleNames;

- (instancetype)initWithTitleNames:(NSArray *)titleNames;

- (void)show;

@end
