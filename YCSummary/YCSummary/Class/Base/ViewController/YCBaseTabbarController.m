//
//  YCBaseTabbarController.m
//  YCSummary
//
//  Created by wuyongchao on 2018/10/29.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCBaseTabbarController.h"
#import "YCShopCartVC.h"
#import "YCHomeVC.h"
#import "YCMineVC.h"
#import "YCFindVC.h"
#import "FDFeedViewController.h"
#import "YCBaseNavigationController.h"
static CGFloat const CYLTabBarControllerHeight = 40.f;

@interface YCBaseTabbarController ()<UITabBarControllerDelegate>
@end

@implementation YCBaseTabbarController
- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    /**
     * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
     * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
     * 更推荐后一种做法。
     */
    UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
    UIOffset titlePositionAdjustment = UIOffsetMake(0, -3.5);
    CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                               tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                         imageInsets:imageInsets
                                                                             titlePositionAdjustment:titlePositionAdjustment
                                                                                             context:nil
                                             ];
    [self customizeTabBarAppearance:tabBarController];
    return (self = (YCBaseTabbarController *)tabBarController);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    [self becomeFirstResponder];

}

- (NSArray *)viewControllers {
    YCHomeVC *firstViewController = [[YCHomeVC alloc] init];
    UIViewController *firstNavigationController = [[YCBaseNavigationController alloc]initWithRootViewController:firstViewController];
    
    YCFindVC *secondViewController = [[YCFindVC alloc] init];
    UIViewController *secondNavigationController = [[YCBaseNavigationController alloc]initWithRootViewController:secondViewController];
    
    FDFeedViewController *thirdViewController = [[FDFeedViewController alloc] init];
    UIViewController *thirdNavigationController = [[YCBaseNavigationController alloc]initWithRootViewController:thirdViewController];
    
    YCMineVC *forthViewController = [[YCMineVC alloc] init];
    UIViewController *forthNavigationController = [[YCBaseNavigationController alloc]initWithRootViewController:forthViewController];
    CYLTabBarController *tabBarController = [[CYLTabBarController alloc] init];
    NSArray *viewControllers =@[
    firstNavigationController,
    secondNavigationController,
    thirdNavigationController,
    forthNavigationController];
    tabBarController.delegate=self;
//    self.tabBarController = tabBarController;
    return viewControllers;
}

/*
 *
 在`-setViewControllers:`之前设置TabBar的属性，
 *
 */
- (NSArray *)tabBarItemsAttributesForController {
    CGFloat firstXOffset = -12/2;
    NSDictionary *dict1 = @{
                            CYLTabBarItemTitle : @"首页",
                            CYLTabBarItemImage : @"home_unselect",
                            CYLTabBarItemSelectedImage : @"home_select",
                            CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(firstXOffset, -3.5)]
                            };
    CGFloat secondXOffset = (-25+2)/2;
    NSDictionary *dict2 = @{
                            CYLTabBarItemTitle : @"发现",
                            CYLTabBarItemImage : @"search_unselect",
                            CYLTabBarItemSelectedImage : @"search_select",
                             CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(secondXOffset, -3.5)]
                            };
    NSDictionary *dict3 = @{
                            CYLTabBarItemTitle : @"购物车",
                            CYLTabBarItemImage : @"shopCart_unselect",
                            CYLTabBarItemSelectedImage : @"shopCart_select",
                            CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(-secondXOffset, -3.5)]
                            };
    NSDictionary *dict4 = @{
                            CYLTabBarItemTitle : @"我的",
                            CYLTabBarItemImage : @"mine_unselect",
                            CYLTabBarItemSelectedImage : @"mine_select",
                         CYLTabBarItemTitlePositionAdjustment: [NSValue valueWithUIOffset:UIOffsetMake(-firstXOffset, -3.5)]
                            };
    NSArray *tabBarItemsAttributes = @[ dict1, dict2,dict3,dict4 ];
    return tabBarItemsAttributes;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    UIView *animationView;
    // 如果 PlusButton 也添加了点击事件，那么点击 PlusButton 后不会触发该代理方法。
    if ([control isKindOfClass:[CYLExternPlusButton class]]) {
        UIButton *button = CYLExternPlusButton;
        animationView = button.imageView;
    } else if ([control isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
        for (UIView *subView in control.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                animationView = subView;
            }
        }
    }

    if ([self cyl_tabBarController].selectedIndex % 2 == 0) {
        [self addScaleAnimationOnView:animationView];
    } else {
        [self addRotateAnimationOnView:animationView];
    }
}

//缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.repeatCount = 1;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}

//旋转动画
- (void)addRotateAnimationOnView:(UIView *)animationView {
    [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    } completion:nil];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
        } completion:nil];
    });
}
/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {
    // Customize UITabBar height
    // 自定义 TabBar 高度
    //    tabBarController.tabBarHeight = CYL_IS_IPHONE_X ? 65 : 40;
    
    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // Set the dark color to selected tab (the dimmed background)
    // TabBarItem选中后的背景颜色
    [self customizeTabBarSelectionIndicatorImage];
    
    // update TabBar when TabBarItem width did update
    // If your app need support UIDeviceOrientationLandscapeLeft or UIDeviceOrientationLandscapeRight，
    // remove the comment '//'
    // 如果你的App需要支持横竖屏，请使用该方法移除注释 '//'
    [self updateTabBarCustomizationWhenTabBarItemWidthDidUpdate];
    
    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor clearColor]];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    //        [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    
    // set the bar background image
    // 设置背景图片
    UITabBar *tabBarAppearance = [UITabBar appearance];
    
    //FIXED: #196
    NSString *tabBarBackgroundImageName = @"tabbarBg";
    UIImage *tabBarBackgroundImage = [UIImage imageNamed:tabBarBackgroundImageName];
    UIImage *scanedTabBarBackgroundImage = [[self class] scaleImage:tabBarBackgroundImage];
    [tabBarAppearance setBackgroundImage:scanedTabBarBackgroundImage];
    
    // remove the bar system shadow image
    // 去除 TabBar 自带的顶部阴影
    // iOS10 后 需要使用 `-[CYLTabBarController hideTabBadgeBackgroundSeparator]` 见 AppDelegate 类中的演示;
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void)updateTabBarCustomizationWhenTabBarItemWidthDidUpdate {
    void (^deviceOrientationDidChangeBlock)(NSNotification *) = ^(NSNotification *notification) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if ((orientation == UIDeviceOrientationLandscapeLeft) || (orientation == UIDeviceOrientationLandscapeRight)) {
            NSLog(@"Landscape Left or Right !");
        } else if (orientation == UIDeviceOrientationPortrait) {
            NSLog(@"Landscape portrait!");
        }
        [self customizeTabBarSelectionIndicatorImage];
    };
    [[NSNotificationCenter defaultCenter] addObserverForName:CYLTabBarItemWidthDidChangeNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:deviceOrientationDidChangeBlock];
}

- (void)customizeTabBarSelectionIndicatorImage {
    ///Get initialized TabBar Height if exists, otherwise get Default TabBar Height.
    CGFloat tabBarHeight = CYLTabBarControllerHeight;
    CGSize selectionIndicatorImageSize = CGSizeMake(CYLTabBarItemWidth, tabBarHeight);
    //Get initialized TabBar if exists.
    UITabBar *tabBar = [self cyl_tabBarController].tabBar ?: [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:
     [[self class] imageWithColor:[UIColor whiteColor]
                             size:selectionIndicatorImageSize]];
}

+ (UIImage *)scaleImage:(UIImage *)image {
    CGFloat halfWidth = image.size.width/2;
    CGFloat halfHeight = image.size.height/2;
    UIImage *secondStrechImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(halfHeight, halfWidth, halfHeight, halfWidth) resizingMode:UIImageResizingModeStretch];
    return secondStrechImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width + 1, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
