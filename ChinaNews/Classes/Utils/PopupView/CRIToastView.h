//
//  CRIToastView.h
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/30.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRIToastView : NSObject{
    
    UILabel *titleLabel;
}

+(id)shareInstance;
//释放当前的对象
+(void)releaseSingle;
-(void)addTitle:(NSString *)title addView:(UIView *)view;
-(void)addKeyboardTitle:(NSString *)title addView:(UIView *)view;

@end
