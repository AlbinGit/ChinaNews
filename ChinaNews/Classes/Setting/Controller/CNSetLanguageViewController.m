//
//  CNLanguageViewController.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/25.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNSetLanguageViewController.h"

@interface CNSetLanguageViewController (){

    NSArray *languageArr;
}

@end

@implementation CNSetLanguageViewController

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self setNavigation];
    [self setLanguageUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load Data

- (void)loadData{

    languageArr = @[@"中文", @"English", @"Francais", @"EI espanol", @"pyccknn", @"日语", @"Turkiye"];
}

#pragma mark - Config UI

- (void)setNavigation{
    
    self.title = @"语言";
}

- (void)setLanguageUI{

    _setLanguageTV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CN_SCREEN_WIDTH, CN_SCREEN_HEIGHT - (CN_STATUS_HEIGHT + CN_NAVIGATION_HEIGHT)) style:UITableViewStylePlain];
    [self.view addSubview:_setLanguageTV];
    _setLanguageTV.backgroundColor = [UIColor whiteColor]; //TODO:因为抽屉的原因，左侧会在底部出现一部分，所以如果该视图的背景色设置为clear，则能看到抽屉页的未被隐藏的部分；当设置成白色时，则完全看不到抽屉未被隐藏的部分
    _setLanguageTV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _setLanguageTV.dataSource = self;
    _setLanguageTV.delegate = self;
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return languageArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80.*CN_HEIGHT_BASE;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *setLanguageID = @"setLanguageID";
    UITableViewCell *setLanguageCell = [tableView dequeueReusableCellWithIdentifier:setLanguageID];
    
    if (!setLanguageCell) {
        
        setLanguageCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:setLanguageID];
        setLanguageCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //在cell底部添加线
        UIView *line = [[UIView alloc] init];
        [setLanguageCell.contentView addSubview:line];
        line.backgroundColor = [CNColor grayColor];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(.5*CN_HEIGHT_BASE);
        }];
    }
    
    NSInteger row = indexPath.row;
    setLanguageCell.textLabel.text = [languageArr objectAtIndex:row];
    
    return setLanguageCell;
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
