//
//  CRIMenuDragViewController.h
//  MenuDrag
//
//  Created by Liufangfang on 2016/12/2.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRIMenuUnitModel.h"

@interface CRIMenuDragViewController : UIViewController

//编辑后, 删除初始选中项排序的回调
@property (nonatomic, copy) void(^removeInitialIndexBlock)(NSMutableArray<CRIMenuUnitModel *> *topArr);
//选中某一个频道回调
@property (nonatomic, copy) void(^chooseIndexBlock)(NSInteger index, NSMutableArray<CRIMenuUnitModel *> *topArr);

-(id)initWithTopDataSource:(NSArray<CRIMenuUnitModel *> *)topDataArr andInitialIndex:(NSInteger)initialIndex;

@end
