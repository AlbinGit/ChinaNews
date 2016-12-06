//
//  CNHomePageViewController.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/22.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNHomePageViewController.h"
#import "CRIDrawerViewController.h"
#import "CRISegmentViewController.h"
#import "CNLiveViewController.h"
#import "CNMostReadViewController.h"
#import "CNSelectionViewController.h"
#import "CNSearchViewController.h"
#import "CRIMenuDragViewController.h"
#import "CNCollectionViewController.h"
#import "CNMessageViewController.h"
#import "CNSettingViewController.h"

@interface CNHomePageViewController ()

@property (nonatomic, strong) NSMutableArray<CRIMenuUnitModel *> *topChannelArr;
@property (nonatomic, assign) NSInteger chooseIndex;

@end

@implementation CNHomePageViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setHomePageUI];
    [self setNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load Datas

#pragma mark - Property Getter Methods

-(NSMutableArray<CRIMenuUnitModel *> *)topChannelArr{
    if (!_topChannelArr) {
        //这里模拟从本地获取的频道数组
        _topChannelArr = [NSMutableArray array];
        for (int i = 0; i < 10; ++i) {
            CRIMenuUnitModel *channelModel = [[CRIMenuUnitModel alloc] init];
            channelModel.name = [NSString stringWithFormat:@"标题%d", i];
            channelModel.cid = [NSString stringWithFormat:@"%d", i];
            channelModel.isTop = YES;
            [_topChannelArr addObject:channelModel];
        }
    }
    return _topChannelArr;
}

#pragma mark - Config UI

- (void)setNavigation{
    
    //自定义首页标题
    NSMutableAttributedString *attributeTitle = [[NSMutableAttributedString alloc] initWithString:@"CHINANEWS"];
    [attributeTitle addAttribute:NSForegroundColorAttributeName value:[CNColor whiteColor] range:NSMakeRange(0, 5)];
    [attributeTitle addAttribute:NSForegroundColorAttributeName value:[CNColor redColor] range:NSMakeRange(5, 4)];
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake((CN_SCREEN_WIDTH - 160.*CN_WIDTH_BASE)/2, 0, 160.*CN_WIDTH_BASE, CN_NAVIGATION_HEIGHT)];
    titleLab.attributedText = attributeTitle;
    titleLab.font = [UIFont fontWithName:@"Verdana-Bold" size:22.*CN_HEIGHT_BASE];
    titleLab.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLab;
    
    //左侧Item
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 18.*CN_WIDTH_BASE, 16.*CN_HEIGHT_BASE)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    //右侧搜索Item
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 23.*CN_WIDTH_BASE, 23.*CN_HEIGHT_BASE)];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    //右侧菜单Item
    UIButton *menuBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 23.*CN_WIDTH_BASE, 23.*CN_HEIGHT_BASE)];
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"home"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(menuButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menuButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    self.navigationItem.rightBarButtonItems = @[menuButtonItem, searchButtonItem];
}

- (void)setHomePageUI{

    self.view.backgroundColor = [UIColor blackColor];
    
    CNLiveViewController *liveVC = [[CNLiveViewController alloc] init];
    CNMostReadViewController *mostReadVC = [[CNMostReadViewController alloc] init];
    CNSelectionViewController *selectionVC = [[CNSelectionViewController alloc] init];
    
    CNLiveViewController *liveVC2 = [[CNLiveViewController alloc] init];
    CNMostReadViewController *mostReadVC2 = [[CNMostReadViewController alloc] init];
    CNSelectionViewController *selectionVC2 = [[CNSelectionViewController alloc] init];
    
    CNLiveViewController *liveVC3 = [[CNLiveViewController alloc] init];
    CNMostReadViewController *mostReadVC3 = [[CNMostReadViewController alloc] init];
    CNSelectionViewController *selectionVC3 = [[CNSelectionViewController alloc] init];
    
    CRISegmentViewController *segmentVC = [CRISegmentViewController segmentControllerWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, CN_SCREEN_HEIGHT - (CN_STATUS_HEIGHT + CN_NAVIGATION_HEIGHT)) titles:@[@"Live", @"Most Read", @"Selection", @"Live2", @"Most Read2", @"Selection2", @"Live3", @"Most Read3", @"Selection3"]];
    [segmentVC setSegmentTintColor:[CNColor whiteColor]];
    [segmentVC setSegmentViewControllers:@[liveVC, mostReadVC, selectionVC, liveVC2, mostReadVC2, selectionVC2, liveVC3, mostReadVC3, selectionVC3]];
    [segmentVC setSelectedItemAtIndex:2];
    segmentVC.style = CRISegmentStyleDefault;
    
    [segmentVC selectedAtIndex:^(NSInteger index) {
        NSLog(@"index %ld", index);
    }];
    
    [self.view addSubview:segmentVC.view];
    [self addChildViewController:segmentVC];
}

#pragma mark - Config Notification

- (void)setNotification{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoCollection) name:@"MyToCollectionNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoMessage) name:@"MyToMessageNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotoSetting) name:@"MyToSettingNotification" object:nil];
}

#pragma mark - Notificaiton Invoke Method

- (void)gotoCollection{

    CNCollectionViewController *collectionVC = [[CNCollectionViewController alloc] init];
    [self.navigationController pushViewController:collectionVC animated:NO];
}

- (void)gotoMessage{

    CNMessageViewController *messageVC = [[CNMessageViewController alloc] init];
    [self.navigationController pushViewController:messageVC animated:NO];
}

- (void)gotoSetting{

    CNSettingViewController *settingVC = [[CNSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:NO];
}

#pragma mark - Private Invoke Method

- (void)leftButtonAction:(UIButton *)button{

    [[CRIDrawerViewController shareDrawerVC] openLeftVC];
}

- (void)searchButtonAction:(UIButton *)button{

    CNSearchViewController *myVC = [[CNSearchViewController alloc] init];
    [self.navigationController pushViewController:myVC animated:YES];
}

- (void)menuButtonAction:(UIButton *)button{

    CRIMenuDragViewController *menuDragVC = [[CRIMenuDragViewController alloc] initWithTopDataSource:self.topChannelArr andInitialIndex:self.chooseIndex];
    
    __weak CNHomePageViewController *weakSelf = self;
    menuDragVC.removeInitialIndexBlock = ^(NSMutableArray<CRIMenuUnitModel *> *topArr){
        weakSelf.topChannelArr = topArr;
        NSLog(@"删除了初始选中项的回调:\n保留的频道有: %@", topArr);
    };
    menuDragVC.chooseIndexBlock = ^(NSInteger index, NSMutableArray<CRIMenuUnitModel *> *topArr){
        weakSelf.topChannelArr = topArr;
        weakSelf.chooseIndex = index;
        NSLog(@"选中了某一项的回调:\n保留的频道有: %@, 选中第%ld个频道", topArr, index);
    };
    
    menuDragVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:menuDragVC animated:YES completion:nil];
    
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
