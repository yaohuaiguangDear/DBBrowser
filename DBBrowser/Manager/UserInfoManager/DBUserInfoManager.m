//
//  DBUserInfoManager.m
//  DBBrowser
//
//  Created by yao on 2019/5/16.
//  Copyright © 2019 yao. All rights reserved.
//

#import "DBUserInfoManager.h"

@implementation DBUserInfoManager
+ (instancetype)shareCenter{
    static id sharedCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCenter = [[self alloc] init];
    });
    return sharedCenter;
}

//通过 QP_User_detail进行更新数据
- (void)updateWithDict:(NSDictionary *)dic{
    
}

- (void)setIsLogined:(BOOL)isLogined{
    [[NSUserDefaults standardUserDefaults] setBool:isLogined forKey:USERDEFAULTS_IsLogin];
    //立即保存
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isLogined{
    return [[NSUserDefaults standardUserDefaults] boolForKey:USERDEFAULTS_IsLogin];
}

- (void)setUserName:(NSString *)userName{
    [[NSUserDefaults standardUserDefaults] setValue:userName forKey:USERDEFAULTS_UserName];
    //立即保存
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)userName{
    return [[NSUserDefaults standardUserDefaults] valueForKey:USERDEFAULTS_UserName];
}

@end
