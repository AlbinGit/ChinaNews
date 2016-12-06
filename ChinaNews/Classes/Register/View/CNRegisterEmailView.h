//
//  CNRegisterView.h
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/25.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNView.h"
#import "CRIRegisterProgressView.h"

@protocol CNRegisterEmailViewDelegate <NSObject>

- (void)gotoValidationCode;

@end

@interface CNRegisterEmailView : CNView

@property (nonatomic, strong) CRIRegisterProgressView *registerProgressV;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UITextField *textF;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIButton *nextBtn;

@property (nonatomic, weak) id<CNRegisterEmailViewDelegate> delegate;

@end
