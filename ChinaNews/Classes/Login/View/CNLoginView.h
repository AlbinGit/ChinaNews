//
//  CNLoginView.h
//  ChinaNews
//
//  Created by LYB on 16/12/6.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CNReturnKeyboardView.h"

/**
 登录回调

 @param account  账号
 @param password 密码
 */
typedef void(^CNLoginViewLogin) (NSString *account,NSString *password);
/**
 忘记密码回调

 @param account 账号
 */
typedef void(^CNLoginViewForgotPassword) (NSString *account);
/**
 三方登录回调

 @param index itemIndex
 */
typedef void(^CNLoginViewOtherLogin) (NSInteger index);
/**
 注册回调
 */
typedef void(^CNLoginViewRegistered) ();

@interface CNLoginView :CNReturnKeyboardView <UITextFieldDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) UIButton *loginBtn;//登录按钮

@property (nonatomic, assign) CGFloat textFieldMaxY;//密码输入框的MaxY
@property (nonatomic, strong) UICollectionView *collectionView;//三方登录

@property (nonatomic, copy) CNLoginViewLogin loginBlock;
@property (nonatomic, copy) CNLoginViewForgotPassword forgotPasswordBlock;
@property (nonatomic, copy) CNLoginViewOtherLogin otherLoginBlock;
@property (nonatomic, copy) CNLoginViewRegistered registeredBlock;


@end
