//
//  SettingView.m
//  PWReminder
//
//  Created by LeoSteve on 2017/7/21.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import "SettingView.h"
#import "PublicHeader.h"

@interface SettingView ()
{
    UITextField     *_passwordTextField;
    
    UIButton        *_lockBtn;
    UIButton        *_comfirmBtn;
    UIButton        *_uploadBtn;
    UIButton        *_downloadBtn;
    
    UIImageView     *_imageView;
}

@end
@implementation SettingView
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addViews];
        [self createUI];
    }
    return self;
}

- (void)addViews
{
    
    _lockBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20.0f, 20.0f)];
    [_lockBtn setImage:[[UIImage imageNamed:@"lock"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [_lockBtn addTarget:self action:@selector(securityLockClick:) forControlEvents:UIControlEventTouchUpInside];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20.0f, 20.0f)];
    _lockBtn.selected = NO;
    
    _passwordTextField = [[UITextField alloc] init];
    _passwordTextField.layer.cornerRadius = 8.0f;
    _passwordTextField.backgroundColor = [UIColor lightGrayColor];
    _passwordTextField.font = [UIFont systemFontOfSize:14.0f];
    _passwordTextField.textColor = [UIColor whiteColor];
    _passwordTextField.backgroundColor = UIColorFromHex(0x272727);
//    _passwordTextField.backgroundColor = [UIColor cyanColor];
//    _passwordTextField.background = [UIImage imageNamed:@"pw_input"];
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.textAlignment = NSTextAlignmentCenter;
    _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入密码" attributes:@{NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    
    
    [_passwordTextField setLeftView:leftView];
    [_passwordTextField setRightView:_lockBtn];
    [_passwordTextField setLeftViewMode:UITextFieldViewModeAlways];
    [_passwordTextField setRightViewMode:UITextFieldViewModeAlways];
    
    _comfirmBtn = [self createButtonWithTitle:@"修改登录密码" andTag:1];
    _uploadBtn = [self createButtonWithTitle:@"同步到 iCloud" andTag:2];
    _downloadBtn = [self createButtonWithTitle:@"从 iCloud 更新" andTag:3];
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bunny"]];
    
    [self addSubview:_passwordTextField];
    [self addSubview:_comfirmBtn];
    [self addSubview:_uploadBtn];
    [self addSubview:_downloadBtn];
    [self addSubview:_imageView];
    
}

- (void)createUI
{
    [_passwordTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(84.0f);
        make.left.equalTo(self).offset(40.0f);
        make.right.equalTo(self).offset(-40.0f);
        make.height.equalTo(44);
    }];
    
    [_comfirmBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_passwordTextField.bottom).offset(20.0f);
        make.left.right.height.equalTo(_passwordTextField);
    }];
    
    [_imageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(36.0f);
        make.size.equalTo(CGSizeMake(100.0f, 100.0f));
    }];
    
    [_uploadBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_downloadBtn.top).offset(-20.0f);
        make.left.right.height.equalTo(_passwordTextField);
    }];
    
    [_downloadBtn makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-30.0f);
        make.left.right.height.equalTo(_passwordTextField);
    }];
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

- (UIButton *)createButtonWithTitle:(NSString *)title andTag:(NSInteger )tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromHex(0xf5f5f5) forState:UIControlStateNormal];
    button.backgroundColor = UIColorFromHex(0xE14F0C);
    button.layer.cornerRadius = 8.0f;
    button.layer.masksToBounds = YES;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (NSString *)getTheNewPassword
{
    return _passwordTextField.text;
}

- (void)buttonClick:(UIButton *)button
{
    [_passwordTextField resignFirstResponder];
    switch (button.tag)
    {
        case 1:
            if ([_delegate respondsToSelector:@selector(didClickComfirmButton)])
            {
                [_delegate didClickComfirmButton];
            }
            break;
        case 2:
            if ([_delegate respondsToSelector:@selector(didClickUploadButton)])
            {
                [_delegate didClickUploadButton];
            }
            break;
            
        case 3:
            if ([_delegate respondsToSelector:@selector(didClickDownloadBtn)])
            {
                [_delegate didClickDownloadBtn];
            }
            break;
        default:
            break;
    }
}

@end
