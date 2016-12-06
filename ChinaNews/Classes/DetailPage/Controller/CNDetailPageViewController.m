//
//  CNDetailPageViewController.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/29.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNDetailPageViewController.h"

@interface CNDetailPageViewController ()<UIWebViewDelegate>

@property (nonatomic, assign) BOOL isPlainText;
@property (nonatomic, strong) NSString *urlStr;

@end

@implementation CNDetailPageViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setDetaiPageUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!_isPlainText) {
        //使透明，注：在消失的方法里一定要写对应的非透明代码，否则返回到上一级界面，导航栏会乱掉
        [self.navigationController.navigationBar setTranslucent:YES];
        //移除透明导航栏时下面的黑线
        if ([self.navigationController.navigationBar respondsToSelector:@selector(shadowImage)]) {
            
            [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
            [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
        }
    }

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if (!_isPlainText) {
        [self.navigationController.navigationBar setTranslucent:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Load Data

- (void)loadDataWithUrlStr:(NSString *)urlStr isPlainText:(BOOL)isPlainText{

    _urlStr = urlStr;
    _isPlainText = isPlainText;
}

#pragma mark - Config UI

- (void)setNavigation{
    
    if (!_isPlainText) {
        //左侧返回
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 33.*CN_WIDTH_BASE, 33.*CN_HEIGHT_BASE)];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backButtonAcion:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    
    //右侧items
    UIButton *collectionBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 33.*CN_WIDTH_BASE, 33.*CN_HEIGHT_BASE)];
    [collectionBtn setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [collectionBtn addTarget:self action:@selector(collectionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *collectionBtnItem = [[UIBarButtonItem alloc] initWithCustomView:collectionBtn];
    
    UIButton *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 33.*CN_WIDTH_BASE, 33.*CN_HEIGHT_BASE)];
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareBtnItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    
    self.navigationItem.rightBarButtonItems = @[collectionBtnItem, shareBtnItem];
}

- (void)setDetaiPageUI{
    
    self.automaticallyAdjustsScrollViewInsets = NO; //此句也会影响导航栏的显示
    //计算不同详情页的frame值
    CGRect frame = CGRectZero;
    if (!_isPlainText) {
        frame = CGRectMake(0, 0, CN_SCREEN_WIDTH, CN_SCREEN_HEIGHT);
    } else {
        frame = CGRectMake(0, 0, CN_SCREEN_WIDTH, CN_SCREEN_HEIGHT - (CN_STATUS_HEIGHT + CN_NAVIGATION_HEIGHT));
    }
    _detailPageWV = [[UIWebView alloc] initWithFrame:frame];
    [self.view addSubview:_detailPageWV];
    _detailPageWV.backgroundColor = [UIColor whiteColor];
    _detailPageWV.delegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    [_detailPageWV loadRequest:request];
}

#pragma mark - Private Invoke Method

- (void)backButtonAcion:(UIButton *)btn{

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)collectionButtonAction:(UIButton *)btn{

    
}

- (void)shareButtonAction:(UIButton *)btn{

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
