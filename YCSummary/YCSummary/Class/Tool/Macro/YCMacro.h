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

//程序总委托
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

/// 整个应用的视图的背景色 BackgroundColor
#define MH_MAIN_BACKGROUNDCOLOR [UIColor colorWithHexString:@"EFEFF4"]
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

//宽适配
#define WIDTH(w)  [[UIScreen mainScreen] bounds].size.width/375*w
//高适配
#define HEIGHT(h)  ([[UIScreen mainScreen] bounds].size.height/667*h)

#define showMessage(TITLE,MESSAGE,QUVC)  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:TITLE message:MESSAGE preferredStyle:UIAlertControllerStyleAlert];\[alertController addAction:[UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:nil]];\[QUVC presentViewController:alertController animated:YES completion:nil];
//线条
#define addLine(view,y) \
UIView* defLine = [[UIView alloc]initWithFrame:CGRectMake(0, y,SCREENT_WIDTH , 1)];\
defLine.backgroundColor =[UIColor colorWithHexString:@"E7E7E7"] ;\
[view addSubview:defLine];\
/// 适配iPhone X + iOS 11
#define  MHAdjustsScrollViewInsets_Never(__scrollView)\
do {\
_Pragma("clang diagnostic push")\
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")\
if ([__scrollView respondsToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
NSMethodSignature *signature = [UIScrollView instanceMethodSignatureForSelector:@selector(setContentInsetAdjustmentBehavior:)];\
NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];\
NSInteger argument = 2;\
invocation.target = __scrollView;\
invocation.selector = @selector(setContentInsetAdjustmentBehavior:);\
[invocation setArgument:&argument atIndex:2];\
[invocation retainArguments];\
[invocation invoke];\
}\
_Pragma("clang diagnostic pop")\
} while (0)
/// 导航条高度
#define MH_APPLICATION_TOP_BAR_HEIGHT (MH_IS_IPHONE_X?88.0f:64.0f)
/// tabBar高度
#define MH_APPLICATION_TAB_BAR_HEIGHT (MH_IS_IPHONE_X?83.0f:49.0f)
/// 工具条高度 (常见的高度)
#define MH_APPLICATION_TOOL_BAR_HEIGHT_44  44.0f
#define MH_APPLICATION_TOOL_BAR_HEIGHT_49  49.0f
/// 状态栏高度
#define MH_APPLICATION_STATUS_BAR_HEIGHT (MH_IS_IPHONE_X?44:20.0f)

///// 朋友圈
// 是否为空对象
#define MHObjectIsNil(__object)  ((nil == __object) || [__object isKindOfClass:[NSNull class]])
// 设置图片
#define MHImageNamed(__imageName) [UIImage imageNamed:__imageName]
/// AppDelegate
#define MHSharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
// 字符串不为空
#define MHStringIsNotEmpty(__string)  (!MHStringIsEmpty(__string))

// 数组为空
#define MHArrayIsEmpty(__array) ((MHObjectIsNil(__array)) || (__array.count==0))
//  通知中心
#define MHNotificationCenter [NSNotificationCenter defaultCenter]
#endif /* YCMacro_h */
