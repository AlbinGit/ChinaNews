//
//  CRIMenuDragViewController.m
//  MenuDrag
//
//  Created by Liufangfang on 2016/12/2.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CRITouchView.h"
#import "CRIMenuUnitModel.h"
#import "CRIMenuDragViewController.h"

//左右边距
#define EdgeX 5
#define TopEdge 30

//每行频道的个数
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define ButtonCountOneRow 1
#define LocationWidth (ScreenWidth - EdgeX * 2)
#define ButtonWidth (LocationWidth / ButtonCountOneRow)
#define ButtonHeight (ButtonWidth * ButtonCountOneRow / 9)

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface CRIMenuDragViewController ()
{
    BOOL _isEditing;
    CGPoint _oldCenter;
    NSInteger _moveIndex;
}

@property (nonatomic, strong) NSMutableArray<CRIMenuUnitModel *> *topDataSource;
@property (nonatomic, strong) NSMutableArray<CRITouchView *> *topViewArr;
@property (nonatomic, assign) CGFloat topHeight;

@property (strong, nonatomic) UIScrollView *scrollView;
//@property (nonatomic, strong) UIButton *editButton;

@property (nonatomic, strong) CRITouchView *clearView;
@property (nonatomic, strong) CRIMenuUnitModel *placeHolderModel;
@property (nonatomic, strong) CRIMenuUnitModel *touchingModel;

@property (nonatomic, strong) CRIMenuUnitModel *initialIndexModel;
@property (nonatomic, strong) CRITouchView *initalTouchView;
@property (nonatomic, assign) NSInteger locationIndex;

@end

@implementation CRIMenuDragViewController

-(id)initWithTopDataSource:(NSArray<CRIMenuUnitModel *> *)topDataArr  andInitialIndex:(NSInteger)initialIndex{
    if (self = [super init]) {
        self.topDataSource = [NSMutableArray arrayWithArray:topDataArr];
        self.locationIndex = initialIndex;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self configUI];
}

-(void)configUI{
    
    self.topViewArr = [NSMutableArray array];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 150, ScreenWidth, ScreenHeight - 150)];
    [self.view addSubview:_scrollView];
    self.scrollView.backgroundColor = [UIColor orangeColor];
    
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
    [self.view addSubview:closeBtn];
    closeBtn.backgroundColor = [UIColor cyanColor];
    [closeBtn addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
//    _editButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 60, 30)];
//    [self.view addSubview:_editButton];
//    _editButton.backgroundColor = [UIColor whiteColor];
//    [self.editButton setBackgroundImage:[UIImage imageNamed:@"reorder"] forState:UIControlStateNormal];
//    [self.editButton setBackgroundImage:[UIImage imageNamed:@"reorder-1"] forState:UIControlStateHighlighted];
//    [self.editButton addTarget:self action:@selector(editOrderAct:) forControlEvents:UIControlEventTouchUpInside];
    
    for (int i = 0; i < self.topDataSource.count; ++i) {
        CRITouchView *touchView = [[CRITouchView alloc] initWithFrame:CGRectMake(5 + i%ButtonCountOneRow * ButtonWidth, TopEdge + i/ButtonCountOneRow * ButtonHeight, ButtonWidth, ButtonHeight)];
        touchView.userInteractionEnabled = YES;
        
        CRIMenuUnitModel *model = self.topDataSource[i];
        touchView.contentLabel.text = model.name;
        if (i < 3) {
            touchView.contentLabel.textColor = [UIColor lightGrayColor];
        } else {
        
            touchView.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTapAct:)];
            [touchView addGestureRecognizer:touchView.longPress];
        }
        
        [self.scrollView addSubview:touchView];
        [self.topViewArr addObject:touchView];
    }
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, 85 + self.topHeight);
}

#pragma mark - Tap Methods

- (void)closeButtonAction:(UIButton *)button{

    [self dismissViewControllerAnimated:YES completion:nil];
}

//点击编辑或者完成按钮
//-(void)editOrderAct:(UIButton *)button{
//    _isEditing = !_isEditing;
//    [self inOrOutEditWithEditing:_isEditing];
//    if (!_isEditing) { //点击完成
//    }
//}

-(void)longTapAct:(UILongPressGestureRecognizer *)longPress{
    
    CRITouchView *touchView = (CRITouchView *)longPress.view;
    [self.scrollView bringSubviewToFront:touchView];
    static CGPoint touchPoint;
    static CGFloat offsetX;
    static CGFloat offsetY;
    static NSInteger staticIndex = 0;
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        
        _isEditing = YES;
        [touchView inOrOutTouching:YES];
        [self inOrOutEditWithEditing:_isEditing];
        //记录移动的label最初的index
        _moveIndex = [self.topViewArr indexOfObject:touchView];
        if (_moveIndex < self.topDataSource.count) {
            self.touchingModel = self.topDataSource[_moveIndex];
        }
        [self.topViewArr removeObject:touchView];
        if (self.touchingModel) {
            [self.topDataSource removeObject:self.touchingModel];
            [self.topDataSource addObject:self.placeHolderModel];
        }
        _oldCenter = touchView.center;
        
        //这是为了计算手指在Label上的偏移位置
        touchPoint = [longPress locationInView:touchView];
        CGPoint centerPoint = CGPointMake(ButtonWidth/2, ButtonHeight/2);
        offsetX = touchPoint.x - centerPoint.x;
        offsetY = touchPoint.y - centerPoint.y;
        
        CGPoint movePoint = [longPress locationInView:self.scrollView];
        [UIView animateWithDuration:0.1 animations:^{
            touchView.center = CGPointMake(movePoint.x - offsetX, movePoint.y - offsetY);
        }];
        
    }else if(longPress.state == UIGestureRecognizerStateChanged){
        
        CGPoint movePoint = [longPress locationInView:self.scrollView];
        touchView.center = CGPointMake(movePoint.x - offsetX, movePoint.y - offsetY);
        
        CGFloat x = touchView.center.x;
        CGFloat y = touchView.center.y;
        //没有超出范围
        if (!(x < EdgeX || x > ScreenWidth - EdgeX || y < TopEdge || y > TopEdge + self.topHeight || (y < (TopEdge + 3 * ButtonHeight + 2 * EdgeX) && x < (EdgeX + 2 * ButtonWidth)))) {
            //记录移动过程中label所处的index
            int index = ((int)((y - TopEdge)/ButtonHeight)) * ButtonCountOneRow + (int)(x - EdgeX)/ButtonWidth;
            
            //当index发生改变时, 插入占位的label, 重新布局UI
            if (staticIndex != index) {
                staticIndex = index;
                if (staticIndex < self.topViewArr.count && staticIndex >= 0) {
                    if ([self.topViewArr containsObject:self.clearView]) {
                        [self.topViewArr removeObject:self.clearView];
                    }
                    [self.topViewArr insertObject:self.clearView atIndex:staticIndex];
                    if (!self.clearView.superview) {
                        [self.scrollView addSubview:self.clearView];
                        [self.scrollView sendSubviewToBack:self.clearView];
                    }
                    self.clearView.frame = CGRectMake(EdgeX + staticIndex%ButtonCountOneRow * ButtonWidth, TopEdge + staticIndex/ButtonCountOneRow*ButtonHeight, ButtonWidth, ButtonHeight);
                    [UIView animateWithDuration:0.5 animations:^{
                        [self reconfigTopView];
                    }];
                }else{
                    NSLog(@"计算index 超出范围");
                }
            }
        }
    }else if(longPress.state == UIGestureRecognizerStateEnded){
        
        [touchView inOrOutTouching:NO];
        CGFloat x = touchView.center.x;
        CGFloat y = touchView.center.y;
        
        if (x < EdgeX || x > ScreenWidth - EdgeX || y < TopEdge || y > TopEdge + self.topHeight || (y < (TopEdge + 3 * ButtonHeight + 2 * EdgeX) && x < (EdgeX + 2 * ButtonWidth))) {
            NSLog(@"长按手势结束: 超出范围");
            [UIView animateWithDuration:0.5 animations:^{
                touchView.center = _oldCenter;
            }];
            
        }else{
            _moveIndex = ((int)((y - TopEdge)/ButtonHeight)) * ButtonCountOneRow + (int)(x - EdgeX)/ButtonWidth;
        }
        
        staticIndex = 0;
        
        if ([self.topViewArr containsObject:self.clearView]) {
            [self.topViewArr removeObject:self.clearView];
            if (self.clearView.superview) {
                [self.clearView removeFromSuperview];
            }
        }
        
        if ([self.topDataSource containsObject:self.placeHolderModel]) {
            [self.topDataSource removeObject:self.placeHolderModel];
        }
        
        if (_moveIndex < self.topViewArr.count && _moveIndex >= 0) {
            
            [self.topViewArr insertObject:touchView atIndex:_moveIndex];
            if (_moveIndex < self.topDataSource.count && self.touchingModel) {
                [self.topDataSource insertObject:self.touchingModel atIndex:_moveIndex];
            }
            
        }else{
            
            [self.topViewArr addObject:touchView];
            if (self.touchingModel) {
                [self.topDataSource addObject:self.touchingModel];
            }
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            [self reconfigTopView];
        }];
    }
}

#pragma mark - Tap Invoke Methods
//进入或者退出编辑状态
-(void)inOrOutEditWithEditing:(BOOL)isEditing{
    if (isEditing) {
        //        [self.editButton setBackgroundImage:[UIImage imageNamed:@"finsh"] forState:UIControlStateNormal];
        //        [self.editButton setBackgroundImage:[UIImage imageNamed:@"finsh-1"] forState:UIControlStateHighlighted];
        
        if (self.initalTouchView) {
            if (self.locationIndex > 1) {
                self.initalTouchView.contentLabel.textColor = UIColorFromRGB(0X333333);
            }else{
                self.initalTouchView.contentLabel.textColor = UIColorFromRGB(0xc0c0c0);
            }
        }
        
        for (int i = 0; i < self.topViewArr.count; ++i) {
            CRITouchView *touchView = self.topViewArr[i];
            if (touchView.pan) {
                touchView.pan.enabled = YES;
                touchView.closeImageView.hidden = NO;
            }
        }
    }else{
        //        [self.editButton setBackgroundImage:[UIImage imageNamed:@"reorder"] forState:UIControlStateNormal];
        //        [self.editButton setBackgroundImage:[UIImage imageNamed:@"reorder-1"] forState:UIControlStateHighlighted];
        
        if (self.initalTouchView && self.initialIndexModel.isTop) {
            self.initalTouchView.contentLabel.textColor = UIColorFromRGB(0x008dff);
        }
        for (int i = 0; i < self.topViewArr.count; ++i) {
            CRITouchView *touchView = self.topViewArr[i];
            if (touchView.pan) {
                touchView.pan.enabled = NO;
                touchView.closeImageView.hidden = YES;
            }
        }
    }
}

//重新布局上边
-(void)reconfigTopView{
    for (int i = 0; i < self.topViewArr.count; ++i) {
        CRITouchView *touchView = self.topViewArr[i];
        touchView.frame = CGRectMake(EdgeX + i%ButtonCountOneRow * ButtonWidth, TopEdge + i/ButtonCountOneRow*ButtonHeight, ButtonWidth, ButtonHeight);
    }
}

#pragma mark - Property Getter Methods
//用于占位的透明label
-(CRITouchView *)clearView{
    if (!_clearView) {
        _clearView = [[CRITouchView alloc] init];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, ButtonWidth - 10, ButtonHeight - 10)];
        imageView.image = [UIImage imageNamed:@"lanmu2"];
        [_clearView addSubview:imageView];
        _clearView.backgroundColor = [UIColor clearColor];
        [_clearView.contentLabel removeFromSuperview];
    }
    return _clearView;
}
//用于占位的model, 由于计算位置有问题
-(CRIMenuUnitModel *)placeHolderModel{
    if (!_placeHolderModel) {
        _placeHolderModel = [[CRIMenuUnitModel alloc] init];
    }
    return _placeHolderModel;
}
//充当计算属性使用
-(CGFloat)topHeight{
    if (self.topDataSource.count < ButtonCountOneRow) {
        return ButtonHeight;
    }else{
        return ((self.topDataSource.count - 1)/ButtonCountOneRow + 1) * ButtonHeight;
    }
}

@end
