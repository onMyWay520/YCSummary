//
//  LCActionSheet+MHExtension.m
//  WeChat
//
//  Created by senba on 2017/5/22.
//  Copyright © 2017年 CoderMikeHe. All rights reserved.
//

#import "LCActionSheet+MHExtension.h"

@implementation LCActionSheet (MHExtension)
+ (void)mh_configureActionSheet
{
    LCActionSheetConfig *config = LCActionSheetConfig.config;
    /// 蒙版可点击
    config.darkViewNoTaped = NO;
    config.separatorColor = [UIColor colorForHex:@"#D9D8D9"];
    config.buttonColor = [UIColor colorForHex:@"#3C3E44"];
    config.buttonFont = [UIFont systemFontOfSize:16];
    config.unBlur = YES;
    config.darkOpacity = .6f;
    /// 设置
    config.titleEdgeInsets = UIEdgeInsetsMake(27, 22, 27, 22);
    config.titleFont = [UIFont systemFontOfSize:13];
    
}
@end
