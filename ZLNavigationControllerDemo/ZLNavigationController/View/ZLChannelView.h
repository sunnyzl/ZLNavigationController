//
//  ZLChannelView.h
//  CustomNavigationController
//
//  Created by zhaoliang on 15/11/11.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ZLChannelViewDelegate <NSObject>
@optional

- (void)selectedTitlesArray:(NSArray *)selectedArray;

@end

@interface ZLChannelView : UIView

@property (nonatomic, assign, readonly) CGFloat viewHeight;
@property (nonatomic, assign) NSInteger selectedToIndex;
@property (nonatomic, weak) id <ZLChannelViewDelegate>delegate;
@property (nonatomic, strong) NSArray *titleNames;

@end
