//
//  CNDrawerViewController.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/21.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CRIDrawerViewController.h"

@interface CRIDrawerViewController ()

//记录当前正在显示的VC
@property (nonatomic, strong) UIViewController *currentVC;
//遮盖按钮
@property (nonatomic, strong) UIButton *coverBtn;
//跨方法访问的 要记录一下属性
//主控制器
@property (nonatomic, strong) UIViewController *mainVC;
//左边控制器
@property (nonatomic, strong) UIViewController *leftVC;
//记录左边菜单控制器最大显示范围
@property (nonatomic, assign) CGFloat leftMaxWidth;

@end

@implementation CRIDrawerViewController

#pragma mark - Create ViewController

+ (instancetype)shareDrawerVC{
    
    return (CRIDrawerViewController *)[UIApplication sharedApplication].keyWindow.rootViewController;
}

+ (instancetype)drawerVCWithMainVC:(UIViewController *)mainVC leftVC:(UIViewController *)leftVC leftVCMaxWidth:(CGFloat)leftMaxWidth{
    
    CRIDrawerViewController *drawerVC = [[CRIDrawerViewController alloc] init];
    drawerVC.mainVC = mainVC;
    drawerVC.leftVC = leftVC;
    drawerVC.leftMaxWidth = leftMaxWidth;
    
    [drawerVC.view addSubview:leftVC.view];
    [drawerVC.view addSubview:mainVC.view];
    
    //苹果官方规定 如果“两个控制器的view”互为父子关系，这“两个控制器”与也必须互为父子关系
    [drawerVC addChildViewController:leftVC];
    [drawerVC addChildViewController:mainVC];
    
    return drawerVC;
}

#pragma mark - View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //默认左边的控制器的view向左偏移leftMaxWidth
    _leftVC.view.transform = CGAffineTransformMakeTranslation(-_leftMaxWidth, 0);
    //给主控制器设置阴影效果
    _mainVC.view.layer.shadowOffset = CGSizeMake(-3., -3.);
    _mainVC.view.layer.shadowOpacity = 1;
    _mainVC.view.layer.shadowRadius = 5.;
    _mainVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    //给tabbar的所有子控制器添加一个边缘拖拽手势
    //当主控制器内有多个子控制器时，比如tabbar
    for (UIViewController *childVC in self.mainVC.childViewControllers) {
        [self addScreenEdgePanGestureRecognizerToView:childVC.view];
    }
    
    //主控制器就一个子控制器时
    [self addScreenEdgePanGestureRecognizerToView:_mainVC.view];
    //监听外部关闭左侧VC事件，TODO: 使用本类方法实现该功能，优先级：低
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeLeftButton) name:@"CloseLeftVCNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Invoke Method

- (void)addScreenEdgePanGestureRecognizerToView:(UIView *)view{

    //创建边缘拖拽对象
    UIScreenEdgePanGestureRecognizer *pan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGestureRecognizer:)];
    //设置手势方向，触发左边缘时才起作用
    pan.edges = UIRectEdgeLeft;
    [view addGestureRecognizer:pan];
}

- (void)edgePanGestureRecognizer:(UIScreenEdgePanGestureRecognizer *)pan{

    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    //获得x方向拖拽的距离
    CGFloat offsetX = [pan translationInView:pan.view].x;
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        //当拖拽结束时或拖拽取消时，判断主控制器的view的x值有没有达到屏幕的一半
        if (_mainVC.view.frame.origin.x > screenWidth / 2) {
            
            [self openLeftVC];
        } else {
        
            [self closeLeftButton];
        }
    } else if(pan.state == UIGestureRecognizerStateChanged){
    
        _mainVC.view.transform = CGAffineTransformMakeTranslation(offsetX, 0);
        _leftVC.view.transform = CGAffineTransformMakeTranslation(offsetX - _leftMaxWidth, 0);
    }
}

- (void)closeLeftButton{

    [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        //清空并还原view的transform
        _mainVC.view.transform = CGAffineTransformIdentity;
        _leftVC.view.transform = CGAffineTransformMakeTranslation(-_leftMaxWidth, 0);
    } completion:^(BOOL finished) {
        //去除右边主控制器view上的遮盖按钮
        [self.coverBtn removeFromSuperview];
        self.coverBtn = nil;
    }];
}


#pragma mark - 懒加载遮盖按钮

- (UIButton *)coverBtn{
    
    if (_coverBtn == nil) {
        _coverBtn = [[UIButton alloc] init];
        _coverBtn.backgroundColor = [UIColor blackColor];
        _coverBtn.alpha = 0.3;
        _coverBtn.frame = _mainVC.view.bounds;
        [_coverBtn addTarget:self action:@selector(closeLeftButton) forControlEvents:UIControlEventTouchUpInside];
        //创建一个拖拽手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCoverBtn:)];
        [_coverBtn addGestureRecognizer:pan];
        
    }
    return _coverBtn;
}

- (void)panCoverBtn:(UIPanGestureRecognizer *)pan{
    
    //获得x方向拖拽的距离
    CGFloat offsetX = [pan translationInView:pan.view].x;
    if(offsetX > 0) return;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat distance = _leftMaxWidth - ABS(offsetX);//减去绝对值
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        //当拖拽结束或取消时，判断主控制器的view的x值有没有达到屏幕的一半
        if (_mainVC.view.frame.origin.x > screenWidth / 2) {
            
            [self openLeftVC];
        } else {
            
            [self closeLeftButton];
        }
    } else if(pan.state == UIGestureRecognizerStateChanged){
        //当拖拽时使mainVC的view的x的值随着往x方向拖拽的距离的改变而变化
        _mainVC.view.transform = CGAffineTransformMakeTranslation(MAX(0, distance), 0);     //一定要是平移效果，可以自试，几个属性的界面效果反差很大
        _leftVC.view.transform = CGAffineTransformMakeTranslation(offsetX, 0);
    }
}

#pragma mark - Public Invoke Method

- (void)openLeftVC{
    
    [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _mainVC.view.transform = CGAffineTransformMakeTranslation(_leftMaxWidth, 0);
        //重置动画
        _leftVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        //在滑道右边的mainVC上添加一个遮盖按钮（TODO：本工程需要添加一个遮布）
        [_mainVC.view addSubview:self.coverBtn];
    }];
}

- (void)switchToTargetVC:(UIViewController *)targetVC{
    
    targetVC.view.frame = _mainVC.view.bounds;
    targetVC.view.transform = _mainVC.view.transform;
    
    [self.view addSubview:targetVC.view];
    [self addChildViewController:targetVC];
    
    [self closeLeftButton];
    _currentVC = targetVC;
    
    //让控制器回到最初的状体
    [UIView animateWithDuration:.25 animations:^{
        targetVC.view.transform = CGAffineTransformIdentity;
    }];
}

- (void)backToHomeVC{
    
    //让控制器回到最初状态
    [UIView animateWithDuration:.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        _currentVC.view.transform = CGAffineTransformMakeTranslation(self.view.frame.size.width, 0);
    } completion:^(BOOL finished) {
        [_currentVC removeFromParentViewController];
        [_currentVC.view removeFromSuperview];
        _currentVC = nil;
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
