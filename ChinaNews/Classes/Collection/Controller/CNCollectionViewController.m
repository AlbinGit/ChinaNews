//
//  CNCollectionViewController.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/23.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNCollectionViewController.h"
#import "CNLeftImageTableViewCell.h"
#import "CNLeftVideoTableViewCell.h"
#import "CNTextTableViewCell.h"
#import "CNDetailPageViewController.h"

@interface CNCollectionViewController (){

    NSArray *itemFlagArr;   //0 - 左侧为图片；1 - 左侧为视频；2 - 纯文本
}

@property (nonatomic, strong) NSArray *isPlainTextArr;
@property (nonatomic, strong) NSArray *urlStrArr;

@end

@implementation CNCollectionViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setNavigation];
    [self setCollection];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load Data

- (void)loadData{

    itemFlagArr = @[[NSNumber numberWithInteger:0],
                    [NSNumber numberWithInteger:2],
                    [NSNumber numberWithInteger:1],
                    [NSNumber numberWithInteger:0],
                    [NSNumber numberWithInteger:2],
                    [NSNumber numberWithInteger:1],
                    [NSNumber numberWithInteger:0],
                    [NSNumber numberWithInteger:2],
                    [NSNumber numberWithInteger:1]];
    
    _isPlainTextArr = @[[NSNumber numberWithBool:NO],
                        [NSNumber numberWithBool:YES],
                        [NSNumber numberWithBool:NO],
                        [NSNumber numberWithBool:NO],
                        [NSNumber numberWithBool:YES],
                        [NSNumber numberWithBool:NO],
                        [NSNumber numberWithBool:NO],
                        [NSNumber numberWithBool:YES],
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
                   multimediaUrlStr];
}

#pragma mark - Config UI

- (void)setNavigation{

    self.title = @"收藏";
}

- (void)setCollection{

    _collectionTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, CN_SCREEN_HEIGHT - (CN_STATUS_HEIGHT + CN_NAVIGATION_HEIGHT)) style:UITableViewStylePlain];
    [self.view addSubview:_collectionTV];
    _collectionTV.dataSource = self;
    _collectionTV.delegate = self;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return itemFlagArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 110.*CN_WIDTH_BASE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *leftImageID = @"leftImageID";
    static NSString *leftVideoID = @"leftVideoID";
    static NSString *textID = @"textID";
    
    CNLeftImageTableViewCell *leftImageCell = [tableView dequeueReusableCellWithIdentifier:leftImageID];
    CNLeftVideoTableViewCell *leftVideoCell = [tableView dequeueReusableCellWithIdentifier:leftVideoID];
    CNTextTableViewCell *textCell = [tableView dequeueReusableCellWithIdentifier:textID];
    
    NSInteger row = indexPath.row;
    NSInteger flag = [[itemFlagArr objectAtIndex:row] integerValue];
    
    switch (flag) {
        case 0:
            if (!leftImageCell) {
                
                leftImageCell = [[CNLeftImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftImageID];
                leftImageCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return leftImageCell;
            break;
        case 1:
            if (!leftVideoCell) {
                
                leftVideoCell = [[CNLeftVideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftVideoID];
                leftVideoCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return leftVideoCell;
            break;
        case 2:
            if (!textCell) {
                
                textCell = [[CNTextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:textID];
                textCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return textCell;
            break;
            
        default:
            break;
    }
    
    return nil;
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
