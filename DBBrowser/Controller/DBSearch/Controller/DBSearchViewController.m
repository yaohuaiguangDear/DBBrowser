//
//  DBSearchViewController.m
//  DBBrowser
//
//  Created by yao on 2019/5/15.
//  Copyright © 2019 yao. All rights reserved.
//

#import "DBSearchViewController.h"
#import "DBDownLoadManager.h"
@interface DBSearchViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;

@end

@implementation DBSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.borderColor = [UIColor grayColor].CGColor;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)downLoadAction:(id)sender {
    DBDownLoadManager *manager = [[DBDownLoadManager alloc] init];
    //    http://vfx.mtime.cn/Video/2019/03/09/mp4/190309153658147087.mp4
    //http://vfx.mtime.cn/Video/2019/03/19/mp4/190319222227698228.mp4
    NSString *url = @"http://pic37.nipic.com/20140113/8800276_184927469000_2.png";
    url = @"http://vfx.mtime.cn/Video/2019/03/09/mp4/190309153658147087.mp4";
    if (self.textView.text.length) {
        url = self.textView.text;
    }
    
    //    [manager downLoadWithURL:url];
    [manager downLoadUseDelegateWithURL:url];
}
- (IBAction)apperContentAction:(id)sender {
    NSString *url = @"http://pic37.nipic.com/20140113/8800276_184927469000_2.png";
    url = @"https://www.baidu.com";
    if (self.textView.text.length) {
        url = self.textView.text;
    }
    NSString *htmlString = [NSString stringWithContentsOfURL:[NSURL URLWithString:url] encoding:NSUTF8StringEncoding error:nil];
    NSString *contentStr = [self getZZwithString:htmlString];
    NSLog(@"%@", contentStr);
    self.textView.text = contentStr;
}
- (NSString *)getZZwithString:(NSString *)string{
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n" options:0 error:nil];
    string = [regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    return string;
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
