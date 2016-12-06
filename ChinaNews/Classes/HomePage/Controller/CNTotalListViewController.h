//
//  CNTotalListViewController.h
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/25.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNViewController.h"

@interface CNTotalListViewController : CNViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *totalListTV;

@end
