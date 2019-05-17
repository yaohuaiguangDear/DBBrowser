//
//  DBDefaultManager.m
//  DBBrowser
//
//  Created by yao on 2019/5/16.
//  Copyright © 2019 yao. All rights reserved.
//

#import "DBDefaultManager.h"

@implementation DBDefaultManager
+ (instancetype)shareManager{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
