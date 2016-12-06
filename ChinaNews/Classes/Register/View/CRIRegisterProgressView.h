//
//  CRIRegisterProgressView.h
//  RegisterProgressTest
//
//  Created by Liufangfang on 2016/11/25.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CRIRegisterProcessType) {

    kCRIRegisterProcessEnterEmailType,
    kCRIRegisterProcessValidationCodeType,
    kCRIRegisterProcessSetPasswordType
};

@interface CRIRegisterProgressView : UIView

@property (nonatomic, assign) CRIRegisterProcessType processType;

- (void)showProgressViewWithTitles:(NSArray *)titles whenProcess:(CRIRegisterProcessType)type;

@end
