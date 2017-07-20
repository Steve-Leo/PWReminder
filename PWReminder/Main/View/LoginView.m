//
//  PWInputView.m
//  PWReminder
//
//  Created by LeoSteve on 2017/7/17.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import "LoginView.h"
#import "PublicHeader.h"

@interface LoginView ()
{
    BOOL        _isRegister;
    UILabel     *_titleLabel;
    UILabel     *_reminderLabel;
    UITextField *_passwordTextField;
    
    UIButton    *_loginBtn;
    UIButton    *_fingerPrinterBtn;
}
@end

@implementation LoginView
- (instancetype)initWithRegisterState:(BOOL)registerState
{
    _isRegister = registerState;
    return [self init];
    
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"login_bg"].CGImage);
        self.backgroundColor = [UIColor whiteColor];
        self.tintColor = [UIColor whiteColor];
        [self addViews];
        [self createUI];
        [self addTap];
    }
    return self;
}

- (void)addViews
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:45.0f];
    if (_isRegister)
    {
        _titleLabel.text = @"Sign In";
    }
    else
    {
        _titleLabel.text = @"Sign Up";
    }
    
    _reminderLabel = [[UILabel alloc] init];
    _reminderLabel.backgroundColor = [UIColor clearColor];
    _reminderLabel.textColor = [UIColor whiteColor];
    _reminderLabel.font = [UIFont systemFontOfSize:15.0f];
    _reminderLabel.textAlignment = NSTextAlignmentCenter;
    _reminderLabel.text = @"你好，妞妞";
    
    _passwordTextField = [[UITextField alloc] init];
    _passwordTextField.font = [UIFont systemFontOfSize:13.0f];
    _passwordTextField.textColor = [UIColor whiteColor];
    _passwordTextField.backgroundColor = [UIColor clearColor];
    _passwordTextField.background = [UIImage imageNamed:@"pw_input"];
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.textAlignment = NSTextAlignmentCenter;
    _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    leftView.backgroundColor = [UIColor clearColor];
    rightView.backgroundColor = [UIColor clearColor];
    
    [_passwordTextField setLeftView:leftView];
    [_passwordTextField setRightView:rightView];
    [_passwordTextField setLeftViewMode:UITextFieldViewModeAlways];
    [_passwordTextField setRightViewMode:UITextFieldViewModeAlways];
    
    _loginBtn = [[UIButton alloc] init];
    [_loginBtn setBackgroundImage:[UIImage imageNamed:@"login_btn"] forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _fingerPrinterBtn = [[UIButton alloc] init];
    
    
    _fingerPrinterBtn = [[UIButton alloc] init];
    [_fingerPrinterBtn setBackgroundImage:[UIImage imageNamed:@"fingprinter"] forState:UIControlStateNormal];
    [_fingerPrinterBtn addTarget:self action:@selector(fingerPrinterBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_titleLabel];
    [self addSubview:_reminderLabel];
    [self addSubview:_passwordTextField];
    [self addSubview:_loginBtn];
    [self addSubview:_fingerPrinterBtn];
    
    if (_isRegister)
    {
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    }
    else
    {
        _fingerPrinterBtn.hidden = YES;
        [_loginBtn setTitle:@" 注册" forState:UIControlStateNormal];
    }
}

- (void)createUI
{
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(67.0f);
        make.centerX.equalTo(self);
        make.size.equalTo(CGSizeMake(160.0f, 60.0f));
    }];
    
    [_reminderLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(129.5f);
        make.left.equalTo(self).offset(37.5f);
        make.right.equalTo(self).offset(-37.5f);
        make.height.equalTo(24.5f);
    }];
    
    [_passwordTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(176.0f);
        make.left.right.equalTo(_reminderLabel);
        make.height.equalTo(44.0f);
        
    }];

    [_loginBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordTextField.bottom).offset(30.0f);
        make.left.right.height.equalTo(_passwordTextField);
    }];
    
    [_fingerPrinterBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_loginBtn.bottom).offset(60.0f);
        make.centerX.equalTo(_loginBtn);
        make.size.equalTo(CGSizeMake(100.0f, 100.0f));
    }];
}

- (void)loginBtnClick:(UIButton *)button
{
    [self returnKeyBoard];
    if ([_delegate respondsToSelector:@selector(didClickLoginBtn:)])
    {
        [_delegate didClickLoginBtn:_passwordTextField.text];
    }
}

- (void)fingerPrinterBtnClick:(UIButton *)button
{
    [self returnKeyBoard];
    if ([_delegate respondsToSelector:@selector(didClickFingerPrinterBtn)])
    {
        [_delegate didClickFingerPrinterBtn];
    }
}

- (void)addTap
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(returnKeyBoard)];
    [self addGestureRecognizer:tap];
}

- (void)returnKeyBoard
{
    [_passwordTextField resignFirstResponder];
}
@end
