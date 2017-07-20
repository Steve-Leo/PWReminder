//
//  AddOrModView.m
//  PWReminder
//
//  Created by LeoSteve on 2017/7/19.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import "AddOrModView.h"
#import "PublicHeader.h"

@interface AddOrModView ()
{
    UIScrollView *_bgScrollView;
    
    UILabel *_accountTypeTitleLabel;
    UILabel *_accountTitleLabel;
    UILabel *_passwordTitleLabel;
    UILabel *_remarkTitleLabel;
    
    UIButton    *_accountTypeBtn;
    UIButton    *_lockBtn;
    
    UITextField *_accountTextField;
    UITextField *_passwordTextFiled;
    
    UITextView  *_remarkTextView;
}

@end

@implementation AddOrModView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        [self addViews];
        [self createUI];
    }
    return self;
}

- (void)addViews
{
    _bgScrollView = [[UIScrollView alloc] init];
    [_bgScrollView setShowsVerticalScrollIndicator:NO];
    
    _accountTypeTitleLabel = [self createLabelWithString:@"账户类型"];
    _accountTitleLabel     = [self createLabelWithString:@"账        号"];
    _passwordTitleLabel    = [self createLabelWithString:@"密        码"];
    _remarkTitleLabel      = [self createLabelWithString:@"备        注"];
    
    _accountTypeBtn = [[UIButton alloc] init];
    [_accountTypeBtn setTitle:@"点击选择账户类型" forState:UIControlStateNormal];
    [_accountTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_accountTypeBtn addTarget:self action:@selector(accountTypeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _accountTextField = [[UITextField alloc] init];
    _accountTextField.font = [UIFont systemFontOfSize:18.0f];
    _accountTextField.placeholder = @"请输入账号";
    _accountTextField.textAlignment = NSTextAlignmentCenter;
    
    _lockBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20.0f, 20.0f)];
    [_lockBtn setImage:[[UIImage imageNamed:@"lock"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [_lockBtn addTarget:self action:@selector(securityLockClick:) forControlEvents:UIControlEventTouchUpInside];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20.0f, 20.0f)];
    
    _passwordTextFiled = [[UITextField alloc] init];
    _passwordTextFiled.secureTextEntry = YES;
    _passwordTextFiled.font = [UIFont systemFontOfSize:18.0f];
    _passwordTextFiled.placeholder = @"请输入密码";
    _passwordTextFiled.textAlignment = NSTextAlignmentCenter;
    _passwordTextFiled.rightView = _lockBtn;
    _passwordTextFiled.leftView = leftView;
    [_passwordTextFiled setRightViewMode:UITextFieldViewModeAlways];
    [_passwordTextFiled setLeftViewMode:UITextFieldViewModeAlways];

    _passwordTextFiled.selected = NO;
    
    _remarkTextView = [[UITextView alloc] init];
    _remarkTextView.font = [UIFont systemFontOfSize:18.0f];
    
    [self addSubview: _bgScrollView];
    
    [_bgScrollView addSubview:_accountTypeTitleLabel];
    [_bgScrollView addSubview:_accountTitleLabel];
    [_bgScrollView addSubview:_passwordTitleLabel];
    [_bgScrollView addSubview:_remarkTitleLabel];
    
    [_bgScrollView addSubview:_accountTypeBtn];
    [_bgScrollView addSubview:_accountTextField];
    [_bgScrollView addSubview:_passwordTextFiled];
    [_bgScrollView addSubview:_remarkTextView];
    
}

- (void)createUI
{
    [_bgScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_accountTypeTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(36.0f);
        make.top.equalTo(_bgScrollView).offset(50.0f);
        make.size.equalTo(CGSizeMake(86.0f, 44.0f));
    }];
    
    [_accountTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(_accountTypeTitleLabel);
        make.top.equalTo(_accountTypeTitleLabel.bottom).offset(36.0f);
    }];
    
    [_passwordTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(_accountTitleLabel);
        make.top.equalTo(_accountTitleLabel.bottom).offset(36.0f);
    }];
    
    [_remarkTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(_accountTitleLabel);
        make.top.equalTo(_passwordTitleLabel.bottom).offset(36.0f);
    }];
    
    
    [_accountTypeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_accountTypeTitleLabel);
        make.left.equalTo(_accountTypeTitleLabel.right).offset(20.0f);
        make.right.equalTo(self).offset(-36.0f);
        make.height.equalTo(44.0f);
    }];
    
    [_accountTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_accountTypeBtn);
        make.centerY.equalTo(_accountTitleLabel);
    }];
    
    [_passwordTextFiled makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_accountTypeBtn);
        make.centerY.equalTo(_passwordTitleLabel);
    }];
    
    [_remarkTextView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_accountTypeBtn);
        make.top.equalTo(_remarkTitleLabel);
        make.height.equalTo(100.0f);
    }];
    
    [_bgScrollView updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_remarkTextView).offset(10);
    }];
}

- (UILabel *)createLabelWithString:(NSString *)string
{
    UILabel *label = [[UILabel alloc] init];
    label.text = string;
    
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor cyanColor];
    label.font = [UIFont systemFontOfSize:20.0f];
    return label;
}

- (void)accountTypeBtnClick
{
    if ([_delegate respondsToSelector:@selector(didClickAccountTypeBtn)])
    {
        [_delegate didClickAccountTypeBtn];
    }
}

- (void)securityLockClick:(UIButton *)button
{
    if (button.isSelected)
    {
        _passwordTextFiled.secureTextEntry = YES;
        [button setImage:[[UIImage imageNamed:@"lock"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }
    else
    {
        _passwordTextFiled.secureTextEntry = NO;
        [button setImage:[[UIImage imageNamed:@"unlock"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }
    button.selected = !button.isSelected;
}

@end
