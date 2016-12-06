//
//  UIView+PLLayout.m
//  ToysOnline
//
//  Created by johnnyliu on 14-8-20.
//  Copyright (c) 2014年 yuwei. All rights reserved.
//

#import "UIView+PLLayout.h"

@implementation UIView (PLLayout)

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)minX
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)minY
{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)midX
{
    return CGRectGetMidX(self.frame);
}

- (CGFloat)midY
{
    return CGRectGetMidY(self.frame);
}

- (void)setX:(CGFloat)x
{
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (void)setY:(CGFloat)y
{
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}

- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)width
{
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (void)setHeight:(CGFloat)height;
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

- (void)setFrameCenterWithSuperView:(UIView *)superView size:(CGSize)size
{
    self.frame = CGRectMake((superView.width - size.width) / 2, (superView.height - size.height) / 2, size.width, size.height);
    [superView addSubview:self];
}

- (void)setFrameInBottomCenterWithSuperView:(UIView *)superView size:(CGSize)size
{
    self.frame = CGRectMake((superView.width - size.width) / 2, superView.height - size.height, size.width, size.height);
    [superView addSubview:self];
}



@end
