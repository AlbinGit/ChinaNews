//
//  CNSelectionViewController.h
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/22.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNViewController.h"

@interface CNSelectionViewController : CNViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView  *selectionTV;

@end
