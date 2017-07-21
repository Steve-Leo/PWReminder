//
//  AccountModel.m
//  PWReminder
//
//  Created by LeoSteve on 2017/7/19.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel
- (instancetype)init
{
    self = [super init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyMMddhhmmss";
    
    self.accountId = [[dateFormatter stringFromDate:[NSDate date]] integerValue];
    return self;
}
@end
