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

#define TABBAR_TITLE_FONT [UIFont systemFontOfSize:18.f]
#define TABBAR_TITLE_SIZE_FONT [UIFont systemFontOfSize:14.f]

@interface ZLNavTabBar (){
    UIButton        *_arrowButton;
    
    UIScrollView    *_navigationTabBar;      // all items on this scroll view
    
    UIView          *_line;                 // underscore show which item selected
    ZLPopView       *_popView;              // when item menu, will show this view
    
    NSMutableArray  *_items;                // ZLNavTabBar pressed item
    NSArray         *_itemsWidth;           // an array of items' width
    BOOL            _showArrowButton;       // is showed arrow button
    BOOL            _popItemMenu;           // is needed pop item menu
    NSMutableArray  *_itemsShowedTitle;
}

@end

@implementation ZLNavTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = NavTabbarColor;
        [self viewConfig];
    }
    return self;
}

- (void)viewConfig
{
    _items = [@[] mutableCopy];
    _itemsShowedTitle = [@[] mutableCopy];
    
    
    
    
    CGFloat widthWithoutArrow = SCREEN_WIDTH - ARROW_BUTTON_WIDTH;
    
    
    
    _navigationTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(ZERO_COORDINATE, ZERO_COORDINATE, widthWithoutArrow, NAV_TAB_BAR_HEIGHT)];
    _navigationTabBar.backgroundColor = [UIColor clearColor];
    _navigationTabBar.showsHorizontalScrollIndicator = NO;
    _navigationTabBar.showsVerticalScrollIndicator = NO;
    [self addSubview:_navigationTabBar];
    
    UIImage *shadow = [UIImage imageNamed:@"shadow"];
    UIImageView *shadowIcon = [[UIImageView alloc] init];
    shadowIcon.image = shadow;
    shadowIcon.frame = CGRectMake(SCREEN_WIDTH - shadow.size.width, ZERO_COORDINATE, shadow.size.width, shadow.size.height);
    [self addSubview:shadowIcon];
    
    _arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _arrowButton.frame = CGRectMake(widthWithoutArrow, ZERO_COORDINATE, ARROW_BUTTON_WIDTH, ARROW_BUTTON_WIDTH);
    _arrowButton.backgroundColor = [UIColor clearColor];
    [_arrowButton setBackgroundImage:[UIImage imageNamed:@"btn_navigation_close"] forState:UIControlStateNormal];
    [_arrowButton addTarget:self action:@selector(arrowBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_arrowButton];
    
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
    
    for (NSString *title in titles)
    {
        CGSize size = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : TABBAR_TITLE_FONT} context:nil].size;
        NSNumber *width = [NSNumber numberWithFloat:size.width + 20.f];
        [widths addObject:width];
    }
    
    return widths;
}

- (CGFloat)contentWidthAndAddNavTabBarItemsWithButtonsWidth:(NSArray *)widths
{
    [self cleanData];
    CGFloat buttonX = ZERO_COORDINATE;
    for (NSInteger index = 0; index < _selectedItemTitles.count; index++)
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
//    }else {
//        button = [_items firstObject];
//    }
    
    CGFloat flag = SCREEN_WIDTH - ARROW_BUTTON_WIDTH;
    
    if (button.frame.origin.x + button.frame.size.width > flag)
    {
        CGFloat offsetX = button.frame.origin.x + button.frame.size.width - flag;
        if (currentIndex < [_selectedItemTitles count] - 1)
        {
            offsetX = offsetX + 40.f;
        }
        
        [_navigationTabBar setContentOffset:CGPointMake(offsetX, ZERO_COORDINATE) animated:YES];
    }
    else
    {
        [_navigationTabBar setContentOffset:CGPointMake(ZERO_COORDINATE, ZERO_COORDINATE) animated:YES];
    }
    
    
//    if (_currentIndex < _items.count) {
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
