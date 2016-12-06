//
//  EPLabelFlowView.m
//  EntPartner
//
//  Created by Liufangfang on 16/4/23.
//  Copyright © 2016年 ZongHenghui. All rights reserved.
//

#import "EPLabelFlowView.h"

#define HORIZONTAL_PADDING 8.0f
#define VERTICAL_PADDING   5.0f
#define LABEL_MARGIN       20.0f
#define BOTTOM_MARGIN      10.0f
#define KTapTag            1000

@implementation EPLabelFlowView

-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        totalHeight=0;
        self.frame=frame;
    }
    return self;
}

-(void)setTagWithTagArray:(NSArray*)arr{
    
    previousFrame = CGRectZero;
    [arr enumerateObjectsUsingBlock:^(NSString*str, NSUInteger idx, BOOL *stop) {
        
        UILabel *tagLabel=[[UILabel alloc]initWithFrame:CGRectZero];
//        NSLog(@"str: %@  idx: %ld", str, idx);
//        if(_signalTagColor){
//            //可以单一设置tag的颜色
//            if (_flag == idx) {
//                _signalTagColor = [UIColor whiteColor];
//            }
//            tagLabel.backgroundColor = _signalTagColor;
//        }else{
//            //tag颜色多样
//            tagLabel.backgroundColor=[UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1];
//        }
        if (_flag == idx) {
            
            tagLabel.backgroundColor= _signalTagColor;
        }
        tagLabel.textAlignment=NSTextAlignmentCenter;
        tagLabel.textColor=[CNColor getColor:@"000000" andAlpha:1.0];
        tagLabel.font=CN_FONTTSIZE(15);
        tagLabel.text=str;
        tagLabel.tag=KTapTag+idx;
        tagLabel.layer.cornerRadius = 1;
        tagLabel.layer.borderWidth = 2;
        tagLabel.layer.borderColor = _borderColor.CGColor;
        tagLabel.clipsToBounds=YES;
        tagLabel.userInteractionEnabled = YES;
        [tagLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick:)]];
        
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:15]};
        CGSize Size_str=[str sizeWithAttributes:attrs];
        Size_str.width += HORIZONTAL_PADDING*3;
        Size_str.height += VERTICAL_PADDING*3;
        
        CGRect newRect = CGRectZero;
        if (previousFrame.origin.x + previousFrame.size.width + Size_str.width + LABEL_MARGIN > self.bounds.size.width) {
            
            newRect.origin = CGPointMake(20, previousFrame.origin.y + Size_str.height + BOTTOM_MARGIN);
            totalHeight +=Size_str.height + BOTTOM_MARGIN;
        } else {
            newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + LABEL_MARGIN, previousFrame.origin.y);
        }
        newRect.size = Size_str;
        [tagLabel setFrame:newRect];
        previousFrame=tagLabel.frame;
        [self setHeight:self andHeight:totalHeight+Size_str.height + BOTTOM_MARGIN];
        [self addSubview:tagLabel];
    }];
    
    if(_GBbackgroundColor){
        self.backgroundColor = _GBbackgroundColor;
    }else{
        self.backgroundColor = [UIColor clearColor];
    }
}

- (void)labelClick:(UITapGestureRecognizer *)sender{
    
    NSLog(@"sender %@", sender);
    if (_delegate && [_delegate respondsToSelector:@selector(detailInfos:)]) {
        [_delegate detailInfos:sender];
    }
}

#pragma mark - 改变控件高度

- (void)setHeight:(UIView *)view andHeight:(CGFloat)hight{
    
    CGRect tempFrame = view.frame;
    tempFrame.size.height = hight;
    view.frame = tempFrame;
}

@end
