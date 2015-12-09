//
//  ZLPopView.m
//  CustomNavigationController
//
//  Created by zhaoliang on 15/11/9.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ZLPopView.h"
#import "UIImage+ImageEffects.h"
#import "ZLCommonConst.h"
#import "ZLChannelView.h"

#define CHANNEL_TITLE_LABEL_FONT             [UIFont boldSystemFontOfSize:20.f]
#define BACKBUTTON_SCALE           0.7f

@interface ZLPopView ()

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) ZLChannelView *channelView;
@property (nonatomic, strong) UILabel *discripeLabel;

@end

@implementation ZLPopView

- (instancetype)initWithTitleNames:(NSArray *)titleNames
{
    if (self = [super init]) {
        self.titleNames = titleNames;
        [self viewConfig];
    }
    return self;
}

- (void)viewConfig
{
    [self setupBackgroundView];
    [self setupTopView];
    [self setupContentView];
}

- (void)setupBackgroundView
{
    _backgroundView = [[UIImageView alloc] initWithFrame:SCREEN_BOUNDS];
    UIImage *image = [self convertViewToImage];
    UIImage *blurImage = [image applyExtraLightEffect];
    _backgroundView.image = blurImage;
    [self addSubview:_backgroundView];
    [self sendSubviewToBack:_backgroundView];
}

- (void)setupTopView
{
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(ZERO_COORDINATE, ZERO_COORDINATE, SCREEN_WIDTH, STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)];
    topView.backgroundColor = NavTabbarColor;
    [self addSubview:topView];
    
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(ZERO_COORDINATE, ZERO_COORDINATE, SCREEN_WIDTH, STATUS_BAR_HEIGHT)];
    statusView.backgroundColor = [UIColor clearColor];
    [topView addSubview:statusView];
    
    _navView = [[UIView alloc] initWithFrame:CGRectMake(ZERO_COORDINATE, STATUS_BAR_HEIGHT, SCREEN_WIDTH, NAVIGATION_BAR_HEIGHT)];
    _navView.backgroundColor = [UIColor clearColor];
    [topView addSubview:_navView];
    
    [self setupContentOfNavView];
    
}

- (void)setupContentView
{
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(ZERO_COORDINATE, TOP_VIEW_HEIGHT, SCREEN_WIDTH, CONTENT_VIEW_HEIGHT_NO_TAB_BAR)];
    [self addSubview:_contentScrollView];
    
    _discripeLabel = [[UILabel alloc] init];
    _discripeLabel.text = @"点亮你的兴趣频道，长按拖拽可排序";
    _discripeLabel.textColor = UIColorWithRGBA(120, 120, 120, 1.f);
    CGFloat fontSize = IS_IPHONE_5_OR_EARLIER ? 14.f : (IS_IPHONE_6_AND_6S ? 16.f : 18.f);
    _discripeLabel.font = SYSTEM_FONT(fontSize);
    CGSize labelSize = [self calculateStringSizeWithString:_discripeLabel.text font:_discripeLabel.font];
    _discripeLabel.frame = CGRectMake(MARGIN, MARGIN, ceil(labelSize.width), ceil(labelSize.height));
    [_contentScrollView addSubview:_discripeLabel];
    
    _channelView = [[ZLChannelView alloc] init];
    [_contentScrollView addSubview:_channelView];
    
}

- (void)setupContentOfNavView
{
    UILabel *navNameLabel = [[UILabel alloc] init];
    navNameLabel.font = CHANNEL_TITLE_LABEL_FONT;
    navNameLabel.text = @"频道管理";
    CGSize labelSize = [self calculateStringSizeWithString:navNameLabel.text font:CHANNEL_TITLE_LABEL_FONT];
    CGFloat labelX = (SCREEN_WIDTH - labelSize.width) / 2;
    CGFloat labelY = NAVIGATION_BAR_HEIGHT - MARGIN - labelSize.height;
    navNameLabel.frame = (CGRect){{labelX, labelY}, labelSize};
    [_navView addSubview:navNameLabel];
    
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.adjustsImageWhenHighlighted = NO;
    CGFloat backButtonX = SCREEN_WIDTH -  ARROW_BUTTON_WIDTH;
    _backButton.frame = CGRectMake(backButtonX, ZERO_COORDINATE, ARROW_BUTTON_WIDTH, ARROW_BUTTON_WIDTH);
    [_backButton setBackgroundImage:[UIImage imageNamed:@"btn_navigation_back"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:_backButton];
    
    UIView *dividerView = [[UIView alloc] initWithFrame:CGRectMake(ZERO_COORDINATE, NAVIGATION_BAR_HEIGHT - 1.f, SCREEN_WIDTH, 1.f)];
    dividerView.backgroundColor = UIColorWithRGBA(230, 230, 230, 1.f);
    [_navView addSubview:dividerView];
    
}

#pragma mark - Private Methods
#pragma mark -

- (void)setSelectedToIndex:(NSInteger)selectedToIndex
{
    _selectedToIndex = selectedToIndex;
    _channelView.selectedToIndex = _selectedToIndex;
    _channelView.titleNames = self.titleNames;
}

- (void)backButtonDidClick:(UIButton *)button
{
    [self dismiss];
}

- (CGSize)calculateStringSizeWithString:(NSString *)string font:(UIFont *)font
{
    return [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (UIImage *)convertViewToImage
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size,YES,0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *capturedScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capturedScreen;
}

- (void)show
{
    self.frame = SCREEN_BOUNDS;
    self.opaque = NO;
    
    _channelView.frame = CGRectMake(ZERO_COORDINATE, CGRectGetMaxY(_discripeLabel.frame), SCREEN_WIDTH, _channelView.viewHeight);
    CGFloat maxHeight = _channelView.viewHeight > CONTENT_VIEW_HEIGHT_NO_TAB_BAR ? _channelView.viewHeight : CONTENT_VIEW_HEIGHT_NO_TAB_BAR + 1;
    _contentScrollView.contentSize = CGSizeMake(ZERO_COORDINATE, maxHeight);
    self.alpha = 0.f;
    UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
    [appWindow addSubview:self];
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1.f;
        _backButton.transform = CGAffineTransformMakeScale(BACKBUTTON_SCALE, BACKBUTTON_SCALE);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            _backButton.transform = CGAffineTransformIdentity;
        }];
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.f;
        _backButton.transform = CGAffineTransformMakeScale(BACKBUTTON_SCALE, BACKBUTTON_SCALE);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}



@end
