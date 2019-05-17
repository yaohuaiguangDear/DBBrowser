//
//  DBUserInfoManager.h
//  DBBrowser
//  用户相关信息 包括账号,手机号,用户名等
//  Created by yao on 2019/5/16.
//  Copyright © 2019 yao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define USERDEFAULTS_UserName @"userName"
#define USERDEFAULTS_IsLogin @"DB_isLogined"

@interface DBUserInfoManager : NSObject
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)shareCenter;

//通过 QP_User_detail进行更新数据
- (void)updateWithDict:(NSDictionary *)dic;

/**
 *  判断用户是否登录
 */
@property (nonatomic, assign) BOOL isLogined;

/**
 用户昵称
 */
@property (strong, nonatomic) NSString *userName;

@end

NS_ASSUME_NONNULL_END
