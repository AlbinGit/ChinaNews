//
//  CNSettingViewController.h
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/24.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNViewController.h"

@interface CNSettingViewController : CNViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *settingTV;

@end
