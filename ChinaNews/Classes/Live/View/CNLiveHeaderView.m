//
//  CNLiveHeaderView.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/23.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNLiveHeaderView.h"
#import "HcdCachePlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface CNLiveHeaderView (){

    HcdCacheVideoPlayer *player;
}

@end

@implementation CNLiveHeaderView

#pragma mark - Init Method

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self setLiveHeader];
    }
    return self;
}

#pragma mark - Config UI

- (void)setLiveHeader{

    UIView *videoV = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width * 0.5625)];
    [self addSubview:videoV];
//    player = [[HcdCacheVideoPlayer alloc] init];
//    [player playWithUrl:[NSURL URLWithString:@"http://baobab.wdjcdn.com/14564977406580.mp4"]
//                       showView:videoV
//                   andSuperView:self
//                      withCache:YES];
    _videoV = videoV;
    [self mediaPlayNoSound];

    _titleLab = [[UILabel alloc] init];
    [self addSubview:_titleLab];
    _titleLab.text = @"This is not the outcome we wanted or we worked so hard for, and I'm sorry that we did not win this election for the values we share and the vision we hold for our country.这不是我们所希望的或者为之艰苦努力的结局，我感到难过，我们没有为了我们共有的价值观和我们为国家所持有的愿景而赢得这场选举。";
    _titleLab.textColor = [CNColor blackColor];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.font = CN_FONTTSIZE(15.);
    _titleLab.numberOfLines = 3;
    _titleLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoLiveDetailTap:)];
    [_titleLab addGestureRecognizer:tapGesture];
    
    _arrowIcon = [[UIImageView alloc] init];
    [self addSubview:_arrowIcon];
    _arrowIcon.image = [UIImage imageNamed:@"avatar"];

    _sourceLab = [[UILabel alloc] init];
    [self addSubview:_sourceLab];
    _sourceLab.text = @"BBC";
    _sourceLab.textColor = [CNColor grayColor];
    _sourceLab.textAlignment = NSTextAlignmentLeft;
    _sourceLab.font = CN_FONTTSIZE(13.);
    [_sourceLab sizeToFit];
    
    _timeLab = [[UILabel alloc] init];
    [self addSubview:_timeLab];
    _timeLab.text = @"2016/11/11";
    _timeLab.textColor = [CNColor grayColor];
    _timeLab.textAlignment = NSTextAlignmentCenter;
    _timeLab.font = CN_FONTTSIZE(13.);
    [_timeLab sizeToFit];
    
    _timeIcon = [[UIImageView alloc] init];
    [self addSubview:_timeIcon];
    _timeIcon.image = [UIImage imageNamed:@"avatar"];

    _attributeLab = [[UILabel alloc] init];
    [self addSubview:_attributeLab];
    _attributeLab.backgroundColor = [CNColor grayColor];
    _attributeLab.text = @"LIVE";
    _attributeLab.textColor = [CNColor blueColor];
    _attributeLab.textAlignment = NSTextAlignmentCenter;
    _attributeLab.font = CN_FONTTSIZE(13.);
}

#pragma mark - Private Invoke Method

- (void)mediaPlayNoSound{
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    BOOL flag;
    NSError *setCategoryError = nil;
    flag = [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
}

- (void)gotoLiveDetailTap:(UITapGestureRecognizer *)tap{

    if (_delegate && [_delegate respondsToSelector:@selector(gotoLiveDetail)]) {
        [_delegate gotoLiveDetail];
    }
}

#pragma mark - Layout

- (void)layoutSubviews{

    [super layoutSubviews];
    
    WeakSelf(ws);
    [_videoV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(150.*CN_HEIGHT_BASE);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_videoV.mas_bottom).offset(8.*CN_HEIGHT_BASE);
        make.left.mas_equalTo(12.*CN_WIDTH_BASE);
        make.right.mas_equalTo(-50.*CN_WIDTH_BASE);
        make.height.mas_equalTo(60.*CN_HEIGHT_BASE);
    }];
    
    [_arrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_videoV.mas_bottom).offset(30.*CN_HEIGHT_BASE);
        make.right.mas_equalTo(-12.*CN_WIDTH_BASE);
        make.width.mas_equalTo(16.*CN_WIDTH_BASE);
        make.height.mas_equalTo(23.*CN_HEIGHT_BASE);
    }];
    
    [_sourceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12.*CN_WIDTH_BASE);
        make.bottom.mas_equalTo(-12.*CN_HEIGHT_BASE);
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(ws.mas_centerX);
        make.bottom.mas_equalTo(-12.*CN_HEIGHT_BASE);
    }];
    
    [_timeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12.*CN_HEIGHT_BASE);
        make.right.mas_equalTo(_timeLab.mas_left).offset(-8.*CN_WIDTH_BASE);
        make.width.mas_equalTo(16.*CN_WIDTH_BASE);
        make.height.mas_equalTo(16.*CN_WIDTH_BASE);
    }];
    
    [_attributeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12.*CN_HEIGHT_BASE);
        make.right.mas_equalTo(-12.*CN_WIDTH_BASE);
        make.width.mas_equalTo(50.*CN_WIDTH_BASE);
        make.height.mas_equalTo(20.*CN_HEIGHT_BASE);
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
