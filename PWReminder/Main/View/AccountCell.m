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
    UIView  *_bgView;
    
//    UIImageView     *_iconImageView;
    
    UILabel *_nameLabel;
    UILabel *_accountLabel;
    UITextField *_passwordTextField;
    
    UIButton    *_lockBtn;
}
@property (nonatomic, strong)AccountModel *accountModel;

@end

@implementation AccountCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self addViews];
    [self createUI];
    return self;
}

- (void)addViews
{
    _bgView = [[UIView alloc] init];
    _bgView.layer.cornerRadius = 2.0f;
    _bgView.backgroundColor = UIColorFromHex(0x7B68EE);
    
//    _iconImageView = [[UIImageView alloc] init];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    _nameLabel.textColor = [UIColor whiteColor];
    
    _accountLabel = [[UILabel alloc] init];
    _accountLabel.font = [UIFont systemFontOfSize:16.0f];
    _accountLabel.textColor = [UIColor whiteColor];
    _accountLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    
    _passwordTextField = [[UITextField alloc] init];
    _passwordTextField.secureTextEntry = YES;
    _passwordTextField.enabled = NO;
    _passwordTextField.font = [UIFont systemFontOfSize:16.0f];
    _passwordTextField.textColor = [UIColor whiteColor];
    
    _lockBtn = [[UIButton alloc] init];
    [_lockBtn setImage:[UIImage imageNamed:@"lock"] forState:UIControlStateNormal];
    [_lockBtn addTarget:self action:@selector(lockBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _lockBtn.selected = NO;
    
    
    [self addSubview:_bgView];
//    [_bgView addSubview:_iconImageView];
    [_bgView addSubview:_nameLabel];
    [_bgView addSubview:_passwordTextField];
    [_bgView addSubview:_accountLabel];
    [_bgView addSubview:_lockBtn];
}

- (void)createUI
{
    [_bgView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10.0f);
        make.right.equalTo(self).offset(-10.0f);
        make.top.equalTo(self).offset(2.0f);
        make.bottom.equalTo(self).offset(-2.0f);
    }];
    
//    [_iconImageView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(10.0f);
//        make.left.equalTo(_bgView).offset(10.0f);
//        make.size.equalTo(CGSizeMake(40.0f, 40.0f));
//    }];
    
    [_nameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgView).offset(8.0f);
        make.left.equalTo(_bgView).offset(10.0f);
        make.right.equalTo(_lockBtn.left).offset(-6.0f);
    }];
    
    [_accountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.bottom).offset(8.0f);
        make.left.equalTo(_nameLabel);
        make.right.equalTo(_bgView.centerX).offset(-16.0f);
    }];

    [_passwordTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgView.centerX).offset(-10.0f);
        make.right.equalTo(_lockBtn.left).offset(-6.0f);
        make.top.equalTo(_accountLabel);
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
    
    _nameLabel.text = accountModel.name;
    _passwordTextField.text = accountModel.password;
    _accountLabel.text = accountModel.account;
    
    switch (accountModel.accountModelType) {
        case AccountModelTypeSocialNetwork: {
            _bgView.backgroundColor = UIColorFromHex(0x7B68EE);
//            _iconImageView.image = [[UIImage imageNamed:@"socialNetwork"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            break;
        }
        case AccountModelTypeWeb: {
            _bgView.backgroundColor = UIColorFromHex(0x6A5ACD);
//            _iconImageView.image = [[UIImage imageNamed:@"web"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            break;
        }
        case AccountModelTypeBankCard: {
            _bgView.backgroundColor = UIColorFromHex(0x483D8B);
//            _iconImageView.image = [[UIImage imageNamed:@"bankcard"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            NSRange range = NSMakeRange(_accountModel.account.length - 4, 4);
            _accountLabel.text = [_accountModel.account substringWithRange:range];
            break;
        }
        case AccountModelTypeOther: {
            _bgView.backgroundColor = UIColorFromHex(0x191970);
//            _iconImageView.image = [[UIImage imageNamed:@"other"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            break;
        }
    }
}

- (void)lockBtnClick:(UIButton *)button
{
    button.selected = !button.selected;
    if (button.selected)
    {
        _passwordTextField.secureTextEntry = NO;
        [button setImage:[UIImage imageNamed:@"unlock"] forState:UIControlStateNormal];
    }
    else
    {
        _passwordTextField.secureTextEntry = YES;
        [button setImage:[UIImage imageNamed:@"lock"] forState:UIControlStateNormal];
    }
}


@end
