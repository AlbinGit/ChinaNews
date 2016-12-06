//
//  CNLanguageViewController.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/24.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNLanguageViewController.h"

@interface CNLanguageViewController (){

    NSArray *iconArr;
    NSArray *languageArr;
}

@end

@implementation CNLanguageViewController

#pragma mark - View CycleLife

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setLanguageUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load Data

- (void)loadData{

    iconArr = @[@"avatar", @"avatar", @"avatar", @"avatar", @"avatar", @"avatar", @"avatar"];
    languageArr = @[@"中文", @"English", @"Francais", @"EI espanol", @"pyccknn", @"日语", @"Turkiye"];
}

#pragma mark - Config UI

- (void)setLanguageUI{

    _languageTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, CN_SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:_languageTV];
    _languageTV.backgroundColor = [CNColor blackColor];
    _languageTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _languageTV.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _languageTV.dataSource = self;
    _languageTV.delegate = self;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return languageArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 70.*CN_HEIGHT_BASE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *languageID = @"languageID";
    UITableViewCell *languageCell = [tableView dequeueReusableCellWithIdentifier:languageID];
    
    if (!languageCell) {
        
        languageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:languageID];
        //cell默认背景色
        languageCell.backgroundColor = [CNColor blackColor];
        languageCell.textLabel.textColor = [CNColor whiteColor];
        //cell选中时背景色(即自定义cell背景色)
        languageCell.selectedBackgroundView = [[UIView alloc] initWithFrame:languageCell.frame];
        languageCell.selectedBackgroundView.backgroundColor = [CNColor blackColor];
    }
    
    NSInteger row = indexPath.row;
    
    languageCell.imageView.image = [UIImage imageNamed:[iconArr objectAtIndex:row]];
    languageCell.textLabel.text = [languageArr objectAtIndex:row];
    
    return languageCell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"====%@", indexPath);
    UIView *view = tableView.superview;
    [view removeFromSuperview];
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
