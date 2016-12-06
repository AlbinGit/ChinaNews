//
//  CNReturnKeyboardView.m
//  ChinaNews
//
//  Created by LYB on 16/12/6.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNReturnKeyboardView.h"

@implementation CNReturnKeyboardView

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.returnKeyType == UIReturnKeyNext)
    {
        if (self.returnKeyNextBlock) {
            self.returnKeyNextBlock();
        }
    }
    else if (textField.returnKeyType == UIReturnKeyGo)
    {
        if (self.returnKeyGoBlock) {
            self.returnKeyGoBlock();
        }
    }
    else if (textField.returnKeyType == UIReturnKeySearch)
    {
        if (self.returnKeySearchBlock) {
            self.returnKeySearchBlock();
        }
    }
    else if (textField.returnKeyType == UIReturnKeyDone)
    {
        if (self.returnKeyDoneBlock) {
            self.returnKeyDoneBlock();
        }
    }
    return [textField resignFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"-->touchesBegan");
    UITouch *touch = [touches anyObject];
    if (![touch.view isKindOfClass:[UITextField class]])
    {
        [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
    }
}

@end
