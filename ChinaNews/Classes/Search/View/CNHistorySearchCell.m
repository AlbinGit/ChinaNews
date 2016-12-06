//
//  EPHistorySearchCell.m
//  EntPartner
//
//  Created by Liufangfang on 16/4/28.
//  Copyright © 2016年 ZongHenghui. All rights reserved.
//

#import "CNHistorySearchCell.h"

static CGFloat const attributeVHeight = 23.f;

@interface CNHistorySearchCell (){

    NSString *_title;
}

@end

@implementation CNHistorySearchCell

#pragma mark - Init Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setHistorySearchCell];
    }
    return self;
}

#pragma mark - Load Data

- (void)loadData:(NSString *)title{

    _title = title;
    
    _nameLab.text = _title;
}

#pragma mark - Config UI

- (void)setHistorySearchCell{
    
    UILabel *nameLab = [[UILabel alloc] init];
    [self.contentView addSubview:nameLab];
    nameLab.backgroundColor = [UIColor clearColor];
    nameLab.textColor = [CNColor getColor:@"6e6e6e" andAlpha:1.0];
    [nameLab sizeToFit];
    nameLab.font = CN_FONTTSIZE(15);
    _nameLab = nameLab;
    
    UIButton *attributeV = [[UIButton alloc] init];
    [self.contentView addSubview:attributeV];
    attributeV.frame = CGRectMake(0, 0, attributeVHeight * CN_WIDTH_BASE, attributeVHeight * CN_WIDTH_BASE);
    attributeV.layer.masksToBounds = YES;
    attributeV.layer.cornerRadius = attributeVHeight / 2  * CN_WIDTH_BASE;
    [attributeV setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [attributeV addTarget:self action:@selector(attributeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    _attributeV = attributeV;
    
    UIView *lineBottom = [[UIView alloc] init];
    [self.contentView addSubview:lineBottom];
    lineBottom.backgroundColor = [CNColor getColor:@"999999" andAlpha:1.0];
    _lineBottom = lineBottom;
}

#pragma mark - Private Invoke Method

- (void)attributeButtonAction:(UIButton *)btn{

    if (_delegate && [_delegate respondsToSelector:@selector(deleteOneItem:)]) {
        [_delegate deleteOneItem:btn];
    }
}

#pragma mark - Layout

- (void)layoutSubviews{

    [super layoutSubviews];
    
    WeakSelf(ws);
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(ws.mas_centerY);
        make.left.mas_equalTo(ws.mas_left).with.offset(13*CN_WIDTH_BASE);
    }];
    
    [_attributeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(ws.mas_centerY);
        make.right.mas_equalTo(-13*CN_WIDTH_BASE);
        make.width.height.mas_equalTo(attributeVHeight * CN_WIDTH_BASE);
    }];
    
    [_lineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12.*CN_WIDTH_BASE);
        make.right.mas_equalTo(-12.*CN_WIDTH_BASE);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(.5*CN_HEIGHT_BASE);
    }];
}

@end
