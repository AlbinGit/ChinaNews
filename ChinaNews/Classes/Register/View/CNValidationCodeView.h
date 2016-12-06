//
//  CNValidationCodeView.h
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/30.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNView.h"
#import "CRIRegisterProgressView.h"

@protocol CNValidationCodeViewDelegate <NSObject>

- (void)gotoSetPassword;

@end

@interface CNValidationCodeView : CNView

@property (nonatomic, strong) CRIRegisterProgressView *registerProgressV;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UITextField *textF;
@property (nonatomic, strong) UIButton *getValidationCodeBtn;
@property (nonatomic, strong) UIView *line2;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UILabel *explainLab;

@property (nonatomic, weak) id<CNValidationCodeViewDelegate> delegate;

@end
