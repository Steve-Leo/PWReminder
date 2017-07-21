//
//  LoginViewController.m
//  PWReminder
//
//  Created by LeoSteve on 2017/7/17.
//  Copyright © 2017年 com。seif。PWReminder. All rights reserved.
//

#import <LocalAuthentication/LocalAuthentication.h>
#import "CustomNavagationController.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "LoginView.h"
#import "PublicHeader.h"


@interface LoginViewController ()<LoginViewDelegate>
{
    LoginView *_loginView;
    BOOL _isRegister;
}

@end

@implementation LoginViewController

static NSString * const kPassword = @"loginPassword";

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *pw = [[NSUserDefaults standardUserDefaults] objectForKey:kPassword];
    if (pw == nil)
    {
        _isRegister = NO;
    }
    else
    {
        _isRegister = YES;
    }
    [self addViews];
    [self fingerPrinterCheck];
}

- (void)addViews
{
    _loginView = [[LoginView alloc] initWithRegisterState:_isRegister];
    _loginView.delegate = self;
    [self.view addSubview:_loginView];
    
    [_loginView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)fingerPrinterCheck
{
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
    {
        LAContext *laContext = [LAContext new];
        NSError *err = [NSError new];
        if (![laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&err])
        {
            NSLog(@"对不起指纹识别将不可用%ld",(long)err.code);
            if (err.code == -8)
            {
                UIAlertController *touchIDLockoutAlertVC = [UIAlertController alertControllerWithTitle:@"指纹出错次数太多，请锁定手机重新解锁之后再来" message:@"笨蛋，放的是妞妞的手指吗" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"妞妞是笨蛋" style:UIAlertActionStyleDestructive handler:nil];
                [touchIDLockoutAlertVC addAction:cancelAction];
                [self showAlert:touchIDLockoutAlertVC];
            }
            
        }
        
        [laContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"指纹识别登录" reply:^(BOOL success, NSError * _Nullable error) {
            if (success)
            {
                NSLog(@"验证成功！");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self login];
                });
                
            }
            
            if (error.code == -2)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
//                    UIAlertController *failedAlertVC = [UIAlertController alertControllerWithTitle:@"指纹识别失败" message:@"No" preferredStyle:UIAlertControllerStyleAlert];
////                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
////                    [failedAlertVC addAction:okAction];
//                    [failedAlertVC addAction:cancelAction];
//                    [self showAlert:failedAlertVC];
                });
            }
        }];
    }
}

#pragma mark- LoginViewDelegate
- (void)didClickLoginBtn:(NSString *)password
{
    if(password.length == 0)
    {
        UIAlertController *emptyAlertVC = [UIAlertController alertControllerWithTitle:@"请输入密码" message:@"笨蛋，密码是空的" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"妞妞是笨蛋" style:UIAlertActionStyleDestructive handler:nil];
        [emptyAlertVC addAction:cancelAction];
        [self showAlert:emptyAlertVC];
    }
    else if (!_isRegister && password.length != 0)
    {
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:kPassword];
        _isRegister = YES;
        
        [self login];
        
    }
    else
    {
        NSString *pwSaved = [[NSUserDefaults standardUserDefaults] objectForKey:kPassword];
        if ([password isEqualToString:pwSaved])
        {
            NSLog(@"密码输入成功");
            [self login];
        }
        else
        {
            UIAlertController *failedAlertVC = [UIAlertController alertControllerWithTitle:@"密码输入错误,请重新输入" message:@"又输错了，笨蛋" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"妞妞是笨蛋" style:UIAlertActionStyleDestructive handler:nil];
            [failedAlertVC addAction:cancelAction];
            [self showAlert:failedAlertVC];
            NSLog(@"密码输入错误");
        }
    }
}

- (void)didClickFingerPrinterBtn
{
    [self fingerPrinterCheck];
}

#pragma mark- Login
- (void)login
{
    MainViewController *mainVC = [[MainViewController alloc] init];
    CustomNavagationController *nv = [[CustomNavagationController alloc] initWithRootViewController:mainVC];
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ViewController *vc = [storyboard instantiateInitialViewController];
    [[UIApplication sharedApplication].keyWindow setRootViewController:nv];
}

#pragma mark- Show Alert
- (void)showAlert:(UIAlertController *)alertController
{
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
