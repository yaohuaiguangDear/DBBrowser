//
//  DBDownLoadManager.m
//  DBBrowser
//
//  Created by yao on 2019/5/15.
//  Copyright © 2019 yao. All rights reserved.
//

#import "DBDownLoadManager.h"
#import <UIKit/UIKit.h>
@interface DBDownLoadManager ()<NSURLSessionDownloadDelegate>


@end

@implementation DBDownLoadManager
- (void)downLoadWithURL:(NSString *)url{
   /* NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *sesseion = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *downLoadTask = [sesseion downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", location);
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:filePath] error:nil];
        NSLog(@"%@", filePath);
    }];
    
    [downLoadTask resume];
    
    */
   
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    
    //    NSString *voiceURL = [self _urlByAppendingStringWithHostName:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //文件的存储路径
        NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSString * fileName = [url lastPathComponent];
        NSString * filePath = [NSString stringWithFormat:@"Audios/luyin_%@", fileName];
        downloadURL = [downloadURL URLByAppendingPathComponent:filePath];
        return downloadURL;
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
    }];
    /*
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath,NSURLResponse *response) {
        //文件的存储路径
        NSURL *downloadURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        NSString * fileName = [url lastPathComponent];
        NSString * filePath = [NSString stringWithFormat:@"Audios/luyin_%@", fileName];
        downloadURL = [downloadURL URLByAppendingPathComponent:filePath];
        return downloadURL;
    } completionHandler:^(NSURLResponse *response,NSURL *filePath, NSError *error) {
        //此处已经在主线程了
        if (!error) {
            NSLog(@"文件下载成功了 地址:%@", filePath);
           
        } else {
            
        }
    }];
     */
    [downloadTask resume];
    
    
}
- (void)downLoadUseDelegateWithURL:(NSString *)url{
    /*
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
    [task resume];
     */
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
    
    //    NSString *voiceURL = [self _urlByAppendingStringWithHostName:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
        [[NSFileManager defaultManager] moveItemAtURL:targetPath toURL:[NSURL fileURLWithPath:filePath] error:nil];
        NSLog(@"%@", filePath);
        
//        [self saveVideo:[NSURL fileURLWithPath:filePath]];
        //文件的存储路径
      
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
    }];
    [downloadTask resume];
    
}
#pragma mark -- NSURLSessionDownloadDelegate

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    NSLog(@"%lf", 1.0 * totalBytesWritten / totalBytesExpectedToWrite);
}

//重新恢复下载的代理
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}
//写入数据到本地的时候调用的方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:filePath] error:nil];
    NSLog(@"%@", filePath);
    
    [self saveVideo:[NSURL fileURLWithPath:filePath]];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"下载成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    
}
//请求完成错误调用的代理方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"下载失败" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

- (void)saveVideo:(NSURL *)videoPath{
    
    if (videoPath) {
        
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum([videoPath path])) {
            //保存相册核心代码
            UISaveVideoAtPathToSavedPhotosAlbum([videoPath path], self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
        
    }
    
}
//保存视频完成之后的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        NSLog(@"保存视频失败%@", error.localizedDescription);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存视频失败" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存视频成功" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        NSLog(@"保存视频成功");
    }
    
}
@end
