//
//  UIDevice+Additions.m
//  Additions
//
//  Created by Johnil on 13-6-15.
//  Copyright (c) 2013年 Johnil. All rights reserved.
//

#import "UIDevice+Additions.h"


@implementation UIDevice (Additions)

+ (BOOL)isNewiPad{
    return ([self isiPad] && [UIScreen mainScreen].scale==2);
}

+ (BOOL)isiPhone5{
    return [UIScreen mainScreen].bounds.size.height==568.f;
}

+ (BOOL)isiPad{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}


@end
