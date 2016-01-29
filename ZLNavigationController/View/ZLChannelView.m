//
//  ZLChannelView.m
//  CustomNavigationController
//
//  Created by zhaoliang on 15/11/11.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ZLChannelView.h"
#import "ZLCommonConst.h"
#import "ZLChannelViewModel.h"
#import "NSArray+Log.h"

typedef void(^Completion)(void);

#define SELECTED_BUTTON_COLOR             UIColorWithRGBA(55, 199, 252, 1.f)
#define SELECTED_PAN_BUTTON_COLOR         UIColorWithRGBA(55, 199, 252, 0.7)
#define UNSELECTED_BUTTON_COLOR           UIColorWithRGBA(200, 200, 200, 0.5)
#define UNSELECTED_PAN_BUTTON_COLOR       UIColorWithRGBA(200, 200, 200, 0.8)

@interface ZLChannelView (){
    CGPoint _startPoint;
    NSArray *_reorderTitleNamesArray;
}

@property (nonatomic, strong) NSMutableArray *totalArray;
@property (nonatomic, assign) CGRect defaultRect;
@property (nonatomic, strong) NSMutableArray *selectedArray;
@property (nonatomic, strong) NSMutableArray *selectedIndexArray;
@property (nonatomic, strong) NSMutableArray *selectedTotalArray;
@property (nonatomic, assign) int unchangedToIndex;
@property (nonatomic, strong) NSMutableArray *changedTitleArray;

@end

@implementation ZLChannelView
#pragma mark - Private Methods
#pragma mark -

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _unchangedToIndex = [[NSUD objectForKey:UNCHANGED_TO_INDEX] intValue];
    }
    return self;
}

//  仅有在控制器加载顺序，或者控制器个数改变时，或者初始的selectedToIndex改变时，走此方法
- (void)updateSubViewsWithtitleNames:(NSArray *)titleNames;
{
    CGFloat buttonW = (SCREEN_WIDTH - (MAXCOL + 1) * MARGIN) / (CGFloat)MAXCOL;
    CGFloat buttonH = buttonW * 0.6;
    for (int index = 0; index < titleNames.count; index++)
    {
        int row = index / MAXCOL;
        int col = index % MAXCOL;
        CGFloat buttonX = MARGIN + (MARGIN + buttonW) * col;
        CGFloat buttonY = MARGIN + (MARGIN + buttonH) * row;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [button setTitle:titleNames[index] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addLongPressGestureRecognizerInView:button];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.backgroundColor = UNSELECTED_BUTTON_COLOR;
        if (index < self.selectedToIndex - _unchangedToIndex) {
            [self itemPressed:button];
        }
        [NSUD setObject:[NSNumber numberWithInteger:self.selectedToIndex] forKey:SELECTED_TO_INDEX];
        [self addSubview:button];
        [self fitButtonFont:button];
        if (index == titleNames.count - 1) {
            _viewHeight = buttonY + buttonH + MARGIN;
        }
        [self.totalArray addObject:button];
        
    }
    [NSUD setObject:@(NO) forKey:IS_UNCHANGED_TO_INDEX_CHANGED];
    [NSUD synchronize];
}

- (void)updateSubViewsWithTotalArray:(NSArray *)totalArray
{
    [self.selectedArray removeAllObjects];
    for (int index = 0; index < totalArray.count; index++) {
        UIButton *button = totalArray[index];
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addLongPressGestureRecognizerInView:button];
        if (button.selected) {
            [self.selectedArray addObject:button.titleLabel.text];
        }
        [self addSubview:button];
        if (index == totalArray.count - 1) {
            _viewHeight = CGRectGetMaxY(button.frame) + MARGIN;
        }
        [self.totalArray addObject:button];
    }
}

- (void)addLongPressGestureRecognizerInView:(UIView *)view
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureDidPress:)];
    [view addGestureRecognizer:longPress];
}

- (void)longPressGestureDidPress:(UILongPressGestureRecognizer *)longPressGestureRecognizer
{
    UIButton *button = (UIButton *)longPressGestureRecognizer.view;
    self.defaultRect = button.frame;
    if (longPressGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self longPressGestureStateBeganWithGesture:longPressGestureRecognizer button:button];
    } else if (longPressGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        [self longPressGestureStateMovedWithGesture:longPressGestureRecognizer button:button];
        
    } else if (longPressGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [self longPressGestureStateEndedWithGesture:longPressGestureRecognizer button:button];
    }
}

#pragma mark - LongPressAnimationWithDifferentState

- (void)longPressGestureStateBeganWithGesture:(UILongPressGestureRecognizer *)longPressGestureRecognizer button:(UIButton *)button
{
    _startPoint = [longPressGestureRecognizer locationInView:longPressGestureRecognizer.view];
    [self exchangeSubviewAtIndex:[self.subviews indexOfObject:button] withSubviewAtIndex:self.subviews.count - 1];
    [UIView animateWithDuration:0.2 animations:^{
        button.backgroundColor = button.selected ? SELECTED_PAN_BUTTON_COLOR : UNSELECTED_PAN_BUTTON_COLOR;
    } completion:^(BOOL finished) {
    }];
}

- (void)longPressGestureStateMovedWithGesture:(UILongPressGestureRecognizer *)longPressGestureRecognizer button:(UIButton *)button
{
    CGPoint point = [longPressGestureRecognizer locationInView:self];
    [button setFrame:CGRectMake( point.x - _startPoint.x, point.y - _startPoint.y, button.frame.size.width, button.frame.size.height)];
    CGFloat newX = point.x - _startPoint.x + (button.frame.size.width) / 2;
    CGFloat newY = point.y - _startPoint.y + (button.frame.size.height) / 2;
    int currentIndexX = newX / button.frame.size.width;
    int currentIndexY = newY / button.frame.size.height;
    int index = (int)((newX - MARGIN - currentIndexX * MARGIN) / (button.frame.size.width)) + MAXCOL * (int)((newY - MARGIN - currentIndexY * MARGIN) / (button.frame.size.height));
    if (index < self.totalArray.count) {
        [self.totalArray removeObject:button];
        [self.totalArray insertObject:button atIndex:index];
        [self buttonOrderChangedAnimationWithButton:button completion:nil];
    } else {
        [self.totalArray removeObject:button];
        [self.totalArray insertObject:button atIndex:self.totalArray.count];
        [self buttonOrderChangedAnimationWithButton:button completion:nil];
    }
}

- (void)longPressGestureStateEndedWithGesture:(UILongPressGestureRecognizer *)longPressGestureRecognizer button:(UIButton *)button
{
    [self buttonOrderChangedAnimationWithButton:nil completion:^{
        [UIView animateWithDuration:0.3 animations:^{
            button.backgroundColor = button.selected ? SELECTED_BUTTON_COLOR : UNSELECTED_BUTTON_COLOR;
        }completion:^(BOOL finished) {
            [self.selectedArray removeAllObjects];
            [self addUnchangedTitleNamesToArray:self.selectedArray];
            for (UIButton *btn in self.totalArray) {
                if (btn.selected) {
                    [self.selectedArray addObject:btn.titleLabel.text];
                }
            }
            if ([self.delegate respondsToSelector:@selector(selectedTitlesArray:)]) {
                [self.delegate selectedTitlesArray:self.selectedArray];
            }
            
            [self sendNotificationOfSelectedChannelChanged:self.selectedArray];
            [NSUD setObject:self.selectedArray forKey:SELECTED_CHANNEL_NAMES];
            ZLChannelViewModel *channelViewModel = [[ZLChannelViewModel alloc] initWithTotalArray:self.totalArray];
            [NSKeyedArchiver archiveRootObject:channelViewModel toFile:CHANNEL_FILE_PATH];
        }];
    }];
}

- (void)buttonOrderChangedAnimationWithButton:(UIButton *)button completion:(Completion)completion
{
    for (int index = 0; index < self.totalArray.count; index++) {
        int row = index / MAXCOL;
        int col = index % MAXCOL;
        UIButton *btnAtIndex = self.totalArray[index];
        CGFloat buttonW = btnAtIndex.frame.size.width;
        CGFloat buttonH = btnAtIndex.frame.size.height;
        CGFloat buttonX = MARGIN + (MARGIN + buttonW) * col;
        CGFloat buttonY = MARGIN + (MARGIN + buttonH) * row;
        if (self.totalArray[index] != button || button == nil) {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                btnAtIndex.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            } completion:^(BOOL finished) {
                if (completion) {
                    completion();
                }
            }];
        }
    }
}

#pragma mark - Click Methods

- (void)itemPressed:(UIButton *)button
{
    button.selected = !button.selected;
    [button setTitleColor:button.selected ? [UIColor whiteColor] : [UIColor blackColor] forState:UIControlStateNormal];
    button.backgroundColor = button.selected ? SELECTED_BUTTON_COLOR : UNSELECTED_BUTTON_COLOR;
    [UIView animateWithDuration:0.1 animations:^{
        button.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            button.transform = CGAffineTransformIdentity;
        }completion:^(BOOL finished) {
            [self.selectedArray removeAllObjects];
            [self.selectedTotalArray removeAllObjects];
            [self addUnchangedTitleNamesToArray:self.selectedArray];
            for (UIButton *selectedBtn in self.totalArray) {
                if (selectedBtn.selected) {
                    [self.selectedArray addObject:selectedBtn.titleLabel.text];
                }
                [self.selectedTotalArray addObject:selectedBtn];
            }
            if ([self.delegate respondsToSelector:@selector(selectedTitlesArray:)]) {
                [self.delegate selectedTitlesArray:self.selectedArray];
            }
            
            [self sendNotificationOfSelectedChannelChanged:self.selectedArray];
            [NSUD setObject:self.selectedArray forKey:SELECTED_CHANNEL_NAMES];
            ZLChannelViewModel *channelViewModel = [[ZLChannelViewModel alloc] initWithTotalArray:self.selectedTotalArray];
            
            [NSKeyedArchiver archiveRootObject:channelViewModel toFile:CHANNEL_FILE_PATH];
            
        }];
    }];
    
}


#pragma mark - Send Notification
- (void)sendNotificationOfSelectedChannelChanged:(NSArray *)array
{
    NSMutableDictionary *userInfo = [@{} mutableCopy];
    [userInfo setObject:array forKey:SelectedChannelChangedKey];
    [NS_NOTIFICATION_CENTER postNotificationName:SelectedChannelChangedNotification object:nil userInfo:userInfo];
}


#pragma mark - lazyLoad
- (NSMutableArray *)totalArray
{
    if (_totalArray == nil) {
        _totalArray = [NSMutableArray arrayWithCapacity:_titleNames.count];
    }
    return _totalArray;
}

- (NSMutableArray *)selectedArray
{
    if (_selectedArray == nil) {
        _selectedArray = [@[] mutableCopy];
    }
    return _selectedArray;
}

- (NSMutableArray *)selectedIndexArray
{
    if (_selectedIndexArray == nil) {
        _selectedIndexArray = [@[] mutableCopy];
    }
    return _selectedIndexArray;
}

- (NSMutableArray *)selectedTotalArray
{
    if (_selectedTotalArray == nil) {
        _selectedTotalArray = [@[] mutableCopy];
    }
    return _selectedTotalArray;
}

- (NSMutableArray *)changedTitleArray
{
    if (_changedTitleArray == nil) {
        _changedTitleArray = [@[] mutableCopy];
    }
    return _changedTitleArray;
}

- (void)fitButtonFont:(UIButton *)button
{
    NSString *str = button.titleLabel.text;
    CGFloat scaleWH = button.bounds.size.width / button.bounds.size.height;
    CGFloat scaleHW = button.bounds.size.height / button.bounds.size.width;
    CGFloat scale = scaleWH < 1.0 ? scaleWH : scaleHW;
    CGSize maxSize = CGSizeMake(button.bounds.size.width * 0.95, button.bounds.size.height * scale * 0.95);
    CGSize size = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : button.titleLabel.font} context:nil].size;
    int currentFont = (int)button.titleLabel.font.pointSize;
    
    if (size.width <= maxSize.width) {
        while (size.width < maxSize.width && size.height < maxSize.height) {
            currentFont++;
            size = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:currentFont]} context:nil].size;
        }
    } else {
        while (size.width > maxSize.width || size.height > maxSize.height) {
            currentFont--;
            size = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:currentFont]} context:nil].size;
        }
    }
    button.titleLabel.font = [UIFont systemFontOfSize:currentFont];
}

- (void)addUnchangedTitleNamesToArray:(NSMutableArray *)array
{
    for (int index = 0; index < _unchangedToIndex; index++) {
        [array addObject:_titleNames[index]];
    }
}

- (void)setupNewTitleNameArray:(NSArray *)titleNames
{
    for (int index = _unchangedToIndex; index < titleNames.count; index++) {
        [self.changedTitleArray addObject:titleNames[index]];
    }
}

#pragma mark - Public Methods
#pragma marl -
- (void)setTitleNames:(NSArray *)titleNames
{
    ZLChannelViewModel *channelView = [NSKeyedUnarchiver unarchiveObjectWithFile:CHANNEL_FILE_PATH];
    _titleNames = titleNames;
    BOOL isUnchangedValueChanged = [[NSUD objectForKey:IS_UNCHANGED_TO_INDEX_CHANGED] boolValue];;
    [self setupNewTitleNameArray:_titleNames];
    if (![_titleNames compareWithOtherArray:[NSUD objectForKey:TOTAL_TITLE_NAMES]] || isUnchangedValueChanged || channelView.totalArray == nil || [[NSUD objectForKey:SELECTED_TO_INDEX] integerValue] != self.selectedToIndex) {
        [self updateSubViewsWithtitleNames:self.changedTitleArray];
        [NSUD setObject:_titleNames forKey:TOTAL_TITLE_NAMES];
    } else {
        [self updateSubViewsWithTotalArray:channelView.totalArray];
    }
    
}



@end
