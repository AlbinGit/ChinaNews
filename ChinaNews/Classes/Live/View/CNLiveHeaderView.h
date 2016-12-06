//
//  CNLiveHeaderView.h
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/23.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNView.h"

@protocol CNLiveHeaderViewDelegate <NSObject>

- (void)gotoLiveDetail;

@end

@interface CNLiveHeaderView : CNView

@property (nonatomic, strong) UIView *videoV;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *arrowIcon;
@property (nonatomic, strong) UILabel *sourceLab;
@property (nonatomic, strong) UIImageView *timeIcon;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *attributeLab;

@property (nonatomic, weak) id<CNLiveHeaderViewDelegate> delegate;

@end
