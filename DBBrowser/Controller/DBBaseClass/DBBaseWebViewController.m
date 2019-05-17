//
//  DBBaseWebViewController.m
//  DBBrowser
//
//  Created by yao on 2019/5/15.
//  Copyright © 2019 yao. All rights reserved.
//

#import "DBBaseWebViewController.h"

@interface DBBaseWebViewController ()

@end

@implementation DBBaseWebViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.url = @"";
        
    }
    return self;
}

- (instancetype)initWithURL:(NSString *)url{
    self = [super init];
    if (self) {
        
        self.url = url;
        
    }
    return self;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    //     添加进入条
    [self.view addSubview:self.progressView];
}
- (void)loadWebView{
    if (self.url) {
        NSURL *url = [NSURL URLWithString:self.url];
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
        [self.webView loadRequest:request];//加载
    }
}
- (WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, DB_STATUS_BAR_HEIGHT, SCREEN_WIDTH, DB_VIEW_HEIGHT_NO_STATUS) configuration:self.configuration];
        _webView.allowsBackForwardNavigationGestures = YES;
        //修改背景色生效
        [_webView setOpaque:NO];
        // 导航代理
        self.webView.navigationDelegate = self;
        // 与webview UI交互代理
        _webView.UIDelegate = self;
        
        // 添加KVO监听
        //    [self.webView addObserver:self
        //                   forKeyPath:@"loading"
        //                      options:NSKeyValueObservingOptionNew
        //                      context:nil];
        [_webView addObserver:self
                       forKeyPath:@"title"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
        [_webView addObserver:self
                       forKeyPath:@"estimatedProgress"
                          options:NSKeyValueObservingOptionNew
                          context:nil];
        //    [self.webView addObserver:self
        //                   forKeyPath:@"url"
        //                      options:NSKeyValueObservingOptionNew
        //                      context:nil];
        //    [self.webView addObserver:self
        //                   forKeyPath:@"URL"
        //                      options:NSKeyValueObservingOptionNew
        //                      context:nil];
        
    }
    return _webView;
}
- (WKWebViewConfiguration *)configuration{
    if (!_configuration) {
        _configuration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController* userContentController = WKUserContentController.new;
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
        NSString * JSESSIONID;
        NSMutableString *cookie = [NSMutableString string];
        for (NSHTTPCookie * cookie in cookies) {
            NSString *baseUrl = HOST;
            if ([baseUrl containsString:cookie.domain] && [cookie.name isEqualToString:@"SESSION"]) {
                JSESSIONID = cookie.value;
                break;
            }
        }
        if (JSESSIONID.length) {
            // 格式化Cookie
            [cookie appendFormat:@"document.cookie = 'SESSION=%@;';",JSESSIONID];
        }
        WKUserScript * cookieScript = [[WKUserScript alloc] initWithSource:cookie injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
        [userContentController addUserScript:cookieScript];
        
        // 设置偏好设置
        _configuration.preferences = [[WKPreferences alloc] init];
        // 默认为0
        _configuration.preferences.minimumFontSize = 10;
        // 默认认为YES
        _configuration.preferences.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示不能自动通过窗口打开
        _configuration.preferences.javaScriptCanOpenWindowsAutomatically = NO;
        
        // web内容处理池
        _configuration.processPool = [DBBaseProcessPool shareInstance];
        
        // 通过JS与webview内容交互
        _configuration.userContentController = userContentController;
        // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
        // 我们可以在WKScriptMessageHandler代理中接收到
        [_configuration.userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:ScriptMessageHandlerName];
    }
    return _configuration;
}
- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _progressView.tintColor = [UIColor blueColor];
        _progressView.trackTintColor = [UIColor grayColor];

    }
    return _progressView;
}

#pragma mark 移除观察者
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    
}
#pragma mark - WKScriptMessageHandler
//接收到js调用
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:ScriptMessageHandlerName]) {
        // 打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray,
        // NSDictionary, and NSNull类型
        NSLog(@"%@", message.body);
    }
    
}
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"loading"]) {
        NSLog(@"loading");
    } else if ([keyPath isEqualToString:@"title"]) {
        self.title = self.webView.title;
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        NSLog(@"progress: %f", self.webView.estimatedProgress);
        [self.progressView setAlpha:1.0f];
        self.progressView.progress = self.webView.estimatedProgress;
        if(self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.5f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO]; }];
        }
        
    }
    
    // 加载完成
    if (!self.webView.loading) {
        // 手动调用JS代码
        // 每次页面完成都弹出来，大家可以在测试时再打开
        
    }
}
- (void)setCookie:(WKWebView *)webView{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
    //    NSArray *cookies =[NSHTTPCookie cookiesWithResponseHeaderFields:[response allHeaderFields] forURL:response.URL];
    NSString * JSESSIONID;
    NSString *host = HOST;
    NSURL *hostURL = [NSURL URLWithString:host];
    NSString *domain = hostURL.host;
    NSMutableString *cookie = [NSMutableString string];
    for (NSHTTPCookie * cookie in cookies) {
        if ([cookie.domain isEqualToString:domain] && [cookie.name isEqualToString:@"SESSION"]) {
            JSESSIONID = cookie.value;
            break;
        }
    }
    if (JSESSIONID.length) {
        // 格式化Cookie
        [cookie appendFormat:@"document.cookie = 'SESSION=%@;';",JSESSIONID];
    }
    [webView evaluateJavaScript:cookie completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"response: %@ error: %@", response, error);
        
    }];
}


#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSURL *hosturl = navigationAction.request.URL;
    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
    NSLog(@"hosturl = %@ \n hostname = %@ \n ",hosturl, hostname);
    NSString *str = [hosturl absoluteString];
    if ([str containsString:@"action=download-manifest"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-services://?action=download-manifest&url=https://ios.cp55xz.com/ipa/app.plist"]];
    }
    if ([hosturl.absoluteString containsString:@"alipay://alipayclient/"] || [hosturl.absoluteString containsString:@"weixin://"]){
        NSString *nows = [NSString stringWithFormat:@"%@", hosturl];
        NSString *ho = [nows stringByReplacingOccurrencesOfString:@"alipays" withString:@"qpclient"];
        //        [[UIApplication sharedApplication] openURL:hosturl];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:ho]];
        //        return;
    }
    
    
    //    self.progressView.alpha = 1.0;
    decisionHandler(WKNavigationActionPolicyAllow);
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    NSLog(@"%s", __FUNCTION__);
    [self setCookie:webView];
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%d", self.webView.canGoBack);
    
    [self setLeftButton];
    self.backItem.hidden = !self.webView.canGoBack;
    NSLog(@"%s", __FUNCTION__);
}
- (void)setLeftButton{
    if (!_backItem) {
        
        _backItem = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 44)];
        _backItem.hidden = YES;
        [_backItem setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backItem setImage:[UIImage imageNamed:@"icon_nav_return"] forState:UIControlStateNormal];
        [_backItem addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        [_backItem setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        UIBarButtonItem *leftBarItems = [[UIBarButtonItem alloc]initWithCustomView:_backItem];
        
        self.navigationItem.leftBarButtonItem = leftBarItems;
        
    }
    
}

- (void)backAction{
    [self.webView goBack];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURLCredential *card = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,card);
        
    } else{
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
        
    }
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - WKUIDelegate
- (void)webViewDidClose:(WKWebView *)webView {
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    NSLog(@"%@", message);
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"confirm" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
    NSLog(@"%@", message);
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    
    NSLog(@"%@", prompt);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}




- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
@implementation WeakScriptMessageDelegate

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}

@end
