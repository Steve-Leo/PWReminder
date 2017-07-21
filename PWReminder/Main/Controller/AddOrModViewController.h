//
//  AddViewController.h
//  PWReminder
//
//  Created by LeoSteve on 2017/7/19.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import "BaseViewController.h"
@class AccountModel;
@interface AddOrModViewController : BaseViewController
- (instancetype)initWithAccountModel:(AccountModel *)model;
- (void)saveData;
@end
