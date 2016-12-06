//
//  CNSettingViewController.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/24.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNSettingViewController.h"
#import "CNSetLanguageViewController.h"

#define CellRowHeight 60.

@interface CNSettingViewController ()

@end

@implementation CNSettingViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setSettingUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Config UI

- (void)setNavigation{

    self.title = @"设置";
}

- (void)setSettingUI{

    _settingTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, CN_SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:_settingTV];
    _settingTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _settingTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _settingTV.dataSource = self;
    _settingTV.delegate = self;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return CellRowHeight*CN_HEIGHT_BASE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *settingID = @"settingID";
    UITableViewCell *settingCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:settingID];
    settingCell.selectionStyle = UITableViewCellSelectionStyleNone;
    settingCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSInteger row = indexPath.row;
    NSArray *iconArr = @[@"avatar", @"avatar", @"avatar", @"avatar", @"avatar", @"avatar"];
    NSArray *titleArr = @[@"Language", @"Push", @"Cache", @"Feedback", @"Recommended", @"About"];
    
    settingCell.imageView.image = [UIImage imageNamed:[iconArr objectAtIndex:row]];
    settingCell.textLabel.text = [titleArr objectAtIndex:row];
    
    if (0 == row) {
        settingCell.detailTextLabel.text = @"English";
    } else if(1 == row){
        
        settingCell.accessoryType = UITableViewCellAccessoryNone;
        UISwitch *pushST = [[UISwitch alloc] initWithFrame:CGRectMake(CN_SCREEN_WIDTH - 70.*CN_WIDTH_BASE, (CellRowHeight - 20.*CN_HEIGHT_BASE) / 2, 100.*CN_WIDTH_BASE, 20.*CN_HEIGHT_BASE)];
        [settingCell addSubview:pushST];
        //默认时颜色
        pushST.backgroundColor = [CNColor getColor:@"e2e2e2" andAlpha:1.];
        pushST.layer.masksToBounds = YES;
        pushST.layer.cornerRadius = pushST.bounds.size.height/2;
        //边缘颜色
        pushST.tintColor = [CNColor getColor:@"e2e2e2" andAlpha:1.];
        //开启时颜色
        pushST.onTintColor = [CNColor getColor:@"32cd00" andAlpha:1.];
    } else if(2 == row) {
        settingCell.detailTextLabel.text = @"6.66MB";
    }
    
    //在cell底部添加横线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CellRowHeight-.5*CN_HEIGHT_BASE, CN_SCREEN_WIDTH, .5*CN_HEIGHT_BASE)];
    [settingCell.contentView addSubview:line];
    line.backgroundColor = [CNColor grayColor];
    if (2 == indexPath.row) {
        line.frame = CGRectMake(0, CellRowHeight-.5*CN_HEIGHT_BASE, CN_SCREEN_WIDTH, 3.*CN_HEIGHT_BASE);
    }
    
    return settingCell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger row = indexPath.row;
    
    if (0 == row) {
        
        CNSetLanguageViewController *setLanguageVC = [[CNSetLanguageViewController alloc] init];
        [self.navigationController pushViewController:setLanguageVC animated:YES];
    }
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
