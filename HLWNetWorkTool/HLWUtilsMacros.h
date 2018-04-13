//
//  HLWUtilsMacros.h
//  HLWNetWorkTool
//
//  Created by siweisoft on 18/4/2.
//  Copyright © 2018年 葫芦娃. All rights reserved.
//

// 全局工具类宏定义

#ifndef HLWUtilsMacros_h
#define HLWUtilsMacros_h

//获取系统对象
#define HLWApplication        [UIApplication sharedApplication]
#define HLWAppWindow          [UIApplication sharedApplication].delegate.window
#define HLWRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define HLWUserDefaults       [NSUserDefaults standardUserDefaults]
#define HLWNotificationCenter [NSNotificationCenter defaultCenter]

//获取屏幕宽高
#define HLWScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define HLWScreenHeight [[UIScreen mainScreen] bounds].size.height
#define HLWScreen_Bounds [UIScreen mainScreen].bounds

// iPhone X
#define  HLW_iPhoneX (HLWScreenWidth == 375.f && HLWScreenHeight == 812.f ? YES : NO)
// Status bar height.
#define  HLW_StatusBarHeight      (HLW_iPhoneX ? 44.f : 20.f)
// Navigation bar height.
#define  HLW_NavigationBarHeight  44.f
// Tabbar height.
#define  HLW_TabbarHeight         (HLW_iPhoneX ? (49.f+34.f) : 49.f)
// Tabbar safe bottom margin.
#define  HLW_TabbarSafeBottomMargin         (HLW_iPhoneX ? 34.f : 0.f)
// Status bar & navigation bar height.
#define  HLW_StatusBarAndNavigationBarHeight  (HLW_iPhoneX ? 88.f : 64.f)

#define HLW_ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})
/**
 *  1 判断是否为3.5inch      320*480
 */
#define HLWOneScreen ([UIScreen mainScreen].bounds.size.height == 480)
/**
 *  2 判断是否为4inch        640*1136
 */
#define HLWTwoScreen ([UIScreen mainScreen].bounds.size.height == 568)
/**
 *  3 判断是否为4.7inch   375*667   750*1334
 */
#define HLWThreeScreen ([UIScreen mainScreen].bounds.size.height == 667)
/**
 *  4 判断是否为5.5inch
 */
#define HLWFourScreen ([UIScreen mainScreen].bounds.size.height == 736)

//强弱引用
#define HLWWeakSelf(type)  __weak typeof(type) weak##type = type;
#define HLWStrongSelf(type) __strong typeof(type) type = weak##type;

//View 圆角和加边框
#define HLWViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define HLWViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

// 当前系统版本
#define CurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]

//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define NSLog(format, ...) printf("[文件名:%s]-[行数:第%d行]->打印内容:%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__,[[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

//拼接字符串
#define HLWNSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

//颜色
#define HLWClearColor [UIColor clearColor]
#define HLWWhiteColor [UIColor whiteColor]
#define HLWBlackColor [UIColor blackColor]
#define HLWGrayColor [UIColor grayColor]
#define HLWGray2Color [UIColor lightGrayColor]
#define HLWBlueColor [UIColor blueColor]
#define HLWRedColor [UIColor redColor]
//随机色生成
#define HLWRandomColor    KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)

//字体
#define HLWBoldSystemFont(FONTSIZE) [UIFont boldSystemFontOfSize:FONTSIZE]
#define HLWSystemFont(FONTSIZE)     [UIFont systemFontOfSize:FONTSIZE]
#define HLWFont(NAME, FONTSIZE)     [UIFont fontWithName:(NAME) size:(FONTSIZE)]


//定义UIImage对象
#define HLWImage_Named(name) [UIImage imageNamed:name]

//数据验证
#define HLWStrValid(str)             (str!=nil && [str isKindOfClass:[NSString class]] && ![str isEqualToString:@""])
#define HLWSafeStr(str)              (StrValid(str) ? str:@"")
#define HLWHasString(str,key)        ([str rangeOfString:key].location!=NSNotFound)

#define HLWValidStr(obj)          StrValid(obj)
#define HLWValidDict(obj)         (obj!=nil && [obj isKindOfClass:[NSDictionary class]])
#define HLWValidArray(obj)        (obj!=nil && [obj isKindOfClass:[NSArray class]] && [object count]>0)
#define HLWValidNum(obj)          (obj!=nil && [obj isKindOfClass:[NSNumber class]])
#define HLWValidClass(obj,cls)    (obj!=nil && [obj isKindOfClass:[cls class]])
#define HLWValidData(obj)         (obj!=nil && [obj isKindOfClass:[NSData class]])

//发送通知
#define HLWPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];

//单例化一个类
#define HLWSINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define HLWSINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#endif /* HLWUtilsMacros_h */
