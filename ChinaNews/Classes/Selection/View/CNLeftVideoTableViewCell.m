//
//  CNLeftVideoTableViewCell.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/24.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNLeftVideoTableViewCell.h"

@implementation CNLeftVideoTableViewCell

#pragma mark - Init Method

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setSelectionCell];
    }
    
    return self;
}

#pragma mark - Load Data

#pragma mark - Config UI

- (void)setSelectionCell{
    
    _smallIamgeV = [[UIImageView alloc] init];
    [self.contentView addSubview:_smallIamgeV];
    [_smallIamgeV sd_setImageWithURL:[NSURL URLWithString:@"http://n.sinaimg.cn/translate/20151008/zkkZ-fxirmrn3342777.jpg"] placeholderImage:[UIImage imageNamed:@"cri"]];
    
    _playIcon = [[UIImageView alloc] init];
    [_smallIamgeV addSubview:_playIcon];
    _playIcon.image = [UIImage imageNamed:@"avatar"];
    
    _titleLab = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLab];
    _titleLab.text = @"她希望美国人继续为她所信奉的那些价值观而奋斗,美国梦足够大，每个人都有份。她向奥巴马致敬，称赞他作为总统的表现值得美国人感念，也感谢总统一家对她的不遗余力的支持。";
    _titleLab.textColor = [CNColor blackColor];
    _titleLab.textAlignment = NSTextAlignmentLeft;
    _titleLab.font = CN_FONTTSIZE(15.);
    _titleLab.numberOfLines = 3;
    [_titleLab sizeToFit];
    
    _sourceLab = [[UILabel alloc] init];
    [self.contentView addSubview:_sourceLab];
    _sourceLab.text = @"BBC";
    _sourceLab.textColor = [CNColor grayColor];
    _sourceLab.textAlignment = NSTextAlignmentLeft;
    _sourceLab.font = CN_FONTTSIZE(13.);
    [_sourceLab sizeToFit];
    
    //之所以将timeLab放在timeIcon之前，是因为要为timeIcon添加依赖timeLab的约束
    _timeLab = [[UILabel alloc] init];
    [self.contentView addSubview:_timeLab];
    _timeLab.text = @"40分钟之前";
    _timeLab.textColor = [CNColor grayColor];
    _timeLab.textAlignment = NSTextAlignmentLeft;
    _timeLab.font = CN_FONTTSIZE(13.);
    [_timeLab sizeToFit];
    
    _timeIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_timeIcon];
    _timeIcon.image = [UIImage imageNamed:@"avatar"];
}

#pragma mark - Private Invoke Method

#pragma mark - Layout

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_smallIamgeV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12.*CN_HEIGHT_BASE);
        make.left.mas_equalTo(12.*CN_WIDTH_BASE);
        make.bottom.mas_equalTo(-12.*CN_HEIGHT_BASE);
        make.width.mas_equalTo(115.*CN_WIDTH_BASE);
    }];
    
    [_playIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_smallIamgeV.mas_centerX);
        make.centerY.mas_equalTo(_smallIamgeV.mas_centerY);
        make.width.mas_equalTo(23.*CN_WIDTH_BASE);
        make.height.mas_equalTo(23.*CN_WIDTH_BASE);
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15.*CN_HEIGHT_BASE);
        make.left.mas_equalTo(_smallIamgeV.mas_right).offset(12.*CN_WIDTH_BASE);
        make.right.mas_equalTo(-12.*CN_WIDTH_BASE);
    }];
    
    [_sourceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_smallIamgeV.mas_right).offset(12.*CN_WIDTH_BASE);
        make.bottom.mas_equalTo(-15.*CN_HEIGHT_BASE);
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-15.*CN_HEIGHT_BASE);
        make.right.mas_equalTo(-12.*CN_WIDTH_BASE);
    }];
    
    [_timeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-15.*CN_HEIGHT_BASE);
        make.right.mas_equalTo(_timeLab.mas_left).offset(-12.*CN_WIDTH_BASE);
        make.width.mas_equalTo(16.*CN_WIDTH_BASE);
        make.height.mas_equalTo(16.*CN_HEIGHT_BASE);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
