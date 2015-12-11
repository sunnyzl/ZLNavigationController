//
//  UIView+ZLFrame.h
//  ZLQRCodeControllerDemo
//
//  Created by zhaoliang on 15/12/11.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZLFrame)

/**  控件的x轴坐标*/
@property (assign, nonatomic) CGFloat zl_rectX;
/**  控件的y轴坐标*/
@property (assign, nonatomic) CGFloat zl_rectY;
/**  控件的宽度width*/
@property (assign, nonatomic) CGFloat zl_rectWidth;
/**  控件的高度height*/
@property (assign, nonatomic) CGFloat zl_rectHeight;
/**  控件中心点的x轴坐标*/
@property (assign, nonatomic) CGFloat zl_centerX;
/**  控件中心点的y轴坐标*/
@property (assign, nonatomic) CGFloat zl_centerY;
/**  控件的坐标origin*/
@property (assign, nonatomic) CGPoint zl_origin;
/**  控件的大小size*/
@property (assign, nonatomic) CGSize zl_size;

@end
