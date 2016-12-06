//
//  CNDetailPageViewController.h
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/29.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNViewController.h"

@interface CNDetailPageViewController : CNViewController

@property (nonatomic, strong) UIWebView *detailPageWV;

- (void)loadDataWithUrlStr:(NSString *)urlStr isPlainText:(BOOL)isPlainText;

@end
