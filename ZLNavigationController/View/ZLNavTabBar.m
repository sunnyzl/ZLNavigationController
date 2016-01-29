//
//  ZLNavTabBar.m
//  CustomNavigationController
//
//  Created by zhaoliang on 15/11/11.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ZLNavTabBar.h"
#import "ZLCommonConst.h"
#import "ZLPopView.h"
#import "UIView+ZLFrame.h"

#define TABBAR_TITLE_FONT [UIFont systemFontOfSize:18.f]
#define TABBAR_TITLE_SIZE_FONT [UIFont systemFontOfSize:14.f]

@interface ZLNavTabBar (){
    UIScrollView    *_navigationTabBar;      // 所有控制器标题都在此scollView上
    
    UIView          *_line;                 // 选中控制器标题的下划线
    ZLPopView       *_popView;              // 弹出popView
    
    NSMutableArray  *_items;                // ZLNavTabBar 上的条目
    NSArray         *_itemsWidth;           // 控制器标题的宽度数组
    NSMutableArray  *_itemsShowedTitle;
    CGFloat         _leftImageWidth;
    BOOL            _showArrayButton;
    CGFloat         _navigationTabBarWidth;
    CGFloat         _selectedTitlesWidth;
}

@end

@implementation ZLNavTabBar

- (instancetype)initWithFrame:(CGRect)frame showArrayButton:(BOOL)yesOrNo
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = NavTabbarColor;
        _showArrayButton = yesOrNo;
        [self viewConfig];
    }
    return self;
}

- (void)viewConfig
{
    _items = [@[] mutableCopy];
    _itemsShowedTitle = [@[] mutableCopy];
    
    _navigationTabBarWidth = _showArrayButton ? SCREEN_WIDTH - ARROW_BUTTON_WIDTH : SCREEN_WIDTH;
    
    _navigationTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(ZERO_COORDINATE, ZERO_COORDINATE, _navigationTabBarWidth, NAV_TAB_BAR_HEIGHT)];
    _navigationTabBar.backgroundColor = [UIColor clearColor];
    _navigationTabBar.showsHorizontalScrollIndicator = NO;
    _navigationTabBar.showsVerticalScrollIndicator = NO;
    [self addSubview:_navigationTabBar];
    if (_showArrayButton) {
        UIImage *shadow = [UIImage imageNamed:@"shadow"];
        UIImageView *shadowIcon = [[UIImageView alloc] init];
        shadowIcon.image = shadow;
        shadowIcon.frame = CGRectMake(SCREEN_WIDTH - shadow.size.width, ZERO_COORDINATE, shadow.size.width, shadow.size.height);
        _leftImageWidth = shadow.size.width;
        [self addSubview:shadowIcon];
        
        UIButton *arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
        arrowButton.frame = CGRectMake(_navigationTabBarWidth, ZERO_COORDINATE, ARROW_BUTTON_WIDTH, ARROW_BUTTON_WIDTH);
        arrowButton.backgroundColor = [UIColor clearColor];
        [arrowButton setBackgroundImage:[UIImage imageNamed:@"btn_navigation_close"] forState:UIControlStateNormal];
        [arrowButton addTarget:self action:@selector(arrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:arrowButton];
    }
    
    UIView *dividerView = [[UIView alloc] initWithFrame:CGRectMake(ZERO_COORDINATE, NAVIGATION_BAR_HEIGHT - 1.f, SCREEN_WIDTH, 1.f)];
    dividerView.backgroundColor = UIColorWithRGBA(230, 230, 230, 1.f);
    [self addSubview:dividerView];
}

- (void)showLineWithButtonWidth:(CGFloat)width
{
    _line = [[UIView alloc] initWithFrame:CGRectMake(2.0f, NAV_TAB_BAR_HEIGHT - 3.0f, width - 4.0f, 3.0f)];
    _line.backgroundColor = UIColorWithRGBA(20.0f, 80.0f, 200.0f, 0.7f);
    [_navigationTabBar addSubview:_line];
}

- (NSArray *)getButtonsWidthWithTitles:(NSArray *)titles;
{
    NSMutableArray *widths = [@[] mutableCopy];
    _selectedTitlesWidth = 0;
    for (NSString *title in titles)
    {
        CGSize size = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : TABBAR_TITLE_FONT} context:nil].size;
        CGFloat eachButtonWidth = size.width + 20.f;
        _selectedTitlesWidth += eachButtonWidth;
        NSNumber *width = [NSNumber numberWithFloat:eachButtonWidth];
        [widths addObject:width];
    }
    if (_selectedTitlesWidth < _navigationTabBarWidth) {
        [widths removeAllObjects];
        NSNumber *width = [NSNumber numberWithFloat:_navigationTabBarWidth / titles.count];
        for (int index = 0; index < titles.count; index++) {
            [widths addObject:width];
        }
    }
    return widths;
}



- (CGFloat)contentWidthAndAddNavTabBarItemsWithButtonsWidth:(NSArray *)widths
{
    [self cleanData];
    CGFloat buttonX = ZERO_COORDINATE;
    for (NSInteger index = 0; index < widths.count; index++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, ZERO_COORDINATE, [widths[index] floatValue], NAV_TAB_BAR_HEIGHT);
        button.titleLabel.font = TABBAR_TITLE_FONT;
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:_selectedItemTitles[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_navigationTabBar addSubview:button];
        
        [_items addObject:button];
        buttonX += [widths[index] floatValue];
    }
    if (widths.count) {
        [self showLineWithButtonWidth:[widths[0] floatValue]];
    }
    return buttonX;
}


- (void)cleanData
{
    [_items removeAllObjects];
    [_navigationTabBar.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)arrowBtnClick:(UIButton *)button
{
    _popView = [[ZLPopView alloc] initWithTitleNames:self.totalItemTitles];
    _popView.selectedToIndex = self.selectedToIndex;
    [_popView show];
}

- (void)itemPressed:(UIButton *)button
{
    NSInteger index = [_items indexOfObject:button];
    if ([self.delegate respondsToSelector:@selector(itemDidSelectedWithIndex:)]) {
        [self.delegate itemDidSelectedWithIndex:index];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    UIButton *button = nil;
    //    if (_currentIndex < _items.count) {
    button = _items[currentIndex];
    CGFloat offsetX = button.zl_centerX - _navigationTabBarWidth * 0.5;
    CGFloat offsetMax = _selectedTitlesWidth - _navigationTabBarWidth;
    if (offsetX < 0 || offsetMax < 0) {
        offsetX = 0;
    } else if (offsetX > offsetMax){
        offsetX = offsetMax;
    }
    [_navigationTabBar setContentOffset:CGPointMake(offsetX, ZERO_COORDINATE) animated:YES];
    [UIView animateWithDuration:.2f animations:^{
        _line.frame = CGRectMake(button.frame.origin.x + 2.0f, _line.frame.origin.y, [_itemsWidth[currentIndex] floatValue] - 4.0f, _line.frame.size.height);
    }];
    //    }
    
}


- (void)setSelectedItemTitles:(NSArray *)selectedItemTitles
{
    _selectedItemTitles = selectedItemTitles;
    _itemsWidth = [self getButtonsWidthWithTitles:_selectedItemTitles];
        CGFloat contentWidth = [self contentWidthAndAddNavTabBarItemsWithButtonsWidth:_itemsWidth];
        _navigationTabBar.contentSize = CGSizeMake(contentWidth, ZERO_COORDINATE);
}


#pragma mark - Public Methods
#pragma marl -


@end
