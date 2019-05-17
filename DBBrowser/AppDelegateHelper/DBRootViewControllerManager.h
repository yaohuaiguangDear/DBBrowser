//
//  DBRootViewControllerManager.h
//  DBBrowser
//
//  Created by yao on 2019/5/16.
//  Copyright © 2019 yao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBRootViewControllerManager : NSObject
+ (instancetype)shareManager;
/**
 启动app后设置APP的根目录
 */
- (void)setRootViewController;
@end

NS_ASSUME_NONNULL_END
