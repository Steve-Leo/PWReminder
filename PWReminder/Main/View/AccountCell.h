//
//  AccountCell.h
//  PWReminder
//
//  Created by LeoSteve on 2017/7/19.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AccountModel;

@interface AccountCell : UITableViewCell
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier addAccountModel:(AccountModel *)model;
- (void)setAccountModel:(AccountModel *)accountModel;
@end
