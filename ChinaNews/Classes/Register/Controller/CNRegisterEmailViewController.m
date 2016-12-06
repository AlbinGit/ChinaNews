//
//  CNRegisterViewController.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/25.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNRegisterEmailViewController.h"
#import "CNValidationCodeViewController.h"

@interface CNRegisterEmailViewController ()

@end

@implementation CNRegisterEmailViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setRegisterUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Config UI

- (void)setNavigation{

    self.title = @"注册";
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 20.*CN_WIDTH_BASE, 20.*CN_HEIGHT_BASE);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (void)setRegisterUI{
    
    _registerEmailV = [[CNRegisterEmailView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, CN_SCREEN_HEIGHT)];
    [self.view addSubview:_registerEmailV];
    _registerEmailV.backgroundColor = [CNColor whiteColor];
    _registerEmailV.delegate = self;
}

- (void)backButtonAction:(UIButton *)btn{

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - <CNRegisterEmailViewDelegate>

- (void)gotoValidationCode{

    CNValidationCodeViewController *validationCodeVC = [[CNValidationCodeViewController alloc] init];
    [self.navigationController pushViewController:validationCodeVC animated:YES];
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
