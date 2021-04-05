//
//  YCFunc.h
//  YCSummary
//
//  Created by wuyongchao on 2021/4/5.
//  Copyright © 2021 YC科技有限公司. All rights reserved.
//

#ifndef YCFunc_h
#define YCFunc_h

/**
 Status bar height
 
 @return height
 */
static inline CGFloat YCStatusHeight() {
    static CGFloat statusHeight = 0.0;
    if (statusHeight <= 0) {
        statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    }
    return statusHeight;
}


/**
 SafeArea bottom
 
 @return height
 *YCSafeAreaTopHeighoat YCSafeAreaBottomHeight() {
    static CGFloat bottomHeight = 0.0f;
    if (bottomHeight > 0) {
        return bottomHeight;
    }
    if (@available(iOS 11.0, *)) {
        bottomHeight = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;
 YCSafeAreaTopHeighHeight;
}

/**
 SafeArea top
 
 @return height
 */
static inline CGFloat YCSafeAreaTopHeigh() {
    CGFloat topHeight = 0;
    if (@available(iOS 11.0, *)) {
        topHeight = [UIApplication sharedApplication].keyWindow.safeAreaInsets.top;
    }
    return topHeight;
}

/**
 UINavigationBar height
 
 @return height
 */
static inline CGFloat YCNavBarHeight() {
    static CGFloat navHeight = 0.0;
    if (navHeight <= 0) {
        UIViewController * rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        if ([rootViewController isKindOfClass:UITabBarController.class]) {
            rootViewController = [(UITabBarController *)rootViewController presentingViewController];
        }
        if (rootViewController.navigationController) {
            navHeight = rootViewController.navigationController.navigationBar.frame.size.height;
        } else {
            navHeight = 44;
        }
    }
    return navHeight;
}

/**
 StatusBarHeight and UINavigationBar height
 
 @return height
 */
static inline CGFloat YCNavBarAndStatusHeight() {
    return YCStatusHeight() + YCNavBarHeight();
}

#endif /* YCFunc_h */
