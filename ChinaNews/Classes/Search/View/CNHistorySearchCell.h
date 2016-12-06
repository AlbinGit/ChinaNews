//
//  EPHistorySearchCell.h
//  EntPartner
//
//  Created by Liufangfang on 16/4/28.
//  Copyright © 2016年 ZongHenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CNHistorySearchCellDelegate <NSObject>

- (void)deleteOneItem:(UIButton *)btn;

@end

@interface CNHistorySearchCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLab;
@property (nonatomic, strong) UIButton *attributeV;
@property (nonatomic, strong) UIView *lineBottom;

@property (nonatomic, weak) id<CNHistorySearchCellDelegate> delegate;

- (void)loadData:(NSString *)title;

@end
