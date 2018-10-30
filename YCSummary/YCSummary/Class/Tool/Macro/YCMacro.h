//
//  YCMacro.h
//  YCSummary
//
//  Created by wuyongchao on 2018/10/30.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#ifndef YCMacro_h
#define YCMacro_h

//设备屏幕高度
#define SCREENT_HEIGHT [[UIScreen mainScreen] bounds].size.height
//设备屏幕宽度
#define SCREENT_WIDTH [[UIScreen mainScreen] bounds].size.width
//状态栏高度
#define STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
//导航栏高度
#define NAVIGATIONBAR_HEIGHT self.navigationController.navigationBar.frame.size.height
////顶部导航总高度
#define NAVIGATION_HEIGHT  ([[UIApplication sharedApplication] statusBarFrame].size.height+self.navigationController.navigationBar.frame.size.height)
//导航栏高度
//#define SafeAreaTopHeight (SCREENT_HEIGHT == 812.0 ? 88 : 64)

//程序总委托
//#define appDelegate [[UIApplication sharedApplication] delegate]
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#define DefaultColor [UIColor colorWithHexString:@"2a7fd4"]
#define DefaultDarkColor [UIColor colorWithHexString:@"2a7fd5"]
#define DefaultyellowColor [UIColor colorWithHexString:@"FF9649"]
#define LightyellowColor [UIColor colorWithHexString:@"ffab05"]
#define GoodsyellowColor [UIColor colorWithHexString:@"FF9000"]
#define defaultBlackColor  [UIColor colorWithHexString:@"1a1a1a"]
#define defaultLightColor  [UIColor colorWithHexString:@"999999"]
#define LightGreyColor [UIColor colorWithHexString:@"666666"]
#define mainTitleColor [UIColor colorWithHexString:@"333333"]
#define goodsSelloutColor [UIColor colorWithHexString:@"CCCCCC"]
#define BLODFONT(f) [UIFont boldSystemFontOfSize:[UIScreen mainScreen].bounds.size.width/375*f]

#define WHITECOLOR [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]
#define BLACKCOLOR [UIColor blackColor]
//
#define FCUserDefault [NSUserDefaults standardUserDefaults]
//发通知监听
#define NOTIF_ADD(n, f)     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(f) name:n object:nil]
#define NOTIF_POST(n, o)    [[NSNotificationCenter defaultCenter] postNotificationName:n object:o]
#define NOTIF_REMV()        [[NSNotificationCenter defaultCenter] removeObserver:self]

//日志调试
#ifdef DEBUG
#define NEED_OUTPUT_LOG             1
#else
#define NEED_OUTPUT_LOG             0
#endif

#ifdef DEBUG
#define SLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define SLog(format, ...)
#endif

#if NEED_OUTPUT_LOG
#define DebugLog(xx, ...)                NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DebugLog(xx, ...)                 nil
#endif

#ifndef IMAGE_NAMED
#define IMAGE_NAMED(__imageName__)\
[UIImage imageNamed:__imageName__]
#endif
//
#define isIpad   ([[UIDevice currentDevice]userInterfaceIdiom]==UIUserInterfaceIdiomPad?YES : NO)
//判断iPhoneX
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isIpad : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !isIpad : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !isIpad : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) && !isIpad : NO)
//判断iPhone X系列
#define IS_IPhoneX_All ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)

#define Height_StatusBar (IS_IPhoneX_All ? 44.0 : 20.0)
#define SafeAreaTopHeight (IS_IPhoneX_All ? 88.0 : 64.0)
#define Height_TabBar (IS_IPhoneX_All ? 83.0 : 49.0)

#define isIphoneX  (SCREENT_HEIGHT==812?YES : NO)
#define isIphone5  (SCREENT_WIDTH==320?YES : NO)
//屏幕底部高度
#define SafeAreaBottomHeight (IS_IPhoneX_All ? 34 : 0)
//宽适配
#define WIDTH(w)  [[UIScreen mainScreen] bounds].size.width/375*w
//高适配
#define HEIGHT(h)  (isIphoneX ? h:([[UIScreen mainScreen] bounds].size.height/667*h))
//字体适配
#define FONT(f) [UIFont systemFontOfSize:SCREENT_WIDTH>320? [UIScreen mainScreen].bounds.size.width/375*f:f]
//#define BLODFONT(f) [UIFont boldSystemFontOfSize:SCREENT_WIDTH>320? [UIScreen mainScreen].bounds.size.width/375*f:f]

//是否为iOS7
#ifndef IOS7
#define IOS7              ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] floatValue]<8.0?YES:NO)
#endif

//是否为iOS8
#ifndef IOS8
#define IOS8              ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO)
#endif
//是否为iOS9
#ifndef IOS9
#define IOS9              ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? YES : NO)
#endif
//是否为iOS10
#ifndef IOS10
#define IOS10              ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0 ? YES : NO)
#endif
//是否为iOS11
#ifndef IOS11
#define IOS11              ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0 ? YES : NO)
#endif
#define showMessage(TITLE,MESSAGE,QUVC)  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:TITLE message:MESSAGE preferredStyle:UIAlertControllerStyleAlert];\[alertController addAction:[UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:nil]];\[QUVC presentViewController:alertController animated:YES completion:nil];
//线条
#define addLine(view,y) \
UIView* defLine = [[UIView alloc]initWithFrame:CGRectMake(0, y,SCREENT_WIDTH , 1)];\
defLine.backgroundColor =[UIColor colorWithHexString:@"E7E7E7"] ;\
[view addSubview:defLine];\



#endif /* YCMacro_h */
