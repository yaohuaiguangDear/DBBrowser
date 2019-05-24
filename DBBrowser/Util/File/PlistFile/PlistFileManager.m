//
//  PlistFileManager.m
//  DBBrowser
//
//  Created by yao on 2019/5/23.
//  Copyright © 2019 yao. All rights reserved.
//

#import "PlistFileManager.h"

@implementation PlistFileManager
/**
 *  获取单例实例
 *
 *  @return 单例实例
 */
+ (instancetype) sharedManager{
    
    static PlistFileManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[PlistFileManager alloc]init];
        }
    });
    
    return instance;
}

- (NSString *)createPlistFileWithFileName:(NSString *)fileName  data:(id)data{
    //1.创建plist文件的路径(plist文件要存储的本地路径)
//    NSString *filePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/myPlist.plist"];
    NSString *filePath = [self getFilePathWithFileName:fileName];
    [data writeToFile:filePath atomically:YES]; //覆盖修改前的数据
    return filePath;
}
- (NSString *)getFilePathWithFileName:(NSString *)fileName{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]];
}
- (NSString *)getStringWithFileName:(NSString *)fileName{
    NSString *str = [NSString stringWithContentsOfFile:[self getFilePathWithFileName:fileName] encoding:NSUTF8StringEncoding error:nil];
    return str;
}
- (NSMutableString *)getMutableStringWithFileName:(NSString *)fileName{
    NSMutableString *str = [NSMutableString stringWithContentsOfFile:[self getFilePathWithFileName:fileName] encoding:NSUTF8StringEncoding error:nil];
    return str;
}
- (NSArray *)getArrayWithFileName:(NSString *)fileName{
    NSArray *arr = [NSArray arrayWithContentsOfFile:[self getFilePathWithFileName:fileName]];
    return arr;
}
- (NSMutableArray *)getMutableArrayWithFileName:(NSString *)fileName{
    NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:[self getFilePathWithFileName:fileName]];
    return arr;
}
- (NSDictionary *)getDictionaryWithFileName:(NSString *)fileName{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[self getFilePathWithFileName:fileName]];
    return dic;
}
- (NSMutableDictionary *)getMutableDictionaryWithFileName:(NSString *)fileName{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:[self getFilePathWithFileName:fileName]];
    return dic;
}
- (NSString *)updatePlistFileWithFileName:(NSString *)fileName data:(id)data{
    NSString *filePath = [self getFilePathWithFileName:fileName];
    [data writeToFile:filePath atomically:YES]; //覆盖修改前的数据
    return filePath;
}
- (NSString *)addDataToPlistFileWithFileName:(NSString *)fileName data:(id)data{
    NSString *filePath = [self getFilePathWithFileName:fileName];
    Class cls = [data class];
    id localContent = nil;
    if ([cls isSubclassOfClass:[NSString class]]) {
        localContent = [self getStringWithFileName:fileName];
        localContent = [(NSMutableString *)localContent stringByAppendingString:data];
    }
    else if ([cls isSubclassOfClass:[NSArray class]]) {
        localContent = [self getMutableArrayWithFileName:fileName];
        [(NSMutableArray *)localContent addObjectsFromArray:data];
    }
    else if ([cls isSubclassOfClass:[NSDictionary class]]) {
        localContent = [self getMutableDictionaryWithFileName:fileName];
        [(NSMutableDictionary *)localContent setValuesForKeysWithDictionary:data];
    }
    else {
        NSAssert(NO, @"该方法暂不支持此类型更新");
    }
    
    [localContent writeToFile:filePath atomically:YES]; //覆盖修改前的数据
    return filePath;
}
- (NSString *)addDataToPlistFileWithFileName:(NSString *)fileName dataArray:(NSArray *)array{
    NSString *filePath = [self getFilePathWithFileName:fileName];
    NSMutableArray * localContent =  [self getMutableArrayWithFileName:fileName];
    NSMutableArray *newArray = [self mergeArray:localContent wuthArray:array];
    [newArray writeToFile:filePath atomically:YES];
    return filePath;
}

- (NSMutableArray *)mergeArray:(NSArray *)array wuthArray:(NSArray *)dataArray{
    NSMutableArray *newArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BOOL isEqual = NO;
        for (id object in dataArray) {
            if ([obj isEqualToString:object]) {
                isEqual = YES;
            }
        }
        if (!isEqual) {
            [newArray addObject:obj];
        }
    }];
    [newArray addObjectsFromArray:dataArray];
    return newArray;
}
@end
