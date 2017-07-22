//
//  LoginView.h
//  PWReminder
//
//  Created by LeoSteve on 2017/7/17.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LoginViewDelegate<NSObject>
- (void)didClickLoginBtn:(NSString *)password;
- (void)didClickFingerPrinterBtn;
@end


@interface LoginView : UIView
- (instancetype)initWithRegisterState:(BOOL)registerState;
@property (nonatomic, weak)id<LoginViewDelegate> delegate;
- (void)hidenFingerPrinterBtn;

@end
