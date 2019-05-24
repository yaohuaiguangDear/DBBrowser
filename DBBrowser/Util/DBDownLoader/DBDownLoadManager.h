//
//  DBDownLoadManager.h
//  DBBrowser
//
//  Created by yao on 2019/5/15.
//  Copyright © 2019 yao. All rights reserved.
//

#import "DBBaseObject.h"
#import <AFNetworking/AFNetworking.h>
NS_ASSUME_NONNULL_BEGIN

@interface DBDownLoadManager : DBBaseObject
/**
 download file use block policy
 
 @param url file url
 */
- (void)downLoadWithURL:(NSString *)url;
/**
 download file use delegate policy
 
 @param url file url
 */
- (void)downLoadUseDelegateWithURL:(NSString *)url;

/**
 根据url进行下载,且实时监控下载进度

 @param url 下载链接
 @param downloadProgressBlock 下载进度的block
 */
- (void)downloadTaskWithURL:(NSString *)url
                       progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgressBlock;
/**
 根据request进行下载,且实时监控下载进度

 @param request 下载的请求
 @param downloadProgressBlock 下载进度的block
 */
- (void)downloadTaskWithRequest:(NSURLRequest *)request
                       progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgressBlock;

/**
 根据request进行下载,且实时监控下载进度

 @param request 下载的请求
 @param downloadProgressBlock 下载进度的block
 @param destination 下载目的地值的block 在这里需要返回下载的文件存储到本地的地址
 @param completionHandler 下载完成的回调
 */
- (void)downloadTaskWithRequest:(NSURLRequest *)request
                                             progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgressBlock
                                          destination:(nullable NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
                                    completionHandler:(nullable void (^)(NSURLResponse *response, NSURL * _Nullable filePath, NSError * _Nullable error))completionHandler;
@end

NS_ASSUME_NONNULL_END
