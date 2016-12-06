//
//  CNSearchViewController.h
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/28.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNViewController.h"

@interface CNSearchViewController : CNViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *searchTV;
@property (nonatomic, strong) UISearchController *searchC;
@property (nonatomic, strong) UISearchBar *searchBar;

@end
