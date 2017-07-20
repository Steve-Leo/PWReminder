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
    
    UILabel *_titleLabel;
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
    
    _titleLabel = [[UILabel alloc] init];
    _passwordTextField = [[UITextField alloc] init];
    _passwordTextField.enabled = NO;
    
    _lockBtn = [[UIButton alloc] init];
    
    [self addSubview:_iconImageView];
    [self addSubview:_titleLabel];
    [self addSubview:_passwordTextField];
    [self addSubview:_lockBtn];
}

- (void)createUI
{
    [_iconImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20.0f);
        make.left.equalTo(self).offset(20.0f);
        make.size.equalTo(CGSizeMake(40.0f, 30.0f));
    }];
    
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_iconImageView);
        make.left.equalTo(_iconImageView.right).offset(20.0f);
    }];
    
    [_passwordTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.bottom).offset(16.0f);
    }];
    
    [_lockBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(20.0f);
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
    
    _titleLabel.text = accountModel.name;
    _passwordTextField.text = accountModel.password;
}

@end
