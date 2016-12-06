//
//  CRIRegisterProgressView.m
//  RegisterProgressTest
//
//  Created by Liufangfang on 2016/11/25.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CRIRegisterProgressView.h"

#define kGreen [UIColor colorWithRed:110/255.0 green:152/255.0 blue:114/255.0 alpha:1.0]
#define kGray [UIColor colorWithRed:85/255.0 green:85/255.0 blue:85/255.0 alpha:1.0]
#define kLineGray [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0]

static CGFloat const topMargin      = 10.f;
static CGFloat const leftMargin     = 10.0f;
static CGFloat const rightMargin    = 10.0f;
//static CGFloat const baseMargin     = 10.0f;

@interface CRIRegisterProgressView ()

@property (nonatomic, assign) NSInteger titleCount;    //记录title数组的个数

@end

@implementation CRIRegisterProgressView

- (void)showProgressViewWithTitles:(NSArray *)titles whenProcess:(CRIRegisterProcessType)type{

    _titleCount = titles.count;
    
    [self showHorizontalProgressViewWithTitles:titles whenProcess:(CRIRegisterProcessType)type];
}

- (void)showHorizontalProgressViewWithTitles:(NSArray *)titles whenProcess:(CRIRegisterProcessType)type{

    CGFloat singleWidth = self.bounds.size.width / _titleCount;
    CGFloat singleHeight = self.bounds.size.height - topMargin;
    CGFloat y = 0.;
    
    NSString *singleTitle = @""; //TODO:能否赋值为nil
    
    for (int i=0; i<_titleCount; i++) {
        
        CGFloat x = i * singleWidth;
        CGRect frame = CGRectMake(x, y, singleWidth, singleHeight);
        
        if (titles[i]) {
            singleTitle = titles[i];
        }
        
        bool isFirst = i == 0 ? YES : NO;
        bool isEnd = i == _titleCount-1 ? YES : NO;
        
        [self singleViewWithFrame:frame title:singleTitle isFirst:isFirst isEnd:isEnd type:type];
    }
}

- (void)singleViewWithFrame:(CGRect)frame title:(NSString *)title isFirst:(BOOL)isFirst isEnd:(BOOL)isEnd type:(CRIRegisterProcessType)type{

    self.backgroundColor = [UIColor whiteColor];
    
    UIView *singleView = [[UIView alloc] initWithFrame:frame];
    //图标
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15., 15.)];
    //标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:14.];
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    //线
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor grayColor];
    
    switch (type) {
            
        case kCRIRegisterProcessEnterEmailType:
            
            if (isFirst) {
                //第一个
                iconView.image = [UIImage imageNamed:@"blue"];
                titleLabel.textColor = [UIColor grayColor];
                line.backgroundColor = [UIColor greenColor];
            } else {
                //第二个和第三个
                iconView.image = [UIImage imageNamed:@"red"];
                titleLabel.textColor = [UIColor lightGrayColor];
                line.backgroundColor = [UIColor lightGrayColor];
            }
            break;
            
        case kCRIRegisterProcessValidationCodeType:
            
            if (isFirst) {
                //第一个
                iconView.image = [UIImage imageNamed:@"blue"];
                titleLabel.textColor = [UIColor lightGrayColor];
                line.backgroundColor = [UIColor greenColor];
            } else if(isEnd){
                //第三个
                iconView.image = [UIImage imageNamed:@"red"];
                titleLabel.textColor = [UIColor lightGrayColor];
                line.backgroundColor = [UIColor lightGrayColor];
            } else {
                //第二个
                iconView.image = [UIImage imageNamed:@"blue"];
                titleLabel.textColor = [UIColor grayColor];
                line.backgroundColor = [UIColor greenColor];
            }
            break;
            
        case kCRIRegisterProcessSetPasswordType:
            //文字颜色单独处理
            if (isEnd) {
                //第三个
                titleLabel.textColor = [UIColor grayColor];
            } else {
                //第一个、第二个
                titleLabel.textColor = [UIColor lightGrayColor];
            }
            iconView.image = [UIImage imageNamed:@"blue"];
            line.backgroundColor = [UIColor greenColor];
            break;
            
        default:
            break;
    }
    
    //设置控件位置
    iconView.center = CGPointMake(frame.size.width * .5, 10);
    
    CGSize titleSize = [self string:title sizeWithFont:[UIFont systemFontOfSize:14.] MaxSize:CGSizeMake(frame.size.width - leftMargin - rightMargin, frame.size.height * .3)];
    titleLabel.frame = CGRectMake((frame.size.width - titleSize.width) * .5, 28., titleSize.width, titleSize.height);
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:12.];
    
    if (isFirst) {
        line.frame = CGRectMake(iconView.center.x, iconView.center.y - 1, frame.size.width * 0.5, 2);
    } else if (isEnd){
        line.frame = CGRectMake(0, iconView.center.y - 1, frame.size.width * 0.5, 2);
    } else {
        line.frame = CGRectMake(0, iconView.center.y - 1, frame.size.width, 2);
    }
    
    [singleView addSubview:iconView];
    [singleView addSubview:titleLabel];
    [singleView addSubview:line];
    
    [self addSubview:singleView];
    
    [singleView bringSubviewToFront:iconView];
}

- (CGSize)string:(NSString *)str sizeWithFont:(UIFont *)font MaxSize:(CGSize)maxSize{
    
    CGSize resultSize;
    NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGRect rect = [str boundingRectWithSize:maxSize
                                    options:(NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading)
                                 attributes:attrs
                                    context:nil];
    resultSize = rect.size;
    resultSize = CGSizeMake(ceil(resultSize.width), ceil(resultSize.height));
    
    return resultSize;
}

@end
