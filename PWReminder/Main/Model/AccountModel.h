//
//  AccountModel.h
//  PWReminder
//
//  Created by LeoSteve on 2017/7/19.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountModel : NSObject
typedef NS_ENUM(NSInteger, AccountModelType){
    AccountModelTypeSocialNetwork = 1,
    AccountModelTypeWeb,
    AccountModelTypeBankCard,
    AccountModelTypeOther,
};


@property (nonatomic, assign)NSInteger accountId;
@property (nonatomic, assign)AccountModelType accountModelType;
@property (nonatomic, strong)NSString *createTime;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *account;
@property (nonatomic, strong)NSString *password;
@property (nonatomic, strong)NSString *remark;
@property (nonatomic, strong)NSString *iconName;
@end
