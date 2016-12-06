//
//  CNSetPasswordViewController.h
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/30.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNViewController.h"
#import "CNSetPasswordView.h"

@interface CNSetPasswordViewController : CNViewController<CNSetPasswordViewDelegate>

@property (nonatomic, strong) CNSetPasswordView *setPasswordV;

@end
