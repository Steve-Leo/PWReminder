//
//  UtilsMacro.h
//
//  Created by pengpeng on 15/7/3.
//  Copyright (c) 2016年 SanQian. All rights reserved.
//
//  工具类型的宏定义

#ifndef UtilsMacro_h
#define UtilsMacro_h

/**************************************************************/
#pragma mark - 颜色类相关

// 十六进制值取色(HEX, alpha)
#define UIColorFromHexA(rgbValue, alp)          [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0    \
                                                                green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0       \
                                                                 blue:((float)(rgbValue & 0xFF)) / 255.0                \
                                                                alpha:alp]
// 获取RGB Alpha颜色
#define UIColorFromRGBA(R, G, B, A)             [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

// 十六进制值取色(HEX)
#define UIColorFromHex(rgbValue)                UIColorFromHexA(rgbValue, 1.0)

// 获取RGB颜色
#define UIColorFromRGB(R, G, B)                 UIColorFromRGBA(R, G, B, 1.0f)

/**************************************************************/

// 获取主屏幕的高度
#define kMainScreenHeight                       ([UIScreen mainScreen].bounds.size.height)
// 获取主屏幕的宽度
#define kMainScreenWidth                        ([UIScreen mainScreen].bounds.size.width)


// 16:9 和 4:3 比例值
#define kScale_16_9                             1.777777
#define kScale_4_3                              1.333333

/**************************************************************/

#pragma mark - 打印日志相关

#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

// DEBUG  模式下打印日志,当前行
#ifdef DEBUG
    #define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
    #define DLog(...)
#endif

//DEBUG  模式下打印日志,当前行 并弹出一个警告
#ifdef DEBUG
    #define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
    #define ULog(...)
#endif

/**************************************************************/

#pragma mark - 系统相关
//----------------------系统----------------------------

// 是否iPad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//判断当前屏幕是不是iPhone4
#define isScreeniPhone4  (([[UIScreen mainScreen] bounds].size.height) == 480)

// 获取系统版本
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]
#define IOS_VERSION [CurrentSystemVersion floatValue]

// 获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

// 判断设备的操做系统是不是ios7
#define IOS_7_X (IOS_VERSION >= 7.0f && IOS_VERSION < 8.0f)

//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/**************************************************************/

#pragma mark - GCD

// GCD
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

// 由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

#define WeakObj(obj)    __weak typeof(obj)      obj##Weak = obj;
#define StrongObj(obj)  __strong typeof(obj)    obj = obj##Weak;

/**************************************************************/

#endif
