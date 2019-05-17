//
//  DBBaseProcessPool.h
//  DBBrowser
//
//  Created by yao on 2019/5/15.
//  Copyright © 2019 yao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DBBaseProcessPool : NSObject
+(WKProcessPool *)shareInstance;
+(void)setNil;
@end

NS_ASSUME_NONNULL_END
