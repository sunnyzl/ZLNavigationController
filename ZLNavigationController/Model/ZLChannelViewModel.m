//
//  ZLChannelViewModel.m
//  CustomNavigationController
//
//  Created by zhaoliang on 15/11/11.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ZLChannelViewModel.h"

@implementation ZLChannelViewModel

- (instancetype)initWithTotalArray:(NSArray *)totalArray
{
    if (self = [super init]) {
        self.totalArray = totalArray;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.totalArray forKey:@"totalArray"];
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.totalArray = [aDecoder decodeObjectForKey:@"totalArray"];
    }
    return self;
}

@end
