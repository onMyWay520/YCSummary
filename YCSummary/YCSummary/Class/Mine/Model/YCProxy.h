//
//  YCProxy.h
//  YCSummary
//
//  Created by wuyongchao on 2018/12/8.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/*NSProxy负责将消息转发到真正的target的代理类*/
@interface YCProxy : NSProxy
{
    //在内部要一个hook的对象
    id _interObject;
}
- (void)transformObjc:(NSObject *)objc;
+(instancetype)proxyWithObject:(id)object;
@end
@interface YCDog : NSObject
-(NSString *)barking:(NSInteger)months;
-(void)shut;
@end
NS_ASSUME_NONNULL_END
