//
//  UIView+DBToast.h
//  DBBrowser
//
//  Created by yao on 2019/5/15.
//  Copyright © 2019 yao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIView (DBToast)
@property (nonatomic, strong) MBProgressHUD *hud;
- (void)dbMakeToast:(NSString *)message;
- (void)dbMakeToast:(NSString *)message afterDelay:(NSTimeInterval)delay;
- (void)dbShowLoading;
- (void)dbHideLoading;
@end

NS_ASSUME_NONNULL_END
