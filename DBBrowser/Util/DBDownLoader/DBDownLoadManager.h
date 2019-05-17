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
@end

NS_ASSUME_NONNULL_END
