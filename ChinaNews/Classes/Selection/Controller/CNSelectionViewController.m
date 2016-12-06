//
//  CNSelectionViewController.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/22.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNSelectionViewController.h"
#import "CNLeftImageTableViewCell.h"
#import "CNTotalListViewController.h"
#import "CNDetailPageViewController.h"

@interface CNSelectionViewController ()<UIGestureRecognizerDelegate>{

    NSArray *sectionTitleArr;
}

@property (nonatomic, strong) NSArray *isPlainTextArr;
@property (nonatomic, strong) NSArray *urlStrArr;

@end

@implementation CNSelectionViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setSelectionUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load Data

- (void)loadData{
    
    sectionTitleArr = @[@"国际新闻", @"科技新闻", @"健康新闻", @"娱乐新闻"];
    
    _isPlainTextArr = @[[NSNumber numberWithBool:YES],
                        [NSNumber numberWithBool:NO]];
    
    NSString *plainTextUrlStr = @"http://chinanews.cri0.cn/details-text/20161129/d145213f-254d-f5b9-4baa-52e6dbeb7945.html";
    NSString *multimediaUrlStr = @"http://chinanews.cri0.cn/details-media/20161128/c0023f01-3b77-4286-961c-f21658ccc9a8.html";
    _urlStrArr = @[plainTextUrlStr, multimediaUrlStr];
}

#pragma mark - Config UI

- (void)setSelectionUI{

    self.view.backgroundColor = [CNColor clearColor];
    
    _selectionTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, CN_SCREEN_HEIGHT - (CN_STATUS_HEIGHT + CN_NAVIGATION_HEIGHT + CN_SEGMENT_HEIGHT)) style:UITableViewStylePlain];
    _selectionTV.backgroundColor = [UIColor whiteColor];
    _selectionTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _selectionTV.dataSource = self;
    _selectionTV.delegate = self;
    _selectionTV.tableHeaderView = [self selectionHeaderView];
    [self.view addSubview:_selectionTV];
}

#pragma mark - Config Invoke Method

- (UIView *)selectionHeaderView{

    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, 172.*CN_WIDTH_BASE)];
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [headerV addSubview:imageV];
    [imageV sd_setImageWithURL:[NSURL URLWithString:@"http://img0.xiejing.com/static/uploads/allimg/201611/07/1478487837795253.jpg"] placeholderImage:[UIImage imageNamed:@"cri"]];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    [headerV addSubview:titleLab];
    titleLab.text = @"我希望他会是一个成功的总统，为了所有的美国人”，“我们应该对他抱有开放的心，给他一个领导国家的机会";
    titleLab.textColor = [CNColor whiteColor];
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.font = CN_FONTTSIZE(15.);
    titleLab.numberOfLines = 0;
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12.*CN_WIDTH_BASE);
        make.bottom.mas_equalTo(-10.*CN_HEIGHT_BASE);
        make.right.mas_equalTo(-12.*CN_WIDTH_BASE);
    }];
    
    return headerV;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return sectionTitleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 35.*CN_HEIGHT_BASE;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, 30.*CN_HEIGHT_BASE)];
    headerV.backgroundColor = [UIColor whiteColor];
    
    //左侧文字
    UILabel *sectionTitleLab = [[UILabel alloc] init];
    [headerV addSubview:sectionTitleLab];
    sectionTitleLab.text = [sectionTitleArr objectAtIndex:section];
    sectionTitleLab.textColor = [CNColor getMainColorWithAlpha:1.];
    sectionTitleLab.textAlignment = NSTextAlignmentLeft;
    sectionTitleLab.font = CN_FONTTSIZE(18.);
    [sectionTitleLab sizeToFit];
    [sectionTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12.*CN_HEIGHT_BASE);
        make.left.mas_equalTo(12.*CN_WIDTH_BASE);
    }];
    
    //右侧尖头
    UIImageView *arrowIcon = [[UIImageView alloc] init];
    [headerV addSubview:arrowIcon];
    arrowIcon.image = [UIImage imageNamed:@"avatar"];
    [arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12.*CN_HEIGHT_BASE);
        make.right.mas_equalTo(-12.*CN_WIDTH_BASE);
        make.width.mas_equalTo(23.*CN_WIDTH_BASE);
        make.height.mas_equalTo(23.*CN_HEIGHT_BASE);
    }];
    
    //添加点击事件
    headerV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoTotalList:)];
    [headerV addGestureRecognizer:tapGesture];
    
    return headerV;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 110.*CN_HEIGHT_BASE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *selectionID = @"selectionID";
    CNLeftImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selectionID];
    
    if (!cell) {
        
        cell = [[CNLeftImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectionID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSInteger row = indexPath.row;
    
    CNDetailPageViewController *detailPageVC = [[CNDetailPageViewController alloc] init];
    [detailPageVC loadDataWithUrlStr:[_urlStrArr objectAtIndex:row] isPlainText:[[_isPlainTextArr objectAtIndex:row] boolValue]];
    [self.navigationController pushViewController:detailPageVC animated:YES];
}

#pragma mark - Private Invoke Method

- (void)gotoTotalList:(UITapGestureRecognizer *)tap{

    CNTotalListViewController *totalListVC = [[CNTotalListViewController alloc] init];
    [self.navigationController pushViewController:totalListVC animated:YES];
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
