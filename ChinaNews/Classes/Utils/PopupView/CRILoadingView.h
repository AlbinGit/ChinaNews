//
//  CRILoadingView.h
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/30.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRILoadingView : UIView{

    UIView *loadingView;
    UIActivityIndicatorView *indicatorView;
    UILabel *titleLabel;
    UIImageView *animationImageView;
}

+ (id)shareInstance;
- (void)addLoadingViewForView:(UIView *)view withTitle:(NSString *)title;
- (void)removeLoadingView;

@end
