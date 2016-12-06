//
//  CNRegisterViewController.h
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/25.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNViewController.h"
#import "CNRegisterEmailView.h"

@interface CNRegisterEmailViewController : CNViewController<CNRegisterEmailViewDelegate>

@property (nonatomic, strong) CNRegisterEmailView *registerEmailV;

@end
