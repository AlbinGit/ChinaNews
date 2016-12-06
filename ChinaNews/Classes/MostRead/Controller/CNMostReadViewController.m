//
//  CNMostReadViewController.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/22.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNMostReadViewController.h"
#import "CNTextTableViewCell.h"
#import "CNDetailPageViewController.h"

@interface CNMostReadViewController ()

@property (nonatomic, strong) NSArray *isPlainTextArr;
@property (nonatomic, strong) NSArray *urlStrArr;

@end

@implementation CNMostReadViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setLiveUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load Data

- (void)loadData{
    
    _isPlainTextArr = @[[NSNumber numberWithBool:NO],
                        [NSNumber numberWithBool:YES],
                        [NSNumber numberWithBool:NO],
                        [NSNumber numberWithBool:NO],
                        [NSNumber numberWithBool:YES],
                        [NSNumber numberWithBool:NO],
                        [NSNumber numberWithBool:NO],
                        [NSNumber numberWithBool:YES],
                        [NSNumber numberWithBool:NO],
                        [NSNumber numberWithBool:NO]];
    
    NSString *plainTextUrlStr = @"http://chinanews.cri0.cn/details-text/20161129/d145213f-254d-f5b9-4baa-52e6dbeb7945.html";
    NSString *multimediaUrlStr = @"http://chinanews.cri0.cn/details-media/20161128/c0023f01-3b77-4286-961c-f21658ccc9a8.html";
    _urlStrArr = @[multimediaUrlStr,
                   plainTextUrlStr,
                   multimediaUrlStr,
                   multimediaUrlStr,
                   plainTextUrlStr,
                   multimediaUrlStr,
                   multimediaUrlStr,
                   plainTextUrlStr,
                   multimediaUrlStr,
                   multimediaUrlStr];
}

#pragma mark - Config UI

- (void)setLiveUI{
    
    _mostReadTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, CN_SCREEN_HEIGHT- (CN_STATUS_HEIGHT + CN_NAVIGATION_HEIGHT + CN_SEGMENT_HEIGHT)) style:UITableViewStylePlain];
    [self.view addSubview:_mostReadTV];
    _mostReadTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mostReadTV.dataSource = self;
    _mostReadTV.delegate = self;
}

#pragma mark - Config Invoke Method

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110.*CN_HEIGHT_BASE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *liveID = @"liveID";
    CNTextTableViewCell *liveCell = [tableView dequeueReusableCellWithIdentifier:liveID];
    
    if (!liveCell) {
        
        liveCell = [[CNTextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:liveID];
        liveCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return liveCell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger row = indexPath.row;
    CNDetailPageViewController *detailPageVC = [[CNDetailPageViewController alloc] init];
    [detailPageVC loadDataWithUrlStr:[_urlStrArr objectAtIndex:row] isPlainText:[[_isPlainTextArr objectAtIndex:row] boolValue]];
    [self.navigationController pushViewController:detailPageVC animated:YES];
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
