//
//  DataManager.h
//  PWReminder
//
//  Created by LeoSteve on 2017/7/20.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonMacro.h"
@class AccountModel;
@interface DataManager : NSObject
SingletonH();

- (void)cleanPasswordTable;
- (void)deletePasswordTable;
- (void)insertDataWithAccountModel:(AccountModel *)accountModel;
- (void)deleteDataWithAccountModel:(AccountModel *)accountModel;
- (void)deleteDataWithAccountId:(NSInteger )accountId;
- (void)updateDataWithAccountModel:(AccountModel *)accountModel;
- (AccountModel *)queryDataModelWithAccountId:(NSInteger)accountId;
- (NSArray <NSArray *> *)queryAllData;
@end
