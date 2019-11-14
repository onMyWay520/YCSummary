//
//  YCDrawRectVC.m
//  YCSummary
//
//  Created by wuyongchao on 2019/11/14.
//  Copyright © 2019 YC科技有限公司. All rights reserved.
//

#import "YCDrawRectVC.h"
#import "YCDrawRectView.h"
@interface YCDrawRectVC ()

@end

@implementation YCDrawRectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    YCDrawRectView *v = [[YCDrawRectView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-150)];
    v.backgroundColor=WHITECOLOR;
    v.type = kdrawImage;
    [self.view addSubview:v];
    
}



@end
