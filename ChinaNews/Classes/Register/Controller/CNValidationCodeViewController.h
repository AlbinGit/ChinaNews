//
//  CNValidationCodeViewController.h
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/30.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNViewController.h"
#import "CNValidationCodeView.h"

@interface CNValidationCodeViewController : CNViewController<CNValidationCodeViewDelegate>

@property (nonatomic, strong) CNValidationCodeView *validationCodeV;

@end
