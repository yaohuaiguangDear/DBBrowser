//
//  DBBaseTabBarViewController.m
//  DBBrowser
//
//  Created by yao on 2019/5/15.
//  Copyright © 2019 yao. All rights reserved.
//

#import "DBBaseTabBarViewController.h"
#import "DBNavigationController.h"
#import "DBWebViewController.h"
#import "DBSearchViewController.h"
@interface DBBaseTabBarViewController ()

@end

@implementation DBBaseTabBarViewController

- (void)changeLineOfTabbarColor {
    CGRect rect = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 0.5);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO, 0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setShadowImage:image];
    [self.tabBar setBackgroundImage:[UIImage new]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeLineOfTabbarColor];
    
    DBWebViewController *root = [[DBWebViewController alloc] init];
    root.url = @"https://www.baidu.com";
    [root loadWebView];
    DBNavigationController *foundPageNav = [[DBNavigationController alloc] initWithRootViewController:root];
    foundPageNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:[[UIImage imageNamed:@"tab_found_default"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_found_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    DBSearchViewController *homePage = [[DBSearchViewController alloc] init];
    DBNavigationController *homePageNav = [[DBNavigationController alloc] initWithRootViewController:homePage];
    homePageNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"下载" image:[[UIImage imageNamed:@"tab_chat_default"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_chat_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
   
    
    DBBaseViewController *center = [[DBBaseViewController alloc] init];
    
    DBNavigationController *centerNav = [[DBNavigationController alloc] initWithRootViewController:center];
    centerNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"关系" image:[[UIImage imageNamed:@"tab_contact_default"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_contact_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    // 设置 tabbarItem 选中状态下的文字颜色(不被系统默认渲染,显示文字自定义颜色)
    
    
    
    
    //    UIViewController *persional = [[UIViewController alloc] init];
    //    UINavigationController *persionalNav = [[UINavigationController alloc] initWithRootViewController:persional];
    //    persionalNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"个人中心" image:[[UIImage imageNamed:@"tab_center_default"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tab_center_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //    persionalNav.navigationBar.translucent = NO;
    //设置不被选中时的字体颜色及大小
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    attributes[NSForegroundColorAttributeName] = QP_Color_Text_Session_RightAudio;
    //    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [[UITabBarItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
    //设置被选中时的字体颜色及大小
    NSMutableDictionary *selectAttri = [NSMutableDictionary dictionary];
//    selectAttri[NSForegroundColorAttributeName] = QP_Color_Text_D43E72;
    [[UITabBarItem appearance] setTitleTextAttributes:selectAttri forState:UIControlStateSelected];
    
    
    //设置tabbar文字近距离底部的位置
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -4)];
//    [[UITabBar appearance] setBarTintColor:QP_Color_Text_Nav_title];
    [UITabBar appearance].translucent = NO;
    
    self.viewControllers = @[foundPageNav,homePageNav, centerNav];
//    self.tabBar.tintColor = QP_Color_Text_CD1818;
    
    self.tabBar.translucent = NO;
    // Do any additional setup after loading the view.
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    if ([item.title isEqualToString:@"个人中心"]) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
