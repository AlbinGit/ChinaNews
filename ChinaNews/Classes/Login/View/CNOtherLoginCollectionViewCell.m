//
//  CNOtherLoginCollectionViewCell.m
//  ChinaNews
//
//  Created by LYB on 16/12/5.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNOtherLoginCollectionViewCell.h"

@implementation CNOtherLoginCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self p_createUI];
    }
    return self;
}

- (void)p_createUI
{
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = 50/2;
    [self.contentView addSubview:_imgView];
}


@end
