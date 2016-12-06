//
//  CNMyHeaderView.h
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/23.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNView.h"

@protocol CNMyHeaderViewDelegate <NSObject>

- (void)login;

@end

@interface CNMyHeaderView : CNView

@property (nonatomic, strong) UIImageView *avatarImageV;
@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIButton *favoriteBtn;
@property (nonatomic, strong) UIButton *messageBtn;
@property (nonatomic, strong) UIButton *settingBtn;

@property (nonatomic, strong) id<CNMyHeaderViewDelegate> delegate;

@end
