//
//  CNTotalListViewController.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/25.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNTotalListViewController.h"
#import "CNLeftVideoTableViewCell.h"

@interface CNTotalListViewController ()

@end

@implementation CNTotalListViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadData];
    [self setNavigation];
    [self setTotalListUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load Data

- (void)loadData{

    
}

#pragma mark - Config UI

- (void)setNavigation{

    self.title = @"List";
}

- (void)setTotalListUI{

    _totalListTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, CN_SCREEN_HEIGHT - (CN_STATUS_HEIGHT + CN_NAVIGATION_HEIGHT)) style:UITableViewStylePlain];
    [self.view addSubview:_totalListTV];
//    _totalListTV.backgroundColor = [UIColor clearColor];    //TODO：加上此句，背后有其他层出现
    _totalListTV.dataSource = self;
    _totalListTV.delegate = self;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20.;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 110.*CN_HEIGHT_BASE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *totalListID = @"totalListID";
    CNLeftVideoTableViewCell *totalListCell = [tableView dequeueReusableCellWithIdentifier:totalListID];
    
    if (!totalListCell) {
        
        totalListCell = [[CNLeftVideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:totalListID];
        totalListCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return totalListCell;
}

#pragma mark - <UITableViewDelegate>

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
