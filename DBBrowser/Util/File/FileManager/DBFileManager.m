//
//  DBFileManager.m
//  DBBrowser
//
//  Created by yao on 2019/5/23.
//  Copyright © 2019 yao. All rights reserved.
//

#import "DBFileManager.h"

@implementation DBFileManager
/**
 *  获取单例实例
 *
 *  @return 单例实例
 */
+ (instancetype) sharedManager{
    
    static DBFileManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[DBFileManager alloc]init];
        }
    });
    
    return instance;
}
- (NSString *)createPlistFileWithFileName:(NSString *)fileName data:(id)data{
    return [[PlistFileManager sharedManager] createPlistFileWithFileName:fileName data:data];
}
- (NSString *)getFilePathWithFileName:(NSString *)fileName{
    return [[PlistFileManager sharedManager] getFilePathWithFileName:fileName];
}

- (NSString *)getStringWithFileName:(NSString *)fileName{
    return [[PlistFileManager sharedManager] getStringWithFileName:fileName];
}
- (NSArray *)getArrayWithFileName:(NSString *)fileName{
    return [[PlistFileManager sharedManager] getArrayWithFileName:fileName];
}
- (NSDictionary *)getDictionaryWithFileName:(NSString *)fileName{
    return [[PlistFileManager sharedManager] getDictionaryWithFileName:fileName];
}
- (NSString *)updatePlistFileWithFileName:(NSString *)fileName data:(id)data{
    return [[PlistFileManager sharedManager] updatePlistFileWithFileName:fileName data:data];
}
- (NSString *)addDataToPlistFileWithFileName:(NSString *)fileName data:(id)data{
    return [[PlistFileManager sharedManager] addDataToPlistFileWithFileName:fileName data:data];
}
- (NSString *)addDataToPlistFileWithFileName:(NSString *)fileName dataArray:(NSArray *)array{
    return [[PlistFileManager sharedManager] addDataToPlistFileWithFileName:fileName dataArray:array];
}
@end
