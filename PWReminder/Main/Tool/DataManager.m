//
//  DataManager.m
//  PWReminder
//
//  Created by LeoSteve on 2017/7/20.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import "DataManager.h"
#import <FMDB/FMDB.h>
#import "AccountModel.h"
#import "DataStoreTool.h"

@interface DataManager ()
@property (nonatomic, strong)FMDatabaseQueue *dbQueue;
@end

@implementation DataManager

static NSString *const kDBFileName      = @"PWReminder.db";// 数据库名
static NSString *const kPWTable         = @"PWTable";// 表名称

static NSString *const kAccountID       = @"accountID";// 账户名称
static NSString *const kAccountName     = @"accountName";// 账户名称
static NSString *const kAccount         = @"account";// 账户
static NSString *const kAccountPassword = @"accountPassword";// 账户密码
static NSString *const kAccountType     = @"accountType";// 账户类型
static NSString *const kAccountRemark   = @"accountRemark";// 账户类型

SingletonM();

- (NSString *)dbPath
{
    NSString *dirPath = [DataStoreTool getUserDataDir];
    NSLog(@"%@", dirPath);
    return [dirPath stringByAppendingPathComponent:kDBFileName];
}

#pragma mark - table(创建、删除、清空)
- (void)createAccountTable
{
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ ( \
                         %@ integer primary key not null, %@ text, %@ text, %@ integer, %@ text, %@ text)",
                         kPWTable, kAccountID, kAccountName, kAccount, kAccountType,kAccountPassword, kAccountRemark];
        [db executeUpdate:sql];
    }];
}

- (void)cleanPasswordTable
{
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"delete from %@", kPWTable];
        [db executeUpdate:sql];
    }];
}

- (void)deletePasswordTable
{
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"drop table %@", kPWTable];
        [db executeUpdate:sql];
    }];
}

#pragma mark - 增删改查
- (void)insertDataWithAccountModel:(AccountModel *)accountModel
{
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"insert or replace into %@ \
                         (%@, %@, %@, %@, %@, %@) values(?, ?, ?, ?, ?, ?)",
                         kPWTable, kAccountID, kAccountName, kAccount, kAccountType,kAccountPassword, kAccountRemark];
        NSArray *dataArray = @[@(accountModel.accountId),
                               accountModel.name ?: @"",
                               accountModel.account ?: @"",
                               @(accountModel.accountModelType),
                               accountModel.password ?: @"",
                               accountModel.remark ?:@""];
        [db executeUpdate:sql withArgumentsInArray:dataArray];
    }];
}

- (void)deleteDataWithAccountModel:(AccountModel *)accountModel
{
    [self deleteDataWithAccountId:accountModel.accountId];
}

- (void)deleteDataWithAccountId:(NSInteger )accountId
{
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@ = ?",
                         kPWTable,
                         kAccountID];
        NSArray *dataArray = @[@(accountId)];
        [db executeUpdate:sql withArgumentsInArray:dataArray];
    }];

}

- (void)updateDataWithAccountModel:(AccountModel *)accountModel
{
    [self insertDataWithAccountModel:accountModel];
}

- (AccountModel *)queryDataModelWithAccountId:(NSInteger)accountId
{
    NSString *where = [NSString stringWithFormat:@"%@ = %@", kAccountID, @(accountId)];
    NSArray<NSArray *> *result = [self queryAccountWithWhere:where];
    
    return [[result firstObject] firstObject];
}

- (NSArray <NSArray *> *)queryAllData
{
    return [self queryAccountWithWhere:nil];
}

- (NSArray *)queryAccountWithWhere:(NSString *)where
{
    NSMutableArray *accountArray = [NSMutableArray array];
    
    NSMutableArray *accountBankCardArray = [NSMutableArray array];
    NSMutableArray *accountWebArray = [NSMutableArray array];
    NSMutableArray *accountSocialNetworkArray = [NSMutableArray array];
    NSMutableArray *accountOtherArray = [NSMutableArray array];
    
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSMutableString *sql = [NSMutableString stringWithFormat:@"select * from %@ ", kPWTable];
        if (where)
        {
            [sql appendFormat:@" where %@", where];
        }
        
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            AccountModel *model = [self accountModelWithResult:result];
            switch (model.accountModelType) {
                case AccountModelTypeSocialNetwork: {
                    [accountSocialNetworkArray addObject:model];
                    break;
                }
                case AccountModelTypeWeb: {
                    [accountWebArray addObject:model];
                    break;
                }
                case AccountModelTypeBankCard: {
                    [accountBankCardArray addObject:model];
                    break;
                }
                case AccountModelTypeOther: {
                    [accountOtherArray addObject:model];
                    break;
                }
            }
            if (accountSocialNetworkArray.count != 0)
            {
                [accountArray addObject:accountSocialNetworkArray];
            }
            if (accountWebArray.count != 0)
            {
                [accountArray addObject:accountWebArray];
            }
            if (accountBankCardArray.count != 0)
            {
                [accountArray addObject:accountBankCardArray];
            }
            if (accountOtherArray.count != 0)
            {
                [accountArray addObject:accountOtherArray];
            }
        }
        
        [result close];
    }];
    
    return accountArray;
}

- (AccountModel *)accountModelWithResult:(FMResultSet *)result
{
    AccountModel *model = [[AccountModel alloc] init];
    model.accountId        = [result intForColumn:kAccountID];
    model.account          = [result stringForColumn:kAccount];
    model.accountModelType = [result intForColumn:kAccountType];
    model.remark           = [result stringForColumn:kAccountRemark];
    model.name             = [result stringForColumn:kAccountName];
    model.password         = [result stringForColumn:kAccountPassword];
    
    return model;
}

#pragma mark - 懒加载
- (FMDatabaseQueue *)dbQueue
{
    if (nil == _dbQueue)
    {
        NSString *dbPath = [self dbPath];
        _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        [self createAccountTable];
    }
    return _dbQueue;
}
@end
