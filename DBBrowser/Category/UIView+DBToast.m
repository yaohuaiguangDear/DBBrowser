//
//  UIView+DBToast.m
//  DBBrowser
//
//  Created by yao on 2019/5/15.
//  Copyright © 2019 yao. All rights reserved.
//

#import "UIView+DBToast.h"
#import <objc/runtime.h>
#import "DBLoadingView.h"
@implementation UIView (DBToast)
//定义常量 必须是C语言字符串
static char *DBToastHubKey = "DBToastHubKey";

- (MBProgressHUD *)hud{
    return objc_getAssociatedObject(self, DBToastHubKey);
}
- (void)setHud:(MBProgressHUD *)hud{
    /*
     objc_AssociationPolicy参数使用的策略：
     OBJC_ASSOCIATION_ASSIGN;            //assign策略
     OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
     OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain策略
     
     OBJC_ASSOCIATION_RETAIN;
     OBJC_ASSOCIATION_COPY;
     */
    /*
     关联方法：
     objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
     
     参数：
     * id object 给哪个对象的属性赋值
     const void *key 属性对应的key
     id value  设置属性值为value
     objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
     */
    
    objc_setAssociatedObject(self, DBToastHubKey, hud, OBJC_ASSOCIATION_RETAIN);
}
- (void)dbMakeToast:(NSString *)message{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    //修改浮框的背景色
    hud.bezelView.backgroundColor = [UIColor grayColor];
    //修改浮框上的文字距离边框的距离
    hud.margin = 8;
    //修改文字字体
    hud.label.font = [UIFont systemFontOfSize:14];
    //修改文字颜色
    hud.contentColor = [UIColor whiteColor];
    //    hud.ba
    //    hud.backgroundColor = [UIColor redColor];
    [hud hideAnimated:YES afterDelay:2.f];
}
- (void)dbMakeToast:(NSString *)message afterDelay:(NSTimeInterval)delay{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    //修改浮框的背景色
    hud.bezelView.backgroundColor = [UIColor grayColor];
    //修改浮框上的文字距离边框的距离
    hud.margin = 8;
    //修改文字字体
    hud.label.font = [UIFont systemFontOfSize:14];
    //修改文字颜色
    hud.contentColor = [UIColor whiteColor];
    //    hud.ba
    //    hud.backgroundColor = [UIColor redColor];
    [hud hideAnimated:YES afterDelay:delay];
}
- (void)dbShowLoading{
    /*
     MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
     [self setHud:hud];
     // Set the custom view mode to show any view.
     hud.mode = MBProgressHUDModeCustomView;
     // Set an image view with a checkmark.
     UIImage *image = [[UIImage imageNamed:@"icon_loading_small"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
     UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
     [imageView startRotating];
     hud.customView = imageView;
     hud.margin = 8;
     hud.bezelView.backgroundColor = QP_Color_Background_Black_special;
     // Looks a bit nicer if we make it square.
     hud.square = YES;
     // Optional label text.
     //    hud.label.text = NSLocalizedString(@"加载中", @"HUD done title");
     
     //    [hud hideAnimated:YES afterDelay:10.f];
     */
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    [self setHud:hud];
    
    NSMutableArray *imagesArr = [NSMutableArray array];
    for (int i = 1; i <=32; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Settings.bundle/loading_%d", i]];
        [imagesArr addObject:image];
    }
    
    DBLoadingView *imageView = [[DBLoadingView alloc] init];
    imageView.animationImages = imagesArr;
    imageView.animationDuration = 1.2;     //执行一次完整动画所需的时长
    //    imageView.animationRepeatCount = MAX_INPUT;  //动画重复次数
    [imageView startAnimating];
    //    [imageView startRotating];
    
    hud.yOffset = -45;
    
    hud.customView = imageView;
    //下面两句实现背景透明
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor clearColor];
    //13,是否强制背景框宽高相等
    hud.square = YES;
    
    hud.mode = MBProgressHUDModeCustomView;
    
    
    
}
//- (CGSize)intrinsicContentSize{
//    //改变动画尺寸大小
//    return CGSizeMake(60, 60);
//}
- (void)dbHideLoading{
    MBProgressHUD *hud = [self hud];
    //    [hud hideAnimated:YES afterDelay:1];
    [hud hideAnimated:YES];
}
@end
