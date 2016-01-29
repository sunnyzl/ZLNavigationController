//
//  ZLCommonConst.h
//  CustomNavigationController
//
//  Created by zhaoliang on 15/11/12.
//  Copyright © 2015年 zhao. All rights reserved.
//

#ifndef ZLCommonConst_h
#define ZLCommonConst_h

#pragma mark - **** Common Macro ****
#pragma mark -

#import "AppDelegate.h"

#define APP_DELEGATE_INSTANCE                       ((AppDelegate*)([UIApplication sharedApplication].delegate))
#define MAIN_STORY_BOARD(Name)                      [UIStoryboard storyboardWithName:Name bundle:nil]
#define NS_NOTIFICATION_CENTER                      [NSNotificationCenter defaultCenter]

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_OS_5_OR_LATER                            SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0")
#define IS_OS_6_OR_LATER                            SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0")
#define IS_OS_7_OR_LATER                            SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
#define IS_OS_8_OR_LATER                            SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")

#define IS_WIDESCREEN_4S_OR_4                       (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)480) < __DBL_EPSILON__)
#define IS_WIDESCREEN_5                            (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < __DBL_EPSILON__)
#define IS_WIDESCREEN_6                            (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)667) < __DBL_EPSILON__)
#define IS_WIDESCREEN_6Plus                        (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)736) < __DBL_EPSILON__)
#define IS_IPHONE                                  ([[[UIDevice currentDevice] model] isEqualToString: @"iPhone"] || [[[UIDevice currentDevice] model] isEqualToString: @"iPhone Simulator"])
#define IS_IPOD                                    ([[[UIDevice currentDevice] model] isEqualToString: @"iPod touch"])

#define IS_IPHONE_5_OR_EARLIER                     [[UIScreen mainScreen] bounds].size.height <= 568.f
#define IS_IPHONE_5_AND_5S                         (IS_IPHONE && IS_WIDESCREEN_5)
#define IS_IPHONE_6_AND_6S                         (IS_IPHONE && IS_WIDESCREEN_6)
#define IS_IPHONE_6Plus_AND_6SPlus                 (IS_IPHONE && IS_WIDESCREEN_6Plus)


#define SCREEN_WIDTH                    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                   ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_BOUNDS                   [UIScreen mainScreen].bounds

#define ZERO_COORDINATE                  0.0f
#define STATUS_BAR_HEIGHT               20.0f
#define BAR_ITEM_WIDTH_HEIGHT           30.0f
#define NAVIGATION_BAR_HEIGHT           44.0f
#define TAB_TAB_HEIGHT                  49.0f
#define TABLE_VIEW_ROW_HEIGHT           NAVIGATION_BAR_HEIGHT
#define TOP_VIEW_HEIGHT                 (STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)
#define CONTENT_VIEW_HEIGHT_NO_TAB_BAR  (SCREEN_HEIGHT - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT)
#define CONTENT_VIEW_HEIGHT_TAB_BAR     (CONTENT_VIEW_HEIGHT_NO_TAB_BAR - TAB_TAB_HEIGHT)

#define UIColorFromRGB(rgbValue)        [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0f green:((float)((rgbValue & 0xFF00) >> 8))/255.0f blue:((float)(rgbValue & 0xFF))/255.0f alpha:1.0f]
#define UIColorWithRGBA(r,g,b,a)        [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]


#define IFISNIL(v)                      (v = (v != nil) ? v : @"")
#define IFISNILFORNUMBER(v)             (v = (v != nil) ? v : [NSNumber numberWithInt:0])
#define IFISSTR(v)                      (v = ([v isKindOfClass:[NSString class]]) ? v : [NSString stringWithFormat:@"%@",v])

#define NSUD                            [NSUserDefaults standardUserDefaults]
#define CHANNEL_FILE_PATH               [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"channelViewModel.archiver"]
#define SELECTEDVC_FILE_PATH            [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"selectedVCModel.archiver"]

#define TOTAL_VIEWCONTROLLER_FILE_PATH  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"totalVCModel.archiver"]

#define TOTAL_TITLE_NAMES               @"TOTAL_TITLE_NAMES"
#define VIEWCONTROLLER_INDEX_DICT       @"VIEWCONTROLLER_INDEX_DICT"
#define SELECTED_CHANNEL_NAMES          @"SELECTED_CHANNEL_NAMES"
#define SELECTED_TO_INDEX               @"SELECTED_TO_INDEX"
#define CURRENT_PRESS_INDEX             @"CURRENT_PRESS_INDEX"
#define CURRENT_TITLE                   @"CURRENT_TITLE"
#define UNCHANGED_TO_INDEX              @"UNCHANGED_TO_INDEX"
#define IS_UNCHANGED_TO_INDEX_CHANGED   @"IS_UNCHANGED_TO_INDEX_CHANGED"


#define SelectedChannelChangedNotification @"SelectedChannelChangedNotification"
#define SelectedChannelChangedKey          @"SelectedChannelChangedKey"

#define SYSTEM_FONT(fontSize)           [UIFont systemFontOfSize:(fontSize)]
#define BOLD_SYSTEM_FONT(fontSize)      [UIFont boldSystemFontOfSize:(fontSize)]

#pragma mark - **** Constants ****
#pragma mark -

#define ARROW_BUTTON_WIDTH              NAVIGATION_BAR_HEIGHT
#define NAV_TAB_BAR_HEIGHT              ARROW_BUTTON_WIDTH
#define ITEM_HEIGHT                     NAV_TAB_BAR_HEIGHT
#define TABBAR_TITLE_FONT               [UIFont systemFontOfSize:18.f]
#define MAXCOL                          (IS_IPHONE_5_OR_EARLIER ? 4 : 5)
#define MARGIN                          10.f

#define NavTabbarColor                  UIColorWithRGBA(221, 248, 254, 1.f)

#endif /* ZLCommonConst_h */
