//
//  UIView+ZLFrame.m
//  ZLQRCodeControllerDemo
//
//  Created by zhaoliang on 15/12/11.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "UIView+ZLFrame.h"

@implementation UIView (ZLFrame)

- (void)setZl_rectX:(CGFloat)zl_rectX
{
    CGRect frame = self.frame;
    frame.origin.x = zl_rectX;
    self.frame = frame;
}

- (CGFloat)zl_rectX
{
    return self.frame.origin.x;
}

- (void)setZl_rectY:(CGFloat)zl_rectY
{
    CGRect frame = self.frame;
    frame.origin.y = zl_rectY;
    self.frame = frame;
}

- (CGFloat)zl_rectY
{
    return self.frame.origin.y;
}

- (void)setZl_rectWidth:(CGFloat)zl_rectWidth
{
    CGRect frame = self.frame;
    frame.size.width = zl_rectWidth;
    self.frame = frame;
}

- (CGFloat)zl_rectWidth
{
    return self.frame.size.width;
}

- (void)setZl_rectHeight:(CGFloat)zl_rectHeight
{
    CGRect frame = self.frame;
    frame.size.height = zl_rectHeight;
    self.frame = frame;
}

- (CGFloat)zl_rectHeight
{
    return self.frame.size.height;
}

- (void)setZl_centerX:(CGFloat)zl_centerX
{
    CGPoint center = self.center;
    center.x = zl_centerX;
    self.center = center;
}

- (CGFloat)zl_centerX
{
    return self.center.x;
}

- (void)setZl_centerY:(CGFloat)zl_centerY
{
    CGPoint center = self.center;
    center.y = zl_centerY;
    self.center = center;
}

- (CGFloat)zl_centerY
{
    return self.center.y;
}

- (void)setZl_size:(CGSize)zl_size
{
    CGRect frame = self.frame;
    frame.size = zl_size;
    self.frame = frame;
}

- (CGSize)zl_size
{
    return self.frame.size;
}

- (void)setZl_origin:(CGPoint)zl_origin
{
    CGRect frame = self.frame;
    frame.origin = zl_origin;
    self.frame = frame;
}

- (CGPoint)zl_origin
{
    return self.frame.origin;
}

@end
