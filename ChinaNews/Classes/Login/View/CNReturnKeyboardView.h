//
//  CNReturnKeyboardView.h
//  ChinaNews
//
//  Created by LYB on 16/12/6.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^InputCommonBlock)();

@interface CNReturnKeyboardView : UIView<UITextFieldDelegate>

@property (nonatomic, copy) InputCommonBlock returnKeyNextBlock;
- (void)setReturnKeyNextBlock:(InputCommonBlock)returnKeyNextBlock;
@property (nonatomic, copy) InputCommonBlock returnKeyGoBlock;
- (void)setReturnKeyGoBlock:(InputCommonBlock)returnKeyGoBlock;
@property (nonatomic, copy) InputCommonBlock returnKeyDoneBlock;
- (void)setReturnKeyDoneBlock:(InputCommonBlock)returnKeyDoneBlock;
@property (nonatomic, copy) InputCommonBlock returnKeySearchBlock;
- (void)setReturnKeySearchBlock:(InputCommonBlock)returnKeySearchBlock;

@end
