//
//  UIView+Additions.h
//  Additions
//
//  Created by Johnil on 13-6-7.
//  Copyright (c) 2013年 Johnil. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^touchBlock)(UITouch *t, UIView *target);

@interface UIView (Additions)

- (float)x;
- (float)y;
- (float)width;
- (float)height;

- (void)setX:(float)x;
- (void)setY:(float)y;
- (void)setWidth:(float)w;
- (void)setHeight:(float)h;

- (float)boundsWidth;
- (float)boundsHeight;
- (void)setBoundsWidth:(float)w;
- (void)setBoundsHeight:(float)h;

@end
