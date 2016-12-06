//
//  CNValidationCodeView.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/30.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNValidationCodeView.h"

@interface CNValidationCodeView ()<UITextFieldDelegate>{

    NSTimer *timer;
    NSInteger seconds;
}

@end

@implementation CNValidationCodeView

#pragma mark - Init Method

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setValidationCodeUI];
    }
    
    return self;
}

#pragma mark - Config UI

- (void)setValidationCodeUI{
    
    _registerProgressV = [[CRIRegisterProgressView alloc] initWithFrame:CGRectMake(0, 40.*CN_HEIGHT_BASE, CN_SCREEN_WIDTH, 100.*CN_HEIGHT_BASE)];
    [self addSubview:_registerProgressV];
    [_registerProgressV showProgressViewWithTitles:@[@"Enter your Email", @"Enter Validation Code", @"Set your Password"] whenProcess:kCRIRegisterProcessValidationCodeType];
    
    _line1 = [[UIView alloc] init];
    [self addSubview:_line1];
    _line1.backgroundColor = [CNColor lightGrayColor];
    
    _iconV = [[UIImageView alloc] init];
    [self addSubview:_iconV];
    _iconV.image = [UIImage imageNamed:@"avatar"];
    
    _getValidationCodeBtn = [[UIButton alloc] init];
    [self addSubview:_getValidationCodeBtn];
    _getValidationCodeBtn.frame = CGRectMake(0, 0, 60.*CN_WIDTH_BASE, 46.*CN_HEIGHT_BASE);
    _getValidationCodeBtn.backgroundColor = [CNColor whiteColor];
    _getValidationCodeBtn.layer.masksToBounds = YES;
    _getValidationCodeBtn.layer.borderColor = [CNColor blueColor].CGColor;
    _getValidationCodeBtn.layer.borderWidth = 2.*CN_WIDTH_BASE;
    _getValidationCodeBtn.layer.cornerRadius = 3.*CN_WIDTH_BASE;
    [_getValidationCodeBtn setTitle:@"获取验证码" forState: UIControlStateNormal];
    [_getValidationCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _getValidationCodeBtn.titleLabel.font = CN_FONTTSIZE(15.);
    _getValidationCodeBtn.titleLabel.numberOfLines = 0;
    [_getValidationCodeBtn addTarget:self action:@selector(getValidationCodeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _textF = [[UITextField alloc] init];
    [self addSubview:_textF];
    _textF.placeholder = @"Enter your Validation Code";
    _textF.delegate = self;
    
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
    
    _explainLab = [[UILabel alloc] init];
    [self addSubview:_explainLab];
    _explainLab.text = @"* Stray birds of summer come to my window to sing and fly away. And yellow leaves of autumn, which have no songs, flutter and fall there with a sigh. The mighty desert is burning for the love of a blade of grass who shakes her head and laughs and flies away.";
    _explainLab.textColor = [CNColor grayColor];
    _explainLab.textAlignment = NSTextAlignmentLeft;
    _explainLab.font = CN_FONTTSIZE(13.*CN_WIDTH_BASE);
    _explainLab.numberOfLines = 0;
    [_explainLab sizeToFit];
}

#pragma mark - <UITextFieldDelegate>
//限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (range.location >= 11)
        return NO; // return NO to not change text
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma makr - Touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_textF resignFirstResponder];
}

#pragma mark - Private Invoke Method

- (void)getValidationCodeBtnAction:(UIButton *)btn{

    timer = [NSTimer scheduledTimerWithTimeInterval:1. target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    seconds = 30;
    [self timerFireMethod:timer];
}

- (void)timerFireMethod:(NSTimer *)theTimer{

    if (seconds == 1) {
        [theTimer invalidate];
        [_getValidationCodeBtn setTitle:@"获取验证码" forState: UIControlStateNormal];
        [_getValidationCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_getValidationCodeBtn setEnabled:YES];
    }else{
        
        NSString *title = [NSString stringWithFormat:@"还剩%ld秒",seconds];
        seconds--;
        [_getValidationCodeBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_getValidationCodeBtn setEnabled:NO];
        [_getValidationCodeBtn setTitle:title forState:UIControlStateNormal];
    }
}

- (void)nextButtonAction:(UIButton *)btn{
    
    [_textF resignFirstResponder];
    [btn setBackgroundColor:[CNColor grayColor]];
    if (_delegate && [_delegate respondsToSelector:@selector(gotoSetPassword)]) {
        [_delegate gotoSetPassword];
    }
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
    
    [_getValidationCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line1.mas_bottom).offset(30.*CN_HEIGHT_BASE);
        make.right.mas_equalTo(-24.*CN_WIDTH_BASE);
        make.width.mas_equalTo(CGRectGetWidth(_getValidationCodeBtn.frame));
        make.height.mas_equalTo(CGRectGetHeight(_getValidationCodeBtn.frame));
    }];
    
    [_textF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line1.mas_bottom).offset(40.*CN_HEIGHT_BASE);
        make.left.mas_equalTo(_iconV.mas_right).offset(10.*CN_WIDTH_BASE);
        make.right.mas_equalTo(_getValidationCodeBtn.mas_left).offset(-10.*CN_WIDTH_BASE);
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
    
    [_explainLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nextBtn.mas_bottom).offset(15.*CN_HEIGHT_BASE);
        make.left.mas_equalTo(40.*CN_WIDTH_BASE);
        make.right.mas_equalTo(-40.*CN_WIDTH_BASE);
    }];
}

@end
