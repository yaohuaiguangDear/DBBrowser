//
//  DBBrowserMacro.h
//  DBBrowser
//  宏定义的方法
//  Created by yao on 2019/5/15.
//  Copyright © 2019 yao. All rights reserved.
//

#ifndef DBBrowserMacro_h
#define DBBrowserMacro_h

// 日志输出
#ifdef DEBUG
#define DBLog(...) NSLog(__VA_ARGS__)
#else
#define DBLog(...)
#endif
//判断机型
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
//比例
#define SCREEN_Size_Proportion (SCREEN_WIDTH / 375)
#define SCREEN_WIDTH_IPHONE_6 375
#define SCREEN_HEIGHT_IPHONE_6 667
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPHONE_X (IS_IPHONE && SCREEN_MAX_LENGTH == 812.0)

#define IS_IPHONE_XR ([UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)

#define IS_IPHONE_XMAX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)&& !IS_IPAD : NO)

#define isIphoneXDeviceLater ({\
int tmp = 0;\
if (@available(iOS 11.0, *)) {\
if ([UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom > 0.0) {\
tmp = 1;\
}else{\
tmp = 0;\
}\
}else{\
tmp = 0;\
}\
tmp;\
})


//判断版本号
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS10Later ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)
#define iOS11Later ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)

// 状态栏高度
#define DB_STATUS_BAR_HEIGHT (isIphoneXDeviceLater ? 44.f : 20.f)
// 导航栏高度
#define DB_NAVIGATION_BAR_HEIGHT (isIphoneXDeviceLater ? 88.f : 64.f)
// tabBar高度
#define DB_TAB_BAR_HEIGHT (isIphoneXDeviceLater ? (49.f+34.f) : 49.f)
// home indicator
#define DB_HOME_INDICATOR_HEIGHT (isIphoneXDeviceLater ? 34.f : 0.f)

//整个屏幕的高度
#define DB_VIEW_HEIGHT (SCREEN_HEIGHT)
//去掉状态栏高度
#define DB_VIEW_HEIGHT_NO_STATUS ((SCREEN_HEIGHT) - (DB_STATUS_BAR_HEIGHT))
//去掉导航栏高度
#define DB_VIEW_HEIGHT_NO_NAV ((SCREEN_HEIGHT) - (DB_NAVIGATION_BAR_HEIGHT))
//去掉x的下部高度
#define DB_VIEW_HEIGHT_NO_BOTTOM ((SCREEN_HEIGHT) - (DB_HOME_INDICATOR_HEIGHT))
//去掉tabbar的高度
#define DB_VIEW_HEIGHT_NO_TAB ((SCREEN_HEIGHT) - (DB_NAVIGATION_BAR_HEIGHT) - (DB_TAB_BAR_HEIGHT))
//去掉导航栏和tabbar的高度
#define DB_VIEW_HEIGHT_NO_NAV_NO_TAB ((SCREEN_HEIGHT) - (DB_NAVIGATION_BAR_HEIGHT) - (DB_TAB_BAR_HEIGHT))
//去掉导航栏和x的下部高度
#define DB_VIEW_HEIGHT_NO_NAV_NO_BOTTOM ((SCREEN_HEIGHT) - (DB_NAVIGATION_BAR_HEIGHT) - (DB_HOME_INDICATOR_HEIGHT))




#endif /* DBBrowserMacro_h */
