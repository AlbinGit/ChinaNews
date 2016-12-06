//
//  UIView+PLLayout.h
//  ToysOnline
//
//  Created by johnnyliu on 14-8-20.
//  Copyright (c) 2014年 yuwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (PLLayout)

- (CGFloat)maxX;
- (CGFloat)maxY;
- (CGFloat)minX;
- (CGFloat)minY;
- (CGFloat)midX;
- (CGFloat)midY;

//- (CGFloat)X;
//- (CGFloat)Y;
- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;

- (CGFloat)height;
- (CGFloat)width;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;

- (void)setFrameCenterWithSuperView:(UIView *)superView size:(CGSize)size;
- (void)setFrameInBottomCenterWithSuperView:(UIView *)superView size:(CGSize)size;



@end
