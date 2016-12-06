//
//  EPLabelFlowView.h
//  EntPartner
//
//  Created by Liufangfang on 16/4/23.
//  Copyright © 2016年 ZongHenghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EPLabelFlowViewDelegate <NSObject>

- (void)detailInfos:(id)sender;

@end

@interface EPLabelFlowView : UIView{
    
    CGRect previousFrame ;
    int totalHeight ;
}
/**
 * 整个view的背景色
 */
@property(nonatomic,retain)UIColor *GBbackgroundColor;
/**
 *  设置单一颜色
 */
@property(nonatomic)UIColor *signalTagColor;

/**
 *  设置边框颜色
 */
@property (nonatomic) UIColor *borderColor;

@property(nonatomic,assign)int flag;

@property (nonatomic, assign) id<EPLabelFlowViewDelegate> delegate;

/**
 *  标签文本赋值
 */
-(void)setTagWithTagArray:(NSArray*)arr;

@end
