//
//  CNTextTableViewCell.h
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/24.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNTextTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *sourceLab;
@property (nonatomic, strong) UIImageView *timeIcon;
@property (nonatomic, strong) UILabel *timeLab;

@end
