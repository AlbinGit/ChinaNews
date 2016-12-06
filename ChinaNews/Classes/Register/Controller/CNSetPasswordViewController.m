//
//  CNSetPasswordViewController.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/30.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNSetPasswordViewController.h"

@interface CNSetPasswordViewController ()

@end

@implementation CNSetPasswordViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setPasswordUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Config UI

- (void)setNavigation{

    self.title = @"设置密码";
}

- (void)setPasswordUI{

    _setPasswordV = [[CNSetPasswordView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, CN_SCREEN_HEIGHT)];
    [self.view addSubview:_setPasswordV];
    _setPasswordV.backgroundColor = [UIColor whiteColor];
    _setPasswordV.delegate = self;
}

#pragma mark - <CNSetPasswordViewDelegate>

- (void)finishRegister{

    
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
