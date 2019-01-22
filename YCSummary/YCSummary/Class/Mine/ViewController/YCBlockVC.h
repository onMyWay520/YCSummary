//
//  YCBlockVC.h
//  YCSummary
//
//  Created by admin on 2019/1/17.
//  Copyright © 2019 YC科技有限公司. All rights reserved.
//


#import "FCBaseTableVC.h"

NS_ASSUME_NONNULL_BEGIN
typedef NSString * (^MyBlock)(NSString *);
typedef void (^MyBlock2)(NSString *);

@interface YCBlockVC : FCBaseTableVC
@property (nonatomic, copy) MyBlock myblock;
@property (nonatomic, copy) MyBlock2 myblock2;

@end

NS_ASSUME_NONNULL_END
