//
//  YCLoginViewModel.h
//  YCSummary
//
//  Created by admin on 2018/12/4.
//  Copyright © 2018 YC科技有限公司. All rights reserved.
//

#import "YCBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@class RACSignal,RACCommand;
@interface YCLoginViewModel : YCBaseViewModel
@property (nonatomic, strong) NSString *account;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) RACSignal *btnEnableSignal;

@property (nonatomic, strong) RACCommand *loginCommand;

@end

NS_ASSUME_NONNULL_END
