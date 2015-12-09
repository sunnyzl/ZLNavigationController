//
//  ZLChannelViewModel.h
//  CustomNavigationController
//
//  Created by zhaoliang on 15/11/11.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLChannelViewModel : NSObject <NSCoding>

@property (nonatomic, strong) NSArray *totalArray;

- (instancetype)initWithTotalArray:(NSArray *)totalArray;

@end
