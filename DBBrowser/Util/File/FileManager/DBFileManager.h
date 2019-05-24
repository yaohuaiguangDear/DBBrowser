//
//  DBFileManager.h
//  DBBrowser
//
//  Created by yao on 2019/5/23.
//  Copyright © 2019 yao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlistFileManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface DBFileManager : NSObject
/**
 *  获取单例实例
 *
 *  @return 单例实例
 */
+ (instancetype) sharedManager;
/*
 
 plist文件管理
 
 */
/**
 根据文件名,创建plist的文件
 
 @param fileName 文件名
 @return plist文件的本地路径
 */
- (NSString *)createPlistFileWithFileName:(NSString *)fileName data:(id)data;

/**
 getFilePathWithFileName: 通过plist文件名获取文件的本地路径
 
 @param fileName plist文件名字
 @return plist文件本地路径
 */
- (NSString *)getFilePathWithFileName:(NSString *)fileName;

/**
 getStringWithFileName 通过plist文件名获取存储在文件中的string内容, 以string形式返回
 
 @param fileName plist文件名字
 @return 文件中存储的字符串
 */
- (NSString *)getStringWithFileName:(NSString *)fileName;
/**
 getArrayWithFileName 通过plist文件名获取存储在文件中的数组内容, 以数组形式返回
 
 @param fileName plist文件名字
 @return 文件中存储的字数组
 */
- (NSArray *)getArrayWithFileName:(NSString *)fileName;
/**
 getDictionaryWithFileName 通过plist文件名获取存储在文件中的字典内容, 以字典形式返回
 
 @param fileName plist文件名字
 @return 文件中存储的字典
 */
- (NSDictionary *)getDictionaryWithFileName:(NSString *)fileName;

/**
 updatePlistFileWithFileName:data: 根据plist名称覆盖更新内容, 只保留最新的,覆盖旧的内容
 
 @param fileName plist文件名字
 @param data 需要更新的新数据
 @return plist文件本地路径
 */
- (NSString *)updatePlistFileWithFileName:(NSString *)fileName data:(id)data;
/**
 addDataToPlistFileWithFileName:data: 通过plist文件名对文件进行追加数据,如果更新数据是数组,则不对数组进行去重操作, 如果是字典,则对重复数据进行更新,如果是字符串,则对字符串进行追加
 
 @param fileName plist文件名字
 @param data 需要添加的新数据
 @return plist文件本地路径
 */
- (NSString *)addDataToPlistFileWithFileName:(NSString *)fileName data:(id)data;
/**
 addDataToPlistFileWithFileName:dataArray: 根据plist文件名对文件进行添加数据,且是去重操作,如果添加的内容相同,则会保留最新数据,且位置为最新
 
 @param fileName plist文件名字
 @param array 需要添加的新数据
 @return plist文件本地路径
 */
- (NSString *)addDataToPlistFileWithFileName:(NSString *)fileName dataArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
