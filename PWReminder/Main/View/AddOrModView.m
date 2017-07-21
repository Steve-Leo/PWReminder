//
//  AddOrModView.m
//  PWReminder
//
//  Created by LeoSteve on 2017/7/19.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import "AddOrModView.h"
#import "PublicHeader.h"
#import "AccountModel.h"

@interface AddOrModView ()
{
    UIScrollView *_bgScrollView;
    
    UILabel *_accountTypeTitleLabel;
    UILabel *_accountNameTitleLabel;
    UILabel *_accountTitleLabel;
    UILabel *_passwordTitleLabel;
    UILabel *_remarkTitleLabel;
    
    UIButton    *_accountTypeBtn;
    UIButton    *_lockBtn;
    
    UITextField *_accountNameTextField;
    UITextField *_accountTextField;
    UITextField *_passwordTextFiled;
    
    UITextView  *_remarkTextView;
}
@property (nonatomic, strong)AccountModel *accountModel;

@end

@implementation AddOrModView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        _accountModel = [[AccountModel alloc] init];
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
    _accountNameTitleLabel = [self createLabelWithString:@"名        称"];
    _accountTitleLabel     = [self createLabelWithString:@"账        号"];
    _passwordTitleLabel    = [self createLabelWithString:@"密        码"];
    _remarkTitleLabel      = [self createLabelWithString:@"备        注"];
    
    _accountTypeBtn = [[UIButton alloc] init];
    [_accountTypeBtn setTitle:@"点击选择账户类型" forState:UIControlStateNormal];
    [_accountTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_accountTypeBtn addTarget:self action:@selector(accountTypeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _accountNameTextField = [self createTextFieldWithPlaceholder:@"请输入名称"];
    _accountTextField = [self createTextFieldWithPlaceholder:@"请输入账号"];
    
    _lockBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20.0f, 20.0f)];
    [_lockBtn setImage:[[UIImage imageNamed:@"lock"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [_lockBtn addTarget:self action:@selector(securityLockClick:) forControlEvents:UIControlEventTouchUpInside];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20.0f, 20.0f)];
    
    _passwordTextFiled = [self createTextFieldWithPlaceholder:@"请输入密码"];
    _passwordTextFiled.secureTextEntry = YES;
    _passwordTextFiled.rightView = _lockBtn;
    _passwordTextFiled.leftView = leftView;
    [_passwordTextFiled setRightViewMode:UITextFieldViewModeAlways];
    [_passwordTextFiled setLeftViewMode:UITextFieldViewModeAlways];

    _passwordTextFiled.selected = NO;
    
    _remarkTextView = [[UITextView alloc] init];
    _remarkTextView.font = [UIFont systemFontOfSize:18.0f];
    
    [self addSubview: _bgScrollView];
    
    [_bgScrollView addSubview:_accountTypeTitleLabel];
    [_bgScrollView addSubview:_accountNameTitleLabel];
    [_bgScrollView addSubview:_accountTitleLabel];
    [_bgScrollView addSubview:_passwordTitleLabel];
    [_bgScrollView addSubview:_remarkTitleLabel];
    
    [_bgScrollView addSubview:_accountTypeBtn];
    [_bgScrollView addSubview:_accountNameTextField];
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
    
    [_accountNameTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(_accountTypeTitleLabel);
        make.top.equalTo(_accountTypeTitleLabel.bottom).offset(20.0f);
    }];
    
    [_accountTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(_accountTypeTitleLabel);
        make.top.equalTo(_accountNameTitleLabel.bottom).offset(20.0f);
    }];
    
    [_passwordTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(_accountTitleLabel);
        make.top.equalTo(_accountTitleLabel.bottom).offset(20.0f);
    }];
    
    [_remarkTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(_accountTitleLabel);
        make.top.equalTo(_passwordTitleLabel.bottom).offset(20.0f);
    }];
    
    
    [_accountTypeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_accountTypeTitleLabel);
        make.left.equalTo(_accountTypeTitleLabel.right).offset(20.0f);
        make.right.equalTo(self).offset(-36.0f);
        make.height.equalTo(44.0f);
    }];
    
    [_accountNameTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_accountTypeBtn);
        make.centerY.equalTo(_accountNameTitleLabel);
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

- (UITextField *)createTextFieldWithPlaceholder:(NSString *)placeholder
{
    UITextField *textField = [[UITextField alloc] init];
    textField.font = [UIFont systemFontOfSize:18.0f];
    textField.placeholder = placeholder;
    textField.textAlignment = NSTextAlignmentCenter;
    return textField;
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

#pragma mark- setter & getter

- (void)setAccountModel:(AccountModel *)accountModel
{
    if (accountModel == nil)
    {
        return;
    }
    _accountModel = accountModel;
    _accountNameTextField.text = accountModel.name;
    _accountTextField.text = _accountModel.account;
    _passwordTextFiled.text = _accountModel.password;
    _remarkTextView.text = _accountModel.remark;
    [self setAcountTypeTitle];
}

- (void)setAcountTypeTitle
{
    _passwordTextFiled.keyboardType = UIKeyboardTypeAlphabet;
    switch (_accountModel.accountModelType)
    {
        case AccountModelTypeSocialNetwork: {
            [_accountTypeBtn setTitle:@"社交网络" forState:UIControlStateNormal];
            break;
        }
        case AccountModelTypeWeb: {
            [_accountTypeBtn setTitle:@"网站论坛" forState:UIControlStateNormal];
            break;
        }
        case AccountModelTypeBankCard: {
            [_accountTypeBtn setTitle:@"银行卡号" forState:UIControlStateNormal];
            _passwordTextFiled.keyboardType = UIKeyboardTypeNumberPad;
            break;
        }
        case AccountModelTypeOther: {
            [_accountTypeBtn setTitle:@"其他账号" forState:UIControlStateNormal];
            break;
        }
    }

}

@end
