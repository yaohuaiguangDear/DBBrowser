//
//  DBLogManager.h
//  DBBrowser
//
//  Created by yao on 2019/5/22.
//  Copyright © 2019 yao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SSZipArchive/SSZipArchive.h>
NS_ASSUME_NONNULL_BEGIN

@interface DBLogManager : NSObject
/**
 *  获取单例实例
 *
 *  @return 单例实例
 */
+ (instancetype) sharedInstance;

#pragma mark -- Method

/**
 *  写入日志
 *
 *  @param module 模块名称
 *  @param logStr 日志信息,动态参数
 */
- (void)logInfo:(NSString*)module logStr:(NSString*)logStr, ...;
/**
 *  清空过期的日志
 */
- (void)clearExpiredLog;
/**
 *  检测日志是否需要上传
 */
- (void)checkLogNeedUpload;

@end

NS_ASSUME_NONNULL_END
