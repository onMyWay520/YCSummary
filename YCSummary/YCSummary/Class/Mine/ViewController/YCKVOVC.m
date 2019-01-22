//
//  YCKVOVC.m
//  YCSummary
//
//  Created by admin on 2019/1/15.
//  Copyright © 2019 YC科技有限公司. All rights reserved.
//

#import "YCKVOVC.h"
#import "YCPeople.h"
#import <objc/runtime.h>
#import "KVOController.h"
@interface YCKVOVC ()
@property (nonatomic,strong) YCPeople *people;///<
@end

@implementation YCKVOVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.KVOController observe:self.people keyPath:@"name" options: NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary * _Nonnull change) {
        self.title = change[NSKeyValueChangeNewKey];
    }];
    self.people=[[YCPeople alloc]init];
    [self.people setName:@"zhangsan"];
    NSLog(@"1=%@=%p", object_getClass(self.people),[self.people methodForSelector:@selector(setName:)]);//1=YCPeople
    [self.people addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    NSLog(@"2=%@=%p", object_getClass(self.people),[self.people methodForSelector:@selector(setName:)]);//2=NSKVONotifying_YCPeople
    
    /*Apple 使用了isa混写来实现kvo，当观察对象A时，kvo机制动态创建一个新的命为NSKVONotifying_A的新类，该类继承自对象A的本类，且KVO为NSKVONotifying_A重写观察属性的setter方法，setter方法会负责在调用setter方法之前和之后，通知所有观察对象属性值的更改情况*/
    /*kvo崩溃的一般原因，1.被观察者释放了，被观察者是一个区域性变数2.观察者释放了，但是没有移除键值监听 3.注册的监听没有被移除掉，又重新注册了一遍监听*/
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.people setName:@"lisi"];
    //    [self.person willChangeValueForKey:@"name"];
    //    [self.person didChangeValueForKey:@"name"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"%@", change);
    /*{
      kind = 1;
      new = lisi;
      old = zhangsan;
    }*/
}

- (void)dealloc{
    [self.people removeObserver:self forKeyPath:@"name"];
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
