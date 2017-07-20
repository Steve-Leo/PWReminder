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
    AccountModelTypeSocialNetwork,
    AccountModelTypeWeb,
    AccountModelTypeBankCard,
    AccountModelTypeOther,
};


@property (nonatomic, assign)AccountModelType accountModelType;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *password;
@property (nonatomic, strong)NSString *notes;
@property (nonatomic, strong)NSString *iconName;
@end
