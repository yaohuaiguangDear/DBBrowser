//
//  DBRootViewControllerManager.m
//  DBBrowser
//
//  Created by yao on 2019/5/16.
//  Copyright © 2019 yao. All rights reserved.
//

#import "DBRootViewControllerManager.h"
#import "GuidePagesViewController.h"
#import "DBWebViewController.h"
#import "DBBaseTabBarViewController.h"

#define DB_VERSION_INFO_CURRENT @"db_version_info_current"
#define DB_VERSION_KEY @"CFBundleShortVersionString"

@implementation DBRootViewControllerManager
+ (instancetype)shareManager{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
/**
 启动app后设置APP的根目录
 */
- (void)setRootViewController{
    if([self isShowGuidePage]){
        GuidePagesViewController *guide = [[GuidePagesViewController alloc] init];
        [[UIApplication sharedApplication].delegate window].rootViewController = guide;
        return;
    }
    
    
    if ([DBUserInfoManager shareCenter].isLogined) {
        DBBaseTabBarViewController *tabbar = [[DBBaseTabBarViewController alloc] init];
        [[UIApplication sharedApplication].delegate window].rootViewController = tabbar;
    } else {
        DBBaseTabBarViewController *tabbar = [[DBBaseTabBarViewController alloc] init];
        [[UIApplication sharedApplication].delegate window].rootViewController = tabbar;
    }
}
- (BOOL)isShowGuidePage
{
    // 读取版本信息
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *localVersion = [user objectForKey:DB_VERSION_INFO_CURRENT];
    NSString *currentVersion =[[NSBundle mainBundle].infoDictionary objectForKey:DB_VERSION_KEY];
    NSLog(@"L ===%@", localVersion);
    NSLog(@"C ===%@", currentVersion);
    if (localVersion == nil || ![currentVersion isEqualToString:localVersion]) {
        [self saveCurrentVersion];
        return YES;
    }else
    {
        return NO;
    }
}

// 保存版本信息
- (void)saveCurrentVersion
{
    NSString *version =[[NSBundle mainBundle].infoDictionary objectForKey:DB_VERSION_KEY];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:version forKey:DB_VERSION_INFO_CURRENT];
    [user synchronize];
}

@end
