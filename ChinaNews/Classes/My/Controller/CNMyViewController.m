//
//  CNMyViewController.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/22.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNMyViewController.h"
#import "CNMyHeaderView.h"
#import "CNRegisterEmailViewController.h"
#import "CRIDrawerViewController.h"
#import "CNLanguageViewController.h"
#import "CNLoginViewController.h"

@interface CNMyViewController ()<CNMyHeaderViewDelegate>

@end

@implementation CNMyViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setMyUI];
    self.view.backgroundColor = [CNColor grayColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Config UI

- (void)setNavigation{

    self.title = @"个人信息";
}

- (void)setMyUI{

    _myTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, CN_SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:_myTV];
    _myTV.backgroundColor = [CNColor grayColor];
    _myTV.scrollEnabled = NO;
    _myTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _myTV.tableHeaderView = [self myHeaderView];
    _myTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _myTV.dataSource = self;
    _myTV.delegate = self;
}

#pragma mark - Config Invoke Method

- (UIView *)myHeaderView{

    CNMyHeaderView *headerV = [[CNMyHeaderView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, 200.*CN_HEIGHT_BASE)];
    headerV.delegate = self;
    return headerV;
}

#pragma mark - <CNMyHeaderViewDelegate>

- (void)login{

//    CNRegisterEmailViewController *registerVC = [[CNRegisterEmailViewController alloc] init];
    CNLoginViewController *registerVC = [[CNLoginViewController alloc]init];
    UINavigationController *registerNC = [[UINavigationController alloc] initWithRootViewController:registerVC];
    registerNC.navigationBar.translucent = NO;
    registerNC.navigationBar.barTintColor = [CNColor getMainColorWithAlpha:1.];        //导航栏背景颜色
    registerNC.navigationBar.tintColor = [UIColor whiteColor];          //导航栏返回按钮颜色
    [registerNC.navigationBar setTitleTextAttributes:@{NSFontAttributeName: CN_FONTTSIZE(20.),NSForegroundColorAttributeName: [UIColor whiteColor]}];    //导航栏标题大小及颜色
    [self presentViewController:registerNC animated:YES completion:nil];
    
    
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50.*CN_HEIGHT_BASE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *myID = @"myID";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:myID];
    
    if (!myCell) {
        
        myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myID];
        //cell默认背景色
        myCell.backgroundColor = [CNColor grayColor];
        myCell.textLabel.textColor = [CNColor whiteColor];
        //cell选中时背景色(即自定义cell背景色)
        myCell.selectedBackgroundView = [[UIView alloc] initWithFrame:myCell.frame];
        myCell.selectedBackgroundView.backgroundColor = [CNColor blackColor];
    }
    
    NSArray *iconArr = @[@"avatar", @"avatar", @"avatar", @"avatar", @"avatar"];
    NSArray *titleArr = @[@"Language", @"Live", @"Selected", @"Most Read", @"China Cloud"];
    myCell.imageView.image = [UIImage imageNamed:[iconArr objectAtIndex:indexPath.row]];
    myCell.textLabel.text = [titleArr objectAtIndex:indexPath.row];
    
    return myCell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [UIView animateWithDuration:.25 animations:^{
        
//        CNLanguageViewController *languageVC = [[CNLanguageViewController alloc] init];
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        [window addSubview:languageVC.view];
//        languageVC.view.frame = CGRectMake(110.*CN_WIDTH_BASE, 0, 300.*CN_WIDTH_BASE, CN_HEIGHT_BASE);
    } completion:^(BOOL finished) {
    
    }];
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
