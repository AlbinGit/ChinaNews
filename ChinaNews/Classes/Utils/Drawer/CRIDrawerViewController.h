//
//  CNDrawerViewController.h
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/21.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNViewController.h"

@interface CRIDrawerViewController : CNViewController

/**
 *  @brief  快速获得抽屉控制器
 *
 *  @return shareDrawerVC
 *
 **/
+ (instancetype)shareDrawerVC;

/**
 *  @brief 快速创建抽屉控制器
 *
 *  @param mainVC   主控制器
 *  @param leftVC   左边控制器
 *  @param leftMaxWidth  左边控制器的最大宽度
 *  @return 抽屉控制器
 *
 **/
+ (instancetype)drawerVCWithMainVC:(UIViewController *)mainVC leftVC:(UIViewController *)leftVC leftVCMaxWidth:(CGFloat)leftMaxWidth;

/**
 *  @brief 打开左边控制器
 *
 **/
- (void)openLeftVC;

/**
 *  @brief 切换控制器
 *
 *  @param targetVC     目标控制器
 *
 **/
- (void)switchToTargetVC:(UIViewController *)targetVC;

/**
 *  @brief 回到主界面
 *
 **/
- (void)backToHomeVC;

@end
