//
//  DBBaseWebViewController.h
//  DBBrowser
//
//  Created by yao on 2019/5/15.
//  Copyright © 2019 yao. All rights reserved.
//

#import "DBBaseViewController.h"
#import "DBBaseProcessPool.h"
NS_ASSUME_NONNULL_BEGIN
//和h5交互的名字
#define ScriptMessageHandlerName   @"DBBrowserApp"

@interface DBBaseWebViewController : DBBaseViewController<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

/**
 
 方法
 
 */
/**
 初始化方法

 @param url 网页的地址
 @return DBBaseWebViewController对象
 */
- (instancetype)initWithURL:(NSString *)url;


- (void)loadWebView;


/**
 
 属性
 
 */
/**
 wkwebview, 用来显示网页
 */
@property (nonatomic, strong) WKWebView * webView;
/**
 进度条,标示网页加载进度,可以定义进度条的宽度,颜色
 */
@property (nonatomic, strong) UIProgressView * progressView;

/**
 网页加载的路径
 */
@property (nonatomic, copy) NSString *url;
/**
 webview 的配置
 */
@property (nonatomic, strong) WKWebViewConfiguration *configuration;

@property (nonatomic, strong) UIButton *backItem;
@end

@interface WeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, weak) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;



@end

NS_ASSUME_NONNULL_END
