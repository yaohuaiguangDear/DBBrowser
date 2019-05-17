//
//  UIViewController+DBCategory.m
//  DBBrowser
//
//  Created by yao on 2019/5/16.
//  Copyright © 2019 yao. All rights reserved.
//

#import "UIViewController+DBCategory.h"

@implementation UIViewController (DBCategory)

- (UIStatusBarStyle)preferredStatusBarStyle {
    //改变电池栏颜色为白色
    return UIStatusBarStyleLightContent;
}
////隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    
    return NO;
}

@end
