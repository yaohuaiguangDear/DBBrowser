//
//  DBBaseProcessPool.m
//  DBBrowser
//
//  Created by yao on 2019/5/15.
//  Copyright © 2019 yao. All rights reserved.
//

#import "DBBaseProcessPool.h"

@implementation DBBaseProcessPool
static WKProcessPool * _instance = nil;
static dispatch_once_t onceToken ;
+(WKProcessPool *) shareInstance
{
    
    dispatch_once(&onceToken, ^{
        _instance = [[WKProcessPool alloc] init] ;
    }) ;
    return _instance ;
}
+ (void)setNil{
    _instance = nil;
    onceToken = 0;
}
@end
