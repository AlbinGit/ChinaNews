//
//  CNRegisterView.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/25.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNRegisterEmailView.h"
#import "CRIToastView.h"

@interface CNRegisterEmailView ()<UITextFieldDelegate>

@end

@implementation CNRegisterEmailView

#pragma mark - Init Method

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setRegisterUI];
    }
    
    return self;
}

#pragma mark - Config UI

- (void)setRegisterUI{

    _registerProgressV = [[CRIRegisterProgressView alloc] initWithFrame:CGRectMake(0, 40.*CN_HEIGHT_BASE, CN_SCREEN_WIDTH, 100.*CN_HEIGHT_BASE)];
    [self addSubview:_registerProgressV];
    [_registerProgressV showProgressViewWithTitles:@[@"Enter your Email", @"Enter Validation Code", @"Set your Password"] whenProcess:kCRIRegisterProcessEnterEmailType];

    _line1 = [[UIView alloc] init];
    [self addSubview:_line1];
    _line1.backgroundColor = [CNColor lightGrayColor];
    
    _iconV = [[UIImageView alloc] init];
    [self addSubview:_iconV];
    _iconV.image = [UIImage imageNamed:@"avatar"];
    
    _textF = [[UITextField alloc] init];
    [self addSubview:_textF];
    _textF.delegate = self;
    _textF.placeholder = @"Enter your Email";
    
    _line2 = [[UIView alloc] init];
    [self addSubview:_line2];
    _line2.backgroundColor = [CNColor lightGrayColor];

    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_nextBtn];
    _nextBtn.frame = CGRectMake(0, 0, CN_SCREEN_WIDTH, 40.*CN_HEIGHT_BASE);
    _nextBtn.layer.masksToBounds = YES;
    _nextBtn.layer.cornerRadius = 5.*CN_WIDTH_BASE;
    _nextBtn.backgroundColor = [CNColor cyanColor];
    [_nextBtn setTitle:@"Next Step" forState:UIControlStateNormal];
    [_nextBtn setTintColor:[CNColor whiteColor]];
    _nextBtn.titleLabel.font = CN_FONTTSIZE(15.);
    [_nextBtn addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}

#pragma makr - Touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [_textF resignFirstResponder];
}

#pragma mark - Private Invoke Method

- (void)nextButtonAction:(UIButton *)btn{
    
//    [_textF resignFirstResponder];
//    if (![self isValidateEmail:_textF.text]) {
//        [[CRIToastView alloc] addTitle:@"逗我呢，请输入正确邮箱！" addView:self];;
//    } else {
    
        if (_delegate && [_delegate respondsToSelector:@selector(gotoValidationCode)]) {
            [_delegate gotoValidationCode];
        }
        
//    }
}

//邮箱地址的正则表达式
- (BOOL)isValidateEmail:(NSString *)email{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - Layout

- (void)layoutSubviews{

    [_registerProgressV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(40.*CN_HEIGHT_BASE);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(100.*CN_HEIGHT_BASE);
    }];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_registerProgressV.mas_bottom).offset(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(.5*CN_HEIGHT_BASE);
    }];
    
    [_iconV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line1.mas_bottom).offset(42.*CN_HEIGHT_BASE);
        make.left.mas_equalTo(24.*CN_WIDTH_BASE);
        make.width.mas_equalTo(23.*CN_WIDTH_BASE);
        make.height.mas_equalTo(23.*CN_HEIGHT_BASE);
    }];
    
    [_textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line1.mas_bottom).offset(40.*CN_HEIGHT_BASE);
        make.left.mas_equalTo(_iconV.mas_right).offset(10.*CN_WIDTH_BASE);
        make.right.mas_equalTo(-24.*CN_WIDTH_BASE);
        make.height.mas_equalTo(30.*CN_HEIGHT_BASE);
    }];
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_textF.mas_bottom).offset(10.*CN_HEIGHT_BASE);
        make.left.mas_equalTo(12.*CN_WIDTH_BASE);
        make.right.mas_equalTo(-12.*CN_WIDTH_BASE);
        make.height.mas_equalTo(.5*CN_HEIGHT_BASE);
    }];
    
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line2.mas_bottom).offset(30.*CN_HEIGHT_BASE);
        make.left.mas_equalTo(40.*CN_WIDTH_BASE);
        make.right.mas_equalTo(-40.*CN_WIDTH_BASE);
        make.height.mas_equalTo(40.*CN_HEIGHT_BASE);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
