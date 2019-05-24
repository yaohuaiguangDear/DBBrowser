//
//  DBSearchViewController.m
//  DBBrowser
//
//  Created by yao on 2019/5/15.
//  Copyright © 2019 yao. All rights reserved.
//

#import "DBSearchViewController.h"
#import "DBDownLoadManager.h"
#import "DBFileManager.h"
#import "DBSearchHistoryCell.h"
@interface DBSearchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *downLoadButton;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray * historyArray;
@end

@implementation DBSearchViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.layer.borderWidth = 0.5;
    self.textView.layer.borderColor = [UIColor grayColor].CGColor;
    self.progressView.progress = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[DBSearchHistoryCell class] forCellReuseIdentifier:@"DBSearchHistoryCell"];
    self.historyArray = [[[[DBFileManager sharedManager] getArrayWithFileName:@"searchHistory"] reverseObjectEnumerator] allObjects];
//    [[DBFileManager sharedManager] createPlistFileWithFileName:@"searchHistory" data:@[@"0",@"10",@"20",@"30",@"40",@"50",@"60",@"70",@"80",@"90"]];
//    [[DBFileManager sharedManager] addDataToPlistFileWithFileName:@"searchHistory" dataArray:@[@"20",@"30"]];
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
     [[DBFileManager sharedManager] addDataToPlistFileWithFileName:@"searchHistory" dataArray:@[url]];
    self.historyArray = [[[[DBFileManager sharedManager] getArrayWithFileName:@"searchHistory"] reverseObjectEnumerator] allObjects];
    [self.tableView reloadData];
    //    [manager downLoadWithURL:url];
//    [manager downLoadUseDelegateWithURL:url];
    [manager downloadTaskWithURL:url progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"下载进度：%.0f％", downloadProgress.fractionCompleted * 100);
        dispatch_async(dispatch_get_main_queue(), ^{
            //如果需要进行UI操作，需要获取主线程进行操作
            self.progressView.progress = downloadProgress.fractionCompleted * 100;

        });
    }];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.historyArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DBSearchHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DBSearchHistoryCell" forIndexPath:indexPath];
    cell.textLabel.text = self.historyArray[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.textView.text = self.historyArray[indexPath.row];
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
