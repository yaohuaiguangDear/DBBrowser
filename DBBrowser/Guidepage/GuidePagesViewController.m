//
//  GuidePagesViewController.m
//  MDSDoctorApp
//
//  Created by yao on 16/7/5.
//  Copyright © 2016年 medishare.cn. All rights reserved.
//

#import "GuidePagesViewController.h"

/*
 * 定义引导页画面的个数
 */
#define GuidePages 4


@interface GuidePagesViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIPageControl *rootPC;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *imageArray; //存放引导页图片
@end

@implementation GuidePagesViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.scrollView];
    [self setImage];
}

#pragma mark --- Action
- (void)setImage{
    //    [self.view addSubview:self.rootPC];
    UIButton *bbt = [UIButton buttonWithType:UIButtonTypeSystem];
    for (int i= 0; i < GuidePages; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * i, 0, self.view.frame.size.width, self.view.frame.size.height)];
        imageView.tag = 100 + i;
        if (i == GuidePages - 1) {
            imageView.userInteractionEnabled = YES;
            [bbt addTarget:self action:@selector(goToLogin) forControlEvents:UIControlEventTouchUpInside];
            bbt.tag = 200;
            [imageView addSubview:bbt];
        }
        [self.scrollView addSubview:imageView];
        [self.dataArray addObject:imageView];
    }
    [self setImageForPage];
    if (IS_IPHONE_4_OR_LESS) {
        bbt.frame = CGRectMake(50, 407, SCREEN_WIDTH - 100, 40);
        self.rootPC.frame = CGRectMake((self.view.frame.size.width-100) / 2, self.view.frame.size.height-30, 100, 20);
    }else if (IS_IPHONE_5) {
        bbt.frame = CGRectMake(40, 474, SCREEN_WIDTH - 80, 40);
        self.rootPC.frame = CGRectMake((self.view.frame.size.width-100) / 2, self.view.frame.size.height-50, 100, 20);
    }else if(IS_IPHONE_6){
        bbt.frame = CGRectMake(60, 558, SCREEN_WIDTH - 120, 40);
        self.rootPC.frame = CGRectMake((self.view.frame.size.width-100) / 2, self.view.frame.size.height-55, 100, 20);
    }else if(IS_IPHONE_6P){
        bbt.frame = CGRectMake(60, 630, SCREEN_WIDTH - 120, 48);
        self.rootPC.frame = CGRectMake((self.view.frame.size.width-100) / 2, self.view.frame.size.height-55, 100, 20);
    }else if(IS_IPHONE_X){
        bbt.frame = CGRectMake(60, 638, SCREEN_WIDTH - 120, 40);
        self.rootPC.frame = CGRectMake((self.view.frame.size.width-100) / 2, self.view.frame.size.height-55, 100, 20);
    }
    else if(IS_IPHONE_XR){
        bbt.frame = CGRectMake(60, 780, SCREEN_WIDTH - 120, 40);
        self.rootPC.frame = CGRectMake((self.view.frame.size.width-100) / 2, self.view.frame.size.height-55, 100, 20);
    }
    else if(IS_IPHONE_XMAX){
        bbt.frame = CGRectMake(60, 750, SCREEN_WIDTH - 120, 50);
        self.rootPC.frame = CGRectMake((self.view.frame.size.width-100) / 2, self.view.frame.size.height-55, 100, 20);
    }
    else if (IS_IPAD) {
        bbt.frame = CGRectMake(50, 407, SCREEN_WIDTH - 100, 40);
        self.rootPC.frame = CGRectMake((self.view.frame.size.width-100) / 2, self.view.frame.size.height-30, 100, 20);
    }
    else {
        bbt.frame = CGRectMake(50, 407, SCREEN_WIDTH - 100, 40);
        self.rootPC.frame = CGRectMake((self.view.frame.size.width-100) / 2, self.view.frame.size.height-30, 100, 20);
    }
    
//        bbt.backgroundColor = [UIColor colorWithRed:55/255.0 green:55/255.0 blue:55/255.0 alpha:0.4];
    
}
//设置图片
- (void)setImageForPage{
    for (int i = 0; i < self.dataArray.count; i++) {
        UIImageView *yin = self.dataArray[i];
        yin.image = [UIImage imageNamed:self.imageArray[i]];
    }
}

//  减速结束的时候 修改圆点
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.rootPC.currentPage = self.scrollView.contentOffset.x/self.view.frame.size.width;
    if (self.rootPC.currentPage == 4) {
        self.rootPC.hidden = YES;
    } else {
        self.rootPC.hidden = NO;
        
    }
}

- (void)changePage:(UIPageControl *)pageControl
{
    // 偏移量
    [self.scrollView setContentOffset:CGPointMake(pageControl.currentPage * 100, 0) animated:YES];
    
}
/*
 * 跳转主页
 */
- (void)goToLogin{
    
    [[DBRootViewControllerManager shareManager] setRootViewController];
}

#pragma mark --- 懒加载
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        self.dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
        if (IS_IPHONE_4_OR_LESS) {
            for (int i = 0; i < GuidePages; i++) {
                [_imageArray addObject:[NSString stringWithFormat:@"guide_640_960_0%d", i + 1]];
            }
        }
        else if (IS_IPHONE_5){
            for (int i = 0; i < GuidePages; i++) {
                [_imageArray addObject:[NSString stringWithFormat:@"guide_640_1136_0%d", i + 1]];
            }
        }
        else if (IS_IPHONE_6){
            for (int i = 0; i < GuidePages; i++) {
                [_imageArray addObject:[NSString stringWithFormat:@"guide_750_1334_0%d", i + 1]];
            }
        }
        else if (IS_IPHONE_6P){
            for (int i = 0; i < GuidePages; i++) {
                [_imageArray addObject:[NSString stringWithFormat:@"guide_1242_2208_0%d", i + 1]];
            }
        }
        else if (IS_IPHONE_X){
            for (int i = 0; i < GuidePages; i++) {
                [_imageArray addObject:[NSString stringWithFormat:@"guide_1125_2436_0%d", i + 1]];
            }
        }
        else if (IS_IPHONE_XR){
            for (int i = 0; i < GuidePages; i++) {
                [_imageArray addObject:[NSString stringWithFormat:@"guide_828_1792_0%d", i + 1]];
            }
        }
        else if (IS_IPHONE_XMAX){
            for (int i = 0; i < GuidePages; i++) {
                [_imageArray addObject:[NSString stringWithFormat:@"guide_1242_2688_0%d", i + 1]];
            }
        }
        else if (IS_IPAD){
            for (int i = 0; i < GuidePages; i++) {
                [_imageArray addObject:[NSString stringWithFormat:@"guide_640_960_0%d", i + 1]];
            }
        }
        else {
            for (int i = 0; i < GuidePages; i++) {
                [_imageArray addObject:[NSString stringWithFormat:@"guide_640_960_0%d", i + 1]];
            }
        }
        
    }
    return _imageArray;
}
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH * GuidePages, self.view.frame.size.height);
        _scrollView.pagingEnabled=YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.delegate=self;
    }
    return _scrollView;
}
- (UIView *)contentView{
    if (!_contentView) {
        self.contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    }
    return _contentView;
}

- (UIPageControl *)rootPC{
    if (!_rootPC) {
        self.rootPC = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.frame.size.width-100) / 2, self.view.frame.size.height-60, 100, 20)];
        _rootPC.numberOfPages = GuidePages;
        _rootPC.currentPage = 0;         //  开机默认在第几个点
        _rootPC.currentPageIndicatorTintColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
        _rootPC.pageIndicatorTintColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    }
    return _rootPC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
