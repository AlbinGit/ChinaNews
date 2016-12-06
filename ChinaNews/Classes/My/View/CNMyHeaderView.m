//
//  CNMyHeaderView.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/23.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNMyHeaderView.h"
#import "CRIDrawerViewController.h"

#define Self_Offset_X 300.*CN_WIDTH_BASE
#define AvatarDiameter 60.*CN_WIDTH_BASE

@implementation CNMyHeaderView

#pragma mark - Init Method

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setMyHeaderUI];
    }
    
    return self;
}

#pragma mark - Config UI

- (void)setMyHeaderUI{
    
    _avatarImageV = [[UIImageView alloc] init];
    [self addSubview:_avatarImageV];
    _avatarImageV.frame = CGRectMake(0, 0, AvatarDiameter, AvatarDiameter);
    _avatarImageV.image = [UIImage imageNamed:@"avatar"];
    _avatarImageV.layer.masksToBounds = YES;
    _avatarImageV.layer.cornerRadius = AvatarDiameter/2;
    _avatarImageV.userInteractionEnabled = YES;
    UITapGestureRecognizer *avatarTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginTap:)];
    [_avatarImageV addGestureRecognizer:avatarTapGesture];
    
    _nameLab = [[UILabel alloc] init];
    [self addSubview:_nameLab];
    _nameLab.text = @"梅长苏";
    _nameLab.textColor = [CNColor whiteColor];
    _nameLab.textAlignment = NSTextAlignmentLeft;
    _nameLab.font = CN_FONTTSIZE(13.);
    [_nameLab sizeToFit];
    
    _favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_favoriteBtn];
    [_favoriteBtn setImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [_favoriteBtn setTitle:@"favorite" forState:UIControlStateNormal];
    _favoriteBtn.titleLabel.font = CN_FONTTSIZE(13.);
    [_favoriteBtn setTitleColor:[CNColor whiteColor] forState:UIControlStateNormal];
    [_favoriteBtn setTitleColor:[CNColor redColor] forState:UIControlStateHighlighted];
    [_favoriteBtn setAdjustsImageWhenHighlighted:NO];
    _favoriteBtn.layer.borderWidth = 1.;
    _favoriteBtn.layer.borderColor = [CNColor whiteColor].CGColor;
    [_favoriteBtn addTarget:self action:@selector(favoriteAction:) forControlEvents:UIControlEventTouchUpInside];
    _favoriteBtn.frame = CGRectMake(0, 0, Self_Offset_X/3, 80.*CN_HEIGHT_BASE);
    [self setButton:_favoriteBtn];
    
    _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_messageBtn];
    [_messageBtn setImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [_messageBtn setTitle:@"message" forState:UIControlStateNormal];
    _messageBtn.titleLabel.font = CN_FONTTSIZE(13.);
    [_messageBtn setTitleColor:[CNColor whiteColor] forState:UIControlStateNormal];
    [_messageBtn setTitleColor:[CNColor redColor] forState:UIControlStateHighlighted];
    [_messageBtn setAdjustsImageWhenHighlighted:NO];
    _messageBtn.layer.borderWidth = 1.;
    _messageBtn.layer.borderColor = [CNColor whiteColor].CGColor;
    [_messageBtn addTarget:self action:@selector(messageAction:) forControlEvents:UIControlEventTouchUpInside];
    _messageBtn.frame = CGRectMake(0, 0, Self_Offset_X/3, 80.*CN_HEIGHT_BASE);
    [self setButton:_messageBtn];
    
    _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_settingBtn];
    [_settingBtn setImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [_settingBtn setTitle:@"setting" forState:UIControlStateNormal];
    _settingBtn.titleLabel.font = CN_FONTTSIZE(13.);
    [_settingBtn setTitleColor:[CNColor whiteColor] forState:UIControlStateNormal];
    [_settingBtn setTitleColor:[CNColor redColor] forState:UIControlStateHighlighted];
    [_settingBtn setAdjustsImageWhenHighlighted:NO];
    _settingBtn.layer.borderWidth = 1.;
    _settingBtn.layer.borderColor = [CNColor whiteColor].CGColor;
    [_settingBtn addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    _settingBtn.frame = CGRectMake(0, 0, Self_Offset_X/3, 80.*CN_HEIGHT_BASE);
    [self setButton:_settingBtn];
}

#pragma mark - Private Invoke Method

- (void)loginTap:(UITapGestureRecognizer *)tap{

    if (_delegate && [_delegate respondsToSelector:@selector(login)]) {
        [_delegate login];
    }
}

- (void)favoriteAction:(UIButton *)btn{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CloseLeftVCNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MyToCollectionNotification" object:nil];
}

- (void)messageAction:(UIButton *)btn{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"CloseLeftVCNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MyToMessageNotification" object:nil];
}

- (void)settingAction:(UIButton *)btn{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"CloseLeftVCNotification" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MyToSettingNotification" object:nil];
}

//设置按钮图片在上，文字在下
- (void)setButton:(UIButton *)button{

    CGFloat totalHeight = button.imageView.frame.size.height + button.titleLabel.frame.size.height;
    //设置按钮图片偏移
    [button setImageEdgeInsets:UIEdgeInsetsMake(- (totalHeight - button.imageView.frame.size.height), .0, .0, - button.titleLabel.frame.size.width)];
    //设置按钮标题偏移
    [button setTitleEdgeInsets:UIEdgeInsetsMake(.0, -button.imageView.frame.size.width, - (totalHeight - button.titleLabel.frame.size.height), .0)];
}

#pragma mark - Layout

- (void)layoutSubviews{

    [super layoutSubviews];
    
    [_avatarImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30.*CN_HEIGHT_BASE);
        make.left.mas_equalTo(12.*CN_WIDTH_BASE);
        make.width.mas_equalTo(60.*CN_WIDTH_BASE);
        make.height.mas_equalTo(60.*CN_WIDTH_BASE);
    }];
    
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30.*CN_HEIGHT_BASE + AvatarDiameter/2 - 13./2);
        make.left.mas_equalTo(_avatarImageV.mas_right).offset(10.*CN_WIDTH_BASE);
    }];
    
    [_favoriteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(Self_Offset_X/3);
        make.height.mas_equalTo(80.*CN_HEIGHT_BASE);
    }];
    
    [_messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_favoriteBtn.mas_right).offset(-1);   //这个“-1”设置很重要，如果设为0，则相邻两button的白线并列，下面一样
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(Self_Offset_X/3);
        make.height.mas_equalTo(80.*CN_HEIGHT_BASE);
    }];
    
    [_settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_messageBtn.mas_right).offset(-1);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(Self_Offset_X/3);
        make.height.mas_equalTo(80.*CN_HEIGHT_BASE);
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
