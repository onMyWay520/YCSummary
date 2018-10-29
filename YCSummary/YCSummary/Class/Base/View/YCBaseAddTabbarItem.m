//
//  YCBaseAddTabbarItem.m
//  YCSummary
//
//  Created by wuyongchao on 2018/10/29.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCBaseAddTabbarItem.h"
#import "YCPublishVC.h"
#import "YCBaseTabbarController.h"
#import "YCBaseNavigationController.h"
@interface YCBaseAddTabbarItem () {
    CGFloat _buttonImageHeight;
}
@end
@implementation YCBaseAddTabbarItem

#pragma mark -
#pragma mark - Life Cycle

+ (void)load {
    //请在 `-[AppDelegate application:didFinishLaunchingWithOptions:]` 中进行注册，否则iOS10系统下存在Crash风险。
    //[super registerPlusButton];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}
#pragma mark -
#pragma mark - CYLPlusButtonSubclassing Methods

/*
 *
 Create a custom UIButton with title and add it to the center of our tab bar
 *
 */
+ (id)plusButton {
    YCBaseAddTabbarItem *button = [[YCBaseAddTabbarItem alloc] init];
    UIImage *normalButtonImage = [UIImage imageNamed:@"post_normal"];
    UIImage *hlightButtonImage = [UIImage imageNamed:@"post_highlight"];
    [button setImage:normalButtonImage forState:UIControlStateNormal];
    [button setImage:hlightButtonImage forState:UIControlStateSelected];
    UIImage *normalButtonBackImage = [UIImage imageNamed:@"videoback"];
    [button setBackgroundImage:normalButtonBackImage forState:UIControlStateNormal];
    [button setBackgroundImage:normalButtonBackImage forState:UIControlStateSelected];
    button.imageEdgeInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
    [button sizeToFit]; // or set frame in this way `button.frame = CGRectMake(0.0, 0.0, 250, 100);`
    button.frame = CGRectMake(0.0, 0.0, 55, 59);
    
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    return button;
    
}
#pragma mark Event Response

- (void)clickPublish {
    
}


#pragma mark - CYLPlusButtonSubclassing

+ (UIViewController *)plusChildViewController {
    YCPublishVC *plusChildViewController = [[YCPublishVC alloc] init];
    plusChildViewController.navigationItem.title = @"发布";
    UIViewController *plusChildNavigationController = [[YCBaseNavigationController alloc]initWithRootViewController:plusChildViewController];
    return plusChildNavigationController;
}
+ (NSUInteger)indexOfPlusButtonInTabBar {
    return 2;
}
+ (BOOL)shouldSelectPlusChildViewController {
    BOOL isSelected = CYLExternPlusButton.selected;
    if (isSelected) {
        //        HDLLogDebug("🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is selected");
    } else {
        //        HDLLogDebug("🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), @"PlusButton is not selected");
    }
    return YES;
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.3;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return (CYL_IS_IPHONE_X ? - 6 : 4);
}

@end
