//
//  CNColor.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/21.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNColor.h"

@implementation CNColor

+ (UIColor *)getColor:(NSString *)hexColor andAlpha:(CGFloat)aAlpha{

    if (nil == hexColor || 0 == hexColor.length) {
        
        NSLog(@"Color String is Nil.");
        return [UIColor blackColor];
    }
    
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    NSString *dexHexColor = [hexColor substringWithRange:range];
    [[NSScanner scannerWithString:dexHexColor] scanHexInt:&red];
    
    range.location = 2;
    dexHexColor = [hexColor substringWithRange:range];
    [[NSScanner scannerWithString:dexHexColor] scanHexInt:&green];
    
    range.location = 4;
    dexHexColor = [hexColor substringWithRange:range];
    [[NSScanner scannerWithString:dexHexColor] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.f) green:(float)(green/255.f) blue:(float)(blue/255.f) alpha:aAlpha];
}

+ (UIColor *)getMainColorWithAlpha:(CGFloat)aAlpha{

    return [CNColor getColor:kAppMainColor andAlpha:aAlpha];
}

@end
