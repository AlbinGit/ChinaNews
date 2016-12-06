//
//  CNColor.h
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/21.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kAppMainColor @"395899"

@interface CNColor : UIColor

/**
 *  @brief 根据色值返回
 *  
 *  @param hexColor 十六进制色值
 *  @param aAlpha 透明度
 *
 *  @return 对应的UIColor对象
 *
 **/
+ (UIColor *)getColor:(NSString *)hexColor andAlpha:(CGFloat)aAlpha;

/**
 *  @brief 根据工程主色值返回
 *
 *  @param aAlpha  透明度
 *  
 *  @return 工程主颜色（）
 *
 **/
+ (UIColor *)getMainColorWithAlpha:(CGFloat)aAlpha;

@end
