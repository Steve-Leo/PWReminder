//
//  AccountCell.m
//  PWReminder
//
//  Created by LeoSteve on 2017/7/19.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import "AccountCell.h"
#import "PublicHeader.h"
#import "AccountModel.h"


@interface AccountCell ()
{
    UIImageView     *_iconImageView;
    
    UILabel *_nameLabel;
    UILabel *_accountLabel;
    UITextField *_passwordTextField;
    
    UIButton    *_lockBtn;
}
@property (nonatomic, strong)AccountModel *accountModel;

@end

@implementation AccountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier addAccountModel:(AccountModel *)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self addViews];
    [self createUI];
    self.accountModel = model;
    return self;
}

- (void)addViews
{
    _iconImageView = [[UIImageView alloc] init];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    
    _accountLabel = [[UILabel alloc] init];
    _accountLabel.font = [UIFont systemFontOfSize:16.0f];
    
    _passwordTextField = [[UITextField alloc] init];
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.enabled = NO;
    _passwordTextField.font = [UIFont systemFontOfSize:16.0f];
    
    _lockBtn = [[UIButton alloc] init];
    [_lockBtn setImage:[[UIImage imageNamed:@"lock"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]forState:UIControlStateNormal];
    [_lockBtn addTarget:self action:@selector(lockBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _lockBtn.selected = NO;
    
    [self addSubview:_iconImageView];
    [self addSubview:_nameLabel];
    [self addSubview:_passwordTextField];
    [self addSubview:_accountLabel];
    [self addSubview:_lockBtn];
}

- (void)createUI
{
    [_iconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10.0f);
        make.left.equalTo(self).offset(10.0f);
        make.size.equalTo(CGSizeMake(40.0f, 30.0f));
    }];
    
    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImageView);
        make.left.equalTo(_iconImageView.right).offset(20.0f);
        make.right.equalTo(self.centerX);
    }];
    
    [_accountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel);
        make.left.equalTo(self.centerX).offset(10.0f);
        make.right.equalTo(_lockBtn.left).offset(15.0f);
    }];
    
    [_passwordTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.right.equalTo(self.centerX);
        make.top.equalTo(_nameLabel.bottom).offset(16.0f);
    }];
    
    [_lockBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-20.0f);
        make.size.equalTo(CGSizeMake(30.0f, 30.0f));
    }];
}

- (void)setAccountModel:(AccountModel *)accountModel
{
    _accountModel = accountModel;
    
    switch (accountModel.accountModelType) {
        case AccountModelTypeSocialNetwork: {
            _iconImageView.image = [[UIImage imageNamed:@"socialNetwork"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            break;
        }
        case AccountModelTypeWeb: {
            _iconImageView.image = [[UIImage imageNamed:@"web"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            break;
        }
        case AccountModelTypeBankCard: {
            _iconImageView.image = [[UIImage imageNamed:@"bankcard"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            break;
        }
        case AccountModelTypeOther: {
            _iconImageView.image = [[UIImage imageNamed:@"other"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            break;
        }
    }
    
    _nameLabel.text = accountModel.name;
    _passwordTextField.text = accountModel.password;
    _accountLabel.text = accountModel.account;
}

- (void)lockBtnClick:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected)
    {
        _passwordTextField.secureTextEntry = NO;
        [button setImage:[[UIImage imageNamed:@"unlock"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]forState:UIControlStateNormal];
    }
    else
    {
        _passwordTextField.secureTextEntry = YES;
        [button setImage:[[UIImage imageNamed:@"lock"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]forState:UIControlStateNormal];
    }
}


@end
