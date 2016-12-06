//
//  CNLoginViewController.m
//  ChinaNews
//
//  Created by LYB on 16/12/5.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNLoginViewController.h"
#import "CNLoginView.h"

@interface CNLoginViewController ()




@end

@implementation CNLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigation];
    [self createIU];
}

- (void)setNavigation{
    
    self.title = @"Sign in";
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 20.*CN_WIDTH_BASE, 20.*CN_HEIGHT_BASE);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (void)backButtonAction:(UIButton *)btn{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)createIU
{
    CNLoginView *view = [CNLoginView new];
    self.view = view;
    
    view.loginBlock = ^(NSString *account,NSString *password)
    {
        NSLog(@"login——>account:%@,password:%@",account,password);
        
    };
    
    view.forgotPasswordBlock = ^(NSString *account)
    {
        NSLog(@"Forgot Password-->%@",account);
    };
    
    view.otherLoginBlock = ^(NSInteger index)
    {
        NSLog(@"otherLogin-->%d",index);
    };
    
    view.registeredBlock = ^()
    {
        NSLog(@"registered");
    };
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
