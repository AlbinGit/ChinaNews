//
//  CNSearchViewController.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/28.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNSearchViewController.h"
#import "EPLabelFlowView.h"
#import "CNHistorySearchCell.h"

@interface CNSearchViewController ()<UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate, EPLabelFlowViewDelegate, CNHistorySearchCellDelegate>{
    
    UIView *_searchBarBackgroundView;
    UIButton *_clearBtn;
}

@property (nonatomic, assign) NSInteger sectionNumber;
@property (nonatomic, assign) NSInteger indexRow;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) NSMutableArray *searchList;
@property (nonatomic, strong) NSMutableArray *historyNames;

@end

@implementation CNSearchViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setNavigation];
    [self setSearchUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Load Data


- (void)loadData{
    
    _sectionNumber = 1;
    _historyNames = [NSMutableArray arrayWithObjects:@"希拉里", @"特朗普", @"伊万卡",@"奥巴马",@"克林顿", @"陈坤",@"过年好",@"你好，疯子", @"布什", @"希拉里", @"特朗普", @"伊万卡", nil];
}

#pragma mark - Config UI

- (void)setNavigation{
    
    self.title = @"搜索";
}

- (void)setSearchUI{
    
    _searchC = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searchC.dimsBackgroundDuringPresentation = YES; //设置开始搜索时背景显示与否
    _searchC.searchResultsUpdater = self;
    _searchC.hidesNavigationBarDuringPresentation = NO;
    
    [self setMySearchTV];
}

- (void)setMySearchTV{
    
    _searchTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, CN_SCREEN_HEIGHT - (CN_STATUS_HEIGHT + CN_NAVIGATION_HEIGHT)) style:UITableViewStylePlain];
    _searchTV.backgroundColor = [CNColor getColor:@"f4f4f4" andAlpha:1.0];
    _searchTV.dataSource = self;
    _searchTV.delegate = self;
    _searchTV.bounces = NO;
    _searchTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _searchTV.tableHeaderView = [self setMySearchBar];
    _searchTV.tableFooterView = [self tableViewFooterView];
    [self.view addSubview:_searchTV];
}

- (UIView *)setMySearchBar{
    
    _searchBarBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, CN_NAVIGATION_HEIGHT)];
    _searchBarBackgroundView.backgroundColor = [UIColor blackColor];
    
    _searchBar = [[UISearchBar alloc] initWithFrame:_searchBarBackgroundView.bounds];
    [_searchBarBackgroundView addSubview:_searchBar];
    //    _searchBar = _searchC.searchBar;
    _searchBar.delegate = self;
    [self clearSearchBarackground];
    _searchBar.backgroundColor = [UIColor clearColor];
    //    [self setSearchTextField];
    [self setSearchBarCancelStyle];
    _searchBar.placeholder = @"搜索感兴趣的内容";
    _searchBar.tintColor = [UIColor blackColor];
    _searchBar.showsCancelButton = YES;
    
    return _searchBarBackgroundView;
}

- (UIView *)tableViewFooterView{
    
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, 86*CN_HEIGHT_BASE)];
    footerV.backgroundColor = [UIColor whiteColor];
    
    UIView *lineUpFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, .5*CN_HEIGHT_BASE)];
    [footerV addSubview:lineUpFooter];
    lineUpFooter.backgroundColor = [CNColor getColor:@"999999" andAlpha:1.];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(30. * CN_WIDTH_BASE, 17. * CN_HEIGHT_BASE, CN_SCREEN_WIDTH - 30. * 2 * CN_WIDTH_BASE, 49. * CN_HEIGHT_BASE)];
    [footerV addSubview:btn];
    btn.backgroundColor = [CNColor lightGrayColor];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5. *CN_HEIGHT_BASE;
    [btn setTitle:@"清空记录" forState:UIControlStateNormal];
    [btn setTitleColor:[CNColor getColor:@"000000" andAlpha:1.0] forState:UIControlStateNormal];
    [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    btn.titleLabel.font = CN_FONTTSIZE(14);
    [btn addTarget:self action:@selector(clearDatas:) forControlEvents:UIControlEventTouchUpInside];
    _clearBtn = btn;
    
    UIView *lineBlowFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 66*CN_HEIGHT_BASE, CN_SCREEN_WIDTH, .5*CN_HEIGHT_BASE)];
    [footerV addSubview:lineBlowFooter];
    lineBlowFooter.backgroundColor = [CNColor getColor:@"f4f4f4" andAlpha:1.0];
    
    return footerV;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _sectionNumber;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (!_searchC.active) {
        return 60.;
    }else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, 33*CN_HEIGHT_BASE)];
    headerV.backgroundColor = [UIColor whiteColor];
    
    if (!_searchC.active) {
        
        UILabel *titileLab = [[UILabel alloc] init];
        titileLab.textColor = [CNColor getColor:@"000000" andAlpha:1.0];
        titileLab.font = [UIFont systemFontOfSize:18];
        titileLab.text = @"搜索历史";
        [titileLab sizeToFit];
        [headerV addSubview:titileLab];
        titileLab.translatesAutoresizingMaskIntoConstraints = NO;
        [headerV addConstraint:[NSLayoutConstraint constraintWithItem:titileLab attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:headerV attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        [headerV addConstraint:[NSLayoutConstraint constraintWithItem:titileLab attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:headerV attribute:NSLayoutAttributeLeading multiplier:1 constant:10*CN_WIDTH_BASE]];
    } else {
        [headerV addSubview:_searchBar];
    }
    return headerV;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (!_searchC.active) {
        return _historyNames.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!_searchC.active) {
        return 50*CN_HEIGHT_BASE;
    }
    return 0.;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        
    static NSString * const historySearchID = @"searchIdentifier";
    CNHistorySearchCell *historySearchCell = [tableView dequeueReusableCellWithIdentifier:historySearchID];
    
    if (nil == historySearchCell) {
        
        historySearchCell = [[CNHistorySearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:historySearchID];
        historySearchCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    historySearchCell.delegate = self;
    [historySearchCell loadData:[_historyNames objectAtIndex:indexPath.row]];
    
    return historySearchCell;
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //TODO:测试，跳转到一元购详情页
//    EPPurchaseDetailsController *purchaseDetailsC = [[EPPurchaseDetailsController alloc] init];
//    [self.navigationController pushViewController:purchaseDetailsC animated:YES];
}

#pragma mark - <EPLabelFlowViewDelegate>

- (void)detailInfos:(id)sender{
    NSLog(@"热门搜索sender: %@",sender);
    //TODO:测试，跳到一元购页面
//    EPPurchaseDetailsController *purchaseC = [[EPPurchaseDetailsController alloc] init];
//    [self.navigationController pushViewController:purchaseC animated:YES];
}

#pragma mark - <UISearchBarDelegate>

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"searchBarSearchButtonClicked _searchC.active %d", _searchC.active);
    [self searchBar:_searchBar textDidChange:@"hello"];
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(8*CN_WIDTH_BASE, 8*CN_HEIGHT_BASE, 23*CN_WIDTH_BASE, 23*CN_WIDTH_BASE)];
    backBtn.backgroundColor = [UIColor blackColor];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [_searchBarBackgroundView addSubview:backBtn];
    
    _searchBar.frame = CGRectMake(41*CN_WIDTH_BASE, 0, CN_SCREEN_WIDTH-41*CN_WIDTH_BASE, CGRectGetHeight(_searchBar.frame));
    _searchC.searchBar.searchFieldBackgroundPositionAdjustment = UIOffsetMake(0, 45);
    
    _searchBar.showsCancelButton = NO;
    [_searchBar resignFirstResponder];
}

- (void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"searchBarCancelButtonClicked _searchC.active: %d", _searchC.active);
    if (!_searchC.active) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self searchBar:_searchBar textDidChange:@"hello"];
        [_searchBar resignFirstResponder];
    }
}

#pragma mark - <UISearchResultsUpdating>

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    [_searchList removeAllObjects];
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", _searchBar.text];
    _searchList = [[_dataList filteredArrayUsingPredicate:searchPredicate] mutableCopy];
    dispatch_async(dispatch_get_main_queue(), ^{
        [_searchTV reloadData];
    });
    NSLog(@"ResultsUpdating:%@", searchController.searchBar.text);
}

#pragma mark - UISearchControllerDelegate代理

//测试UISearchController的执行过程

- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"willPresentSearchController");
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"didPresentSearchController");
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"willDismissSearchController");
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"didDismissSearchController");
}

- (void)presentSearchController:(UISearchController *)searchController
{
    NSLog(@"presentSearchController");
}

#pragma mark - <CNHistorySearchCellDelegate>

- (void)deleteOneItem:(UIButton *)btn{
    
    NSIndexPath *indexPath = nil;
    
    if ([btn.superview.superview isKindOfClass:[UITableViewCell class]]) {  //注：是一个superview还是二个superview，取决于将控件加到cell本身上，还是cell的contentView上
        
        UITableViewCell *cell = (UITableViewCell *)btn.superview.superview;
        indexPath = [_searchTV indexPathForCell:cell];
        _indexPath = indexPath;
    }
    
    NSInteger row = indexPath.row;
    //删除数据
    [_historyNames removeObjectAtIndex:row];
    //删除cell
    [_searchTV beginUpdates];
    [_searchTV deleteRowsAtIndexPaths:[NSArray arrayWithObject:_indexPath]withRowAnimation:UITableViewRowAnimationLeft];
    [_searchTV endUpdates];
}

#pragma mark - Private Invoke Method

- (void)clearDatas:(UIButton *)btn{
    
    if (_historyNames.count != 0) {
        
        [_searchTV beginUpdates];
        [_searchTV deleteSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
        [_searchTV endUpdates];
        
        [_historyNames removeAllObjects];
        _sectionNumber += 1;
        [_searchTV reloadData];
        
        _clearBtn.enabled = NO;
    }
}

#pragma mark - SearchBar Invoke Method

- (void)clearSearchBarackground{
    
    for (UIView *view in _searchBar.subviews) {
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {// for before iOS7.0
            if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [view removeFromSuperview];
                break;
            }
        } else {// for later iOS7.0(include)
            if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
                [[view.subviews objectAtIndex:0] removeFromSuperview];
                break;
            }
        }
    }
}

- (void)setSearchTextField{
    
    for (UIView* subview in [[_searchBar.subviews lastObject] subviews]) {
        
        if ([subview isKindOfClass:[UITextField class]]) {
            
            UITextField *textField = (UITextField*)subview;
            textField.font = CN_FONTTSIZE(15.);                        //修改输入框字体大小
            textField.textColor = [UIColor redColor];                //修改输入字体的颜色
            [textField setBackgroundColor:[UIColor grayColor]];      //修改输入框的颜色
            [textField setValue:[UIColor whiteColor]                 forKeyPath:@"_placeholderLabel.textColor"];          //修改placeholder的颜色
        } else if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]){
            [subview removeFromSuperview];
        }
    }
}

- (void)setSearchBarCancelStyle{
    
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor:[UIColor grayColor]];
    [shadow setShadowOffset:CGSizeMake(0, 1)];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil]
     setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,shadow,NSShadowAttributeName,nil]
     forState:UIControlStateNormal];
}

@end
