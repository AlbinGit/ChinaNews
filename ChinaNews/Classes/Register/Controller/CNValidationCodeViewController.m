//
//  CNValidationCodeViewController.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/30.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNValidationCodeViewController.h"
#import "CNSetPasswordViewController.h"

@interface CNValidationCodeViewController ()

@end

@implementation CNValidationCodeViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setValidationCodeUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Config UI

- (void)setNavigation{

    self.title = @"验证码";
}

- (void)setValidationCodeUI{

    _validationCodeV = [[CNValidationCodeView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, CN_SCREEN_HEIGHT)];
    [self.view addSubview:_validationCodeV];
    _validationCodeV.backgroundColor = [UIColor whiteColor];
    _validationCodeV.delegate = self;
}

#pragma mark - <CNValidationCodeViewDelegate>

- (void)gotoSetPassword{

    CNSetPasswordViewController *setPasswordVC = [[CNSetPasswordViewController alloc] init];
    [self.navigationController pushViewController:setPasswordVC animated:YES];
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
