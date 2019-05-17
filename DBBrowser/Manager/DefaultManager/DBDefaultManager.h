//
//  DBDefaultManager.h
//  DBBrowser
//  本地化数据使用的类相当于封装NSUserDefault
//  Created by yao on 2019/5/16.
//  Copyright © 2019 yao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBDefaultManager : NSObject
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
+ (instancetype)shareManager;


@end

NS_ASSUME_NONNULL_END
