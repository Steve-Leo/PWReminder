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

@interface AddOrModView ()<UITextFieldDelegate, UITextViewDelegate>
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
    UITextField *_passwordTextField;
    
    UITextView  *_remarkTextView;
    
    UIImageView *_imageView;
}
@property (nonatomic, strong)AccountModel *accountModel;

@end

@implementation AddOrModView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
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
    _accountTypeBtn.layer.cornerRadius = 8.0f;
    [_accountTypeBtn setBackgroundColor:UIColorFromHex(0x272727)];
    [_accountTypeBtn setTitleColor:UIColorFromHex(0x808080) forState:UIControlStateNormal];
    _accountTypeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_accountTypeBtn setTitle:@"点击选择账户类型" forState:UIControlStateNormal];
    [_accountTypeBtn addTarget:self action:@selector(accountTypeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _accountNameTextField = [self createTextFieldWithPlaceholder:@"请输入名称"];
    _accountNameTextField.tag = 1;
    _accountTextField = [self createTextFieldWithPlaceholder:@"请输入账号"];
    _accountTextField.tag = 2;
    
    _lockBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20.0f, 20.0f)];
    [_lockBtn setImage:[[UIImage imageNamed:@"lock"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [_lockBtn addTarget:self action:@selector(securityLockClick:) forControlEvents:UIControlEventTouchUpInside];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20.0f, 20.0f)];
    
    _passwordTextField = [self createTextFieldWithPlaceholder:@"请输入密码"];
    _passwordTextField.tag = 3;
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.rightView = _lockBtn;
    _passwordTextField.leftView = leftView;
    [_passwordTextField setRightViewMode:UITextFieldViewModeAlways];
    [_passwordTextField setLeftViewMode:UITextFieldViewModeAlways];

    _passwordTextField.selected = NO;
    
    _remarkTextView = [[UITextView alloc] init];
    _remarkTextView.delegate = self;
    _remarkTextView.font = [UIFont systemFontOfSize:14.0f];
    _remarkTextView.textColor = [UIColor whiteColor];
    _remarkTextView.layer.cornerRadius = 8.0f;
    _remarkTextView.backgroundColor = UIColorFromHex(0x272727);
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rabbit"]];
    [self addSubview: _bgScrollView];
    
    [_bgScrollView addSubview:_accountTypeTitleLabel];
    [_bgScrollView addSubview:_accountNameTitleLabel];
    [_bgScrollView addSubview:_accountTitleLabel];
    [_bgScrollView addSubview:_passwordTitleLabel];
    [_bgScrollView addSubview:_remarkTitleLabel];
    
    [_bgScrollView addSubview:_accountTypeBtn];
    [_bgScrollView addSubview:_accountNameTextField];
    [_bgScrollView addSubview:_accountTextField];
    [_bgScrollView addSubview:_passwordTextField];
    [_bgScrollView addSubview:_remarkTextView];
    [_bgScrollView addSubview:_imageView];
    
}

- (void)createUI
{
    [_bgScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [_accountTypeTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30.0f);
        make.top.equalTo(_bgScrollView).offset(50.0f);
        make.size.equalTo(CGSizeMake(72.0f, 44.0f));
    }];
    
    [_accountNameTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(_accountTypeTitleLabel);
        make.top.equalTo(_accountTypeTitleLabel.bottom).offset(16.0f);
    }];
    
    [_accountTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(_accountTypeTitleLabel);
        make.top.equalTo(_accountNameTitleLabel.bottom).offset(16.0f);
    }];
    
    [_passwordTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(_accountTitleLabel);
        make.top.equalTo(_accountTitleLabel.bottom).offset(16.0f);
    }];
    
    [_remarkTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(_accountTitleLabel);
        make.top.equalTo(_passwordTitleLabel.bottom).offset(16.0f);
    }];
    
    
    [_accountTypeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_accountTypeTitleLabel);
        make.left.equalTo(_accountTypeTitleLabel.right).offset(10.0f);
        make.right.equalTo(self).offset(-30.0f);
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
    
    [_passwordTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_accountTypeBtn);
        make.centerY.equalTo(_passwordTitleLabel);
    }];
    
    [_remarkTextView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_accountTypeBtn);
        make.top.equalTo(_remarkTitleLabel);
        make.height.equalTo(100.0f);
    }];
    
    [_imageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_remarkTextView.bottom).offset(36.0f);
        make.centerX.equalTo(self);
        make.size.equalTo(CGSizeMake(100.0f, 100.0f));
    }];
    
    [_bgScrollView updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_imageView).offset(10);
    }];
}

- (UILabel *)createLabelWithString:(NSString *)string
{
    UILabel *label = [[UILabel alloc] init];
    label.text = string;
    label.textColor = UIColorFromHex(0xFF5A0F);
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:16.0f];
    return label;
}

- (UITextField *)createTextFieldWithPlaceholder:(NSString *)placeholder
{
    UITextField *textField = [[UITextField alloc] init];
    textField.font = [UIFont systemFontOfSize:14.0f];
    textField.textColor = [UIColor whiteColor];
    NSAttributedString *arrtPlaceHolder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:UIColorFromHex(0x808080)}];
    textField.attributedPlaceholder = arrtPlaceHolder;
    textField.backgroundColor = UIColorFromHex(0x272727);
    textField.layer.cornerRadius = 8.0f;
    textField.textAlignment = NSTextAlignmentCenter;
    textField.delegate = self;
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
        _passwordTextField.secureTextEntry = YES;
        [button setImage:[[UIImage imageNamed:@"lock"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    }
    else
    {
        _passwordTextField.secureTextEntry = NO;
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
    _passwordTextField.text = _accountModel.password;
    _remarkTextView.text = _accountModel.remark;
    [self setAcountTypeTitle];
}

- (void)setAcountTypeTitle
{
    if (_accountModel.accountModelType == 0)
    {
        return;
    }
    [_accountTypeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _accountTextField.keyboardType  = UIKeyboardTypeAlphabet;
    _passwordTextField.keyboardType = UIKeyboardTypeAlphabet;
    switch (_accountModel.accountModelType)
    {
        case AccountModelTypeSocialNetwork: {
            [_accountTypeBtn setTitle:@"社交网络" forState:UIControlStateNormal];
            break;
        }
        case AccountModelTypeWeb: {
            [_accountTypeBtn setTitle:@"网站与应用" forState:UIControlStateNormal];
            break;
        }
        case AccountModelTypeBankCard: {
            [_accountTypeBtn setTitle:@"银行卡号" forState:UIControlStateNormal];
            _passwordTextField.keyboardType = UIKeyboardTypeNumberPad;
            _accountTextField.keyboardType  = UIKeyboardTypeNumberPad;
            break;
        }
        case AccountModelTypeOther: {
            [_accountTypeBtn setTitle:@"其他账号" forState:UIControlStateNormal];
            break;
        }
    }

}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag)
    {
        case 1:
            self.accountModel.name = _accountNameTextField.text;
            break;
        case 2:
            self.accountModel.account = _accountTextField.text;
            break;
        case 3:
            self.accountModel.password = _passwordTextField.text;
            break;
            
        default:
            break;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    switch (textField.tag)
    {
        case 1:
            self.accountModel.name = _accountNameTextField.text;
            break;
        case 2:
            self.accountModel.account = _accountTextField.text;
            break;
        case 3:
            self.accountModel.password = _passwordTextField.text;
            break;
            
        default:
            break;
    }
    return YES;
}
#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.accountModel.remark = textView.text;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    self.accountModel.remark = textView.text;
    return YES;
}
@end
