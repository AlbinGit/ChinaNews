//
//  CRISegmentViewController.m
//  ChinaNews
//
//  Created by Liufangfang on 2016/11/22.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CRISegmentViewController.h"

typedef void(^indexBlock) (NSInteger index);

@interface CRISegmentViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) CGFloat selectedLineHeight;  //当前被选中的按钮下方线的高度
@property (nonatomic, assign) NSTimeInterval duration;     //滑动时间
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat segmentHeight;        //头部segmentView的高度
@property (nonatomic, assign) CGFloat buttonSpace;          //按钮title到边的间距
@property (nonatomic, assign) CGFloat minItemSpace;         //最小Item之间的间距
@property (nonatomic, copy) indexBlock resultBlock;
@property (nonatomic, strong) NSMutableArray *widthArray;   //存放按钮宽度的数组

@property (nonatomic, strong) UIScrollView *containerView;
@property (nonatomic, strong) UIButton *selectedButton;     //当前被选中的按钮
@property (nonatomic, strong) UIView *selectedLine;         //当前被选中的按钮下方线

@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *normalColor;         //标题未被选中时的颜色

@end

@implementation CRISegmentViewController

#pragma mark - Init Method

+ (instancetype)segmentControllerWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles{

    return [[self alloc] initWithFrame:frame titles:titles];
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles{

    if (self = [super init]) {
        
        _titles = titles;
        _size = frame.size;
        self.view.frame = frame;
        
        [self segmentBasicSet];
        [self segmentPagesSet];
        [self containerViewSet];
    }
    return self;
}

#pragma mark - Config Segment

- (void)segmentBasicSet{

    self.view.backgroundColor = [UIColor clearColor];
    _widthArray = [NSMutableArray array];
    _segmentHeight = 44.*CN_HEIGHT_BASE;
    _minItemSpace = 20.*CN_HEIGHT_BASE;
    _segmentTintColor = [CNColor getMainColorWithAlpha:1.];
    _normalColor = [CNColor getColor:@"0f0f0f" andAlpha:1.];
    _font = [UIFont systemFontOfSize:19.*CN_HEIGHT_BASE];
    _buttonSpace = [self calculateSpace];
    _selectedLineHeight = 3.5*CN_HEIGHT_BASE;
    _duration = .0; //TODO: 如果设置为大于0时，当需求为启动定位在非第一个界面，则应用启动时会有一个从第一个界面滚动到该界面的动画效果，体验不好。但设置为0，则点击滚动的动画则无。
}

- (void)segmentPagesSet{

    _segmentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _size.width, _segmentHeight)];
    _segmentView.backgroundColor = [UIColor whiteColor];
    _segmentView.showsVerticalScrollIndicator = NO;
    _segmentView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_segmentView];
    
    _selectedLine = [[UIView alloc] init];
    _selectedLine.backgroundColor = _segmentTintColor;
    
    CGFloat item_X = 0;
    for (int i=0; i<_titles.count; i++) {
        
        NSString *title = _titles[i];
        CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName: _font}];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(item_X, 0, _buttonSpace*2 + titleSize.width, _segmentHeight);
        [button setTag:i];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:_normalColor forState:UIControlStateNormal];
        [button setTitleColor:_segmentTintColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(clickedButton:) forControlEvents:UIControlEventTouchUpInside];
        [_segmentView addSubview:button];
        
        [_widthArray addObject:[NSNumber numberWithDouble:CGRectGetWidth(button.frame)]];
        item_X += _buttonSpace*2 + titleSize.width;
        
        if (0 == i) {
            
            button.selected = YES;
            _selectedButton = button;
            //添加底部线
            _selectedLine.frame = CGRectMake(_buttonSpace, _segmentHeight - _selectedLineHeight, titleSize.width, _selectedLineHeight);
            [_segmentView addSubview:_selectedLine];
            
        }
    }
    self.segmentView.contentSize = CGSizeMake(item_X, _segmentHeight);
}

- (void)containerViewSet{

    _containerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _segmentHeight, _size.width, _size.height - _segmentHeight)];
    _containerView.backgroundColor = [UIColor whiteColor];
    _containerView.showsVerticalScrollIndicator = NO;
    _containerView.showsHorizontalScrollIndicator = NO;
    _containerView.delegate = self;
    _containerView.pagingEnabled = YES;
    _containerView.bounces = NO;
    [self.view addSubview:_containerView];
}

#pragma mark - Private Invoke Method

- (CGFloat)calculateSpace {
    
    CGFloat space = 0.;
    CGFloat totalWidth = 0.;
    
    for (NSString *title in _titles) {
        
        CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName : _font}];
        totalWidth += titleSize.width;
    }
    
    space = (_size.width - totalWidth) / _titles.count / 2;
    
    if (space > _minItemSpace/2) {
        return space;
    } else {
    
        return _minItemSpace/2;
    }
}

- (CGFloat)widthAtIndex:(NSInteger)index{
    
    if (index < 0 || index > _titles.count -1) {
        return .0;
    }
    return [[_widthArray objectAtIndex:index] doubleValue];
}

#pragma mark - Button Action

- (void)clickedButton:(UIButton *)button{

    if (button != _selectedButton) {
        
        button.selected = YES;
        _selectedButton.selected = !_selectedButton.selected;
        _selectedButton = button;
     
        [self scrollSelectedButton];
        [self scrollSegementView];
    }
    
    if (_resultBlock) {
        _resultBlock(_selectedButton.tag);
    }
}

//根据选中的按钮滑动指示杆
- (void)scrollSelectedButton{

    NSInteger index = [self selectedAtIndex];
    CGSize titleSize = [_selectedButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: _font}];
    [UIView animateWithDuration:_duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        if (_style == CRISegmentStyleDefault) {
            
            _selectedLine.frame = CGRectMake(CGRectGetMinX(_selectedButton.frame) + _buttonSpace, CGRectGetMinY(_selectedLine.frame), titleSize.width, _selectedLineHeight);
        } else {
        
            _selectedLine.frame = CGRectMake(CGRectGetMinX(_selectedButton.frame), CGRectGetMinY(_selectedLine.frame), [self widthAtIndex:index], _selectedLineHeight);
        }
        
        [_containerView setContentOffset:CGPointMake(index * _size.width, 0)];
        
    } completion:^(BOOL finished) {
        
    }];
}

//根据选中调整segementView的offset
- (void)scrollSegementView{

    CGFloat selectedWidth = _selectedButton.frame.size.width;
    CGFloat offsetX = (_size.width - selectedWidth) / 2;
    
    if (_selectedButton.frame.origin.x < _size.width/2) {
        [_segmentView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if(CGRectGetMaxX(_selectedButton.frame) >= (_segmentView.contentSize.width - _size.width/2)) {
        [_segmentView setContentOffset:CGPointMake(_segmentView.contentSize.width - _size.width, 0) animated:YES];
    } else {
        [_segmentView setContentOffset:CGPointMake(CGRectGetMinX(_selectedButton.frame) - offsetX, 0) animated:YES];
    }
}

#pragma mark - Public Invoke Method

- (NSInteger)selectedAtIndex{

    return _selectedButton.tag;
}

- (void)selectedAtIndex:(void (^)(NSInteger))indexBlock{

    if (indexBlock) {
        
        _resultBlock = indexBlock;
        _resultBlock([self selectedAtIndex]);
    }
}

- (void)setSelectedItemAtIndex:(NSInteger)index{

    for (UIView *view in _segmentView.subviews) {
        
        if ([view isKindOfClass:[UIButton class]] && view.tag == index) {
            
            UIButton *button = (UIButton *)view;
            [self clickedButton:button];
        }
    }
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    NSInteger index = round(scrollView.contentOffset.x / _size.width);
    [self setSelectedItemAtIndex:index];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger currentIndex = [self selectedAtIndex];
    
    //当当前的偏移量大于被选中index的偏移量的时候，就是在右侧
    CGFloat offset; //在同一侧的偏移量
    NSInteger buttonIndex = currentIndex;
    
    if (offsetX >= [self selectedAtIndex] * _size.width) {
        
        offset = offsetX - [self selectedAtIndex] * _size.width;
        buttonIndex += 1; //+= 中间不能空格
    } else {
    
        offset = [self selectedAtIndex] * _size.width - offsetX;
        buttonIndex -= 1;
        currentIndex -= 1;
    }
    
    CGFloat originMovedX = _style == CRISegmentStyleDefault ? (CGRectGetMinX(_selectedButton.frame) + _buttonSpace) : CGRectGetMinX(_selectedButton.frame);
    CGFloat targetMovedWidth = [self widthAtIndex:currentIndex]; //需要移动的距离
    
    CGFloat targetButtonWidth = _style == CRISegmentStyleDefault? ([self widthAtIndex:buttonIndex] - 2 * _buttonSpace) : [self widthAtIndex:buttonIndex]; // 这个会影响width
    CGFloat originButtonWidth = _style == CRISegmentStyleDefault? ([self widthAtIndex:[self selectedAtIndex]] - 2 * _buttonSpace) : [self widthAtIndex:[self selectedAtIndex]];
    
    
    CGFloat moved; // 移动的距离
    moved = offsetX - [self selectedAtIndex] * _size.width;
    _selectedLine.frame = CGRectMake(originMovedX + targetMovedWidth / _size.width * moved, _selectedLine.frame.origin.y,  originButtonWidth + (targetButtonWidth - originButtonWidth) / _size.width * offset, _selectedLine.frame.size.height);
}

#pragma mark - Set Method

- (void)setSegementTintColor:(UIColor *)segementTintColor {
    
    _segmentTintColor = segementTintColor;
    _selectedLine.backgroundColor = segementTintColor;
    for (UIView *view in _segmentView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            [button setTitleColor:segementTintColor forState:UIControlStateSelected];
        }
    }
}

- (void)setSegmentViewControllers:(NSArray *)viewControllers {
    [self setViewControllers:viewControllers];
}

- (void)setViewControllers:(NSArray *)viewControllers {
    
    _viewControllers = viewControllers;
    _containerView.contentSize = CGSizeMake(viewControllers.count * _size.width, _size.height - _segmentHeight);
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *viewController = viewControllers[i];
        viewController.view.frame = CGRectOffset(_containerView.bounds, i * _size.width, 0);
        [_containerView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }
}

- (void)setStyle:(CRISegmentStyle)style {
    
    _style = style;
    
    if (style == CRISegmentStyleDefault) {
        
    } else {
        _selectedLine.frame = CGRectMake(_selectedButton.frame.origin.x, _segmentHeight - _selectedLineHeight, [self widthAtIndex:0], _selectedLineHeight);
    }
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
