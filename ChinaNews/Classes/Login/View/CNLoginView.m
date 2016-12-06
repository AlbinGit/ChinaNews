//
//  CNLoginView.m
//  ChinaNews
//
//  Created by LYB on 16/12/6.
//  Copyright © 2016年 Liufangfang. All rights reserved.
//

#import "CNLoginView.h"
#import "UIView+PLLayout.h"
#import "CNOtherLoginCollectionViewCell.h"
#import "UIButton+EnlargeTouchArea.h"

#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define deepGray RGBColor(214, 214, 214)
#define lightGray RGBColor(242, 242, 242)

@interface CNLoginView()

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, strong) UITextField *passwordField;

@end

@implementation CNLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createIU];
    }
    return self;
}

- (void)createIU
{
    self.backgroundColor = [UIColor whiteColor];
    self.userInteractionEnabled = YES;
    [self createTextField];
    __weak typeof(self)wSelf = self;
    //点击键盘Next
    [self setReturnKeyNextBlock:^{
        [wSelf.passwordField becomeFirstResponder];
    }];
    //点击键盘Done
    [self setReturnKeyDoneBlock:^{
        //登录
        if (wSelf.loginBlock) {
            wSelf.loginBlock(wSelf.account,wSelf.password);
        }
    }];
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.frame = CGRectMake(20, _textFieldMaxY + 15, CN_SCREEN_WIDTH - 40, 40);
    _loginBtn.backgroundColor = deepGray;
    [_loginBtn setTitle:@"Sign in" forState:UIControlStateNormal];
    _loginBtn.layer.cornerRadius = 5.0;
    _loginBtn.enabled = NO;
    [_loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginBtn];
    
    UILabel *forgotPasswordLabel = [[UILabel alloc]initWithFrame:CGRectMake(CN_SCREEN_WIDTH - 150, _loginBtn.maxY+10, 130, 30)];
    forgotPasswordLabel.userInteractionEnabled = YES;
    forgotPasswordLabel.font = CN_FONTTSIZE(14.);
    forgotPasswordLabel.textAlignment = NSTextAlignmentRight;
    forgotPasswordLabel.text = @"Forgot Password";
    forgotPasswordLabel.textColor = deepGray;
    [self addSubview:forgotPasswordLabel];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(forgotPassword)];
    [forgotPasswordLabel addGestureRecognizer:tap];
    [self createOtherLoginView];
}

- (void)forgotPassword
{
    if (_forgotPasswordBlock) {
        _forgotPasswordBlock(_account);
    }
}

- (void)createTextField
{
    //    NSArray *signImgArray = @[];
    NSArray *placeholderArray = @[@"Email address",@"Password"];
    NSArray *typeArray = @[@(UIReturnKeyNext),@(UIReturnKeyDone)];
    for (NSInteger i = 0; i < 2; i++)
    {
        //图片
        UIImageView *signImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20 + _textFieldMaxY, 20, 15)];
        signImageView.backgroundColor = [UIColor redColor];
        [self addSubview:signImageView];
        //输入框
        UITextField *textField = [self createInputFieldWithFrame:CGRectMake(signImageView.maxX + 10, signImageView.minY - 4, CN_SCREEN_WIDTH - 100, 25) placeholder:placeholderArray[i] returnKeyType:[typeArray[i] integerValue] secureTextEntry:i];
        textField.tag = i + 1;
        
        if (i > 0)
        {
            _passwordField = textField;
            //按钮
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(CN_SCREEN_WIDTH - 40, signImageView.minY, 20, 20);
            btn.backgroundColor = [UIColor blackColor];
            [btn addTarget:self action:@selector(showPassword:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [btn setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
        }
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:textField];
       
       
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, textField.maxY + 5, CN_SCREEN_WIDTH - 20, 1)];
        line.backgroundColor = lightGray;
        [self addSubview:line];
        NSInteger height;
        if (i==0) {
            height = line.maxY;
        }
        _textFieldMaxY += height;
    }
}

- (UITextField *)createInputFieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder returnKeyType:(UIReturnKeyType)returnKeyType secureTextEntry:(BOOL)secureTextEntry
{
    UITextField * inputTextField = [[UITextField alloc] initWithFrame:frame];
    inputTextField.textColor = [UIColor blackColor];
//    inputTextField.backgroundColor = [UIColor yellowColor];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7) {
        inputTextField.tintColor = [UIColor blackColor];//光标颜色
    }
//    inputTextField.borderStyle = UITextBorderStyleRoundedRect;
    inputTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    inputTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    inputTextField.keyboardType = UIKeyboardTypeDefault;
    inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    inputTextField.autoresizesSubviews = YES;
    inputTextField.adjustsFontSizeToFitWidth = YES;
    inputTextField.returnKeyType = returnKeyType;
    inputTextField.delegate = self;
    inputTextField.secureTextEntry = secureTextEntry;
//    inputTextField.font = [UIFont systemFontOfSize:20];
//    inputTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor], NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    
    return inputTextField;
}

- (void)showPassword:(UIButton *)btn
{
    UITextField *passwordTextField = (UITextField *)[self viewWithTag:2];
    NSLog(@"-->eay");
    if (!btn.selected)
    {
        btn.backgroundColor = [UIColor redColor];
        passwordTextField.secureTextEntry = NO;
        btn.selected = YES;
    }
    else
    {
        btn.backgroundColor = [UIColor blackColor];
        passwordTextField.secureTextEntry = YES;
        btn.selected = NO;
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{
    UITextField *accountTextField = (UITextField *)[self viewWithTag:1];
    _account = accountTextField.text;
    UITextField *passwordTextField = (UITextField *)[self viewWithTag:2];
    _password = passwordTextField.text;
    if (accountTextField.text.length > 0 && passwordTextField.text.length > 0)
    {
        _loginBtn.enabled = YES;
        _loginBtn.backgroundColor = [CNColor getMainColorWithAlpha:1.];
    }
    else{
        _loginBtn.enabled = NO;
        _loginBtn.backgroundColor = deepGray;
    }
}



- (void)login:(UIButton *)btn
{
    if (_loginBlock) {
        _loginBlock(_account,_password);
    }
}


/**
 三方登录View
 */
- (void)createOtherLoginView
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _loginBtn.maxY + 50, CN_SCREEN_WIDTH, CN_SCREEN_HEIGHT - _loginBtn.maxY - 50 - 30 - 64)];
    view.backgroundColor = lightGray;
    view.tag = 110;
    [self addSubview:view];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, CN_SCREEN_WIDTH - 20, 20)];
    titleLabel.text = @"Log in with other accounts";
    titleLabel.font = CN_FONTTSIZE(14.);
    titleLabel.textColor = deepGray;
    [view addSubview:titleLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((CN_SCREEN_WIDTH - 200) / 2, view.height - 50, 200, 30);
    [btn setTitle:@"click here to registered" forState:UIControlStateNormal];
    btn.titleLabel.font = CN_FONTTSIZE(14.);
    [btn setTitleColor:deepGray forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(registered) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowlayout.minimumLineSpacing = (CN_SCREEN_WIDTH - 70*4) / 3;
    flowlayout.minimumInteritemSpacing = 0;
    flowlayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowlayout.itemSize = CGSizeMake(70, 70);
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, CN_SCREEN_WIDTH, view.height - 100) collectionViewLayout:flowlayout];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[CNOtherLoginCollectionViewCell class] forCellWithReuseIdentifier:@"otherLogin"];
    [view addSubview:_collectionView];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CNOtherLoginCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"otherLogin" forIndexPath:indexPath];
    if (cell) {
        cell.imgView.backgroundColor = deepGray;
    }
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_otherLoginBlock) {
        _otherLoginBlock(indexPath.row);
    }
}


- (void)registered
{
    if (_registeredBlock) {
        _registeredBlock();
    }
}



@end
