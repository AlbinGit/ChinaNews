//
//  CNCollectionViewController.h
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/23.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNViewController.h"

@interface CNCollectionViewController : CNViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *collectionTV;

@end
