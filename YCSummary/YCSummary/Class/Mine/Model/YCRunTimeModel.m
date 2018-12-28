//
//  YCRunTimeModel.m
//  YCSummary
//
//  Created by wuyongchao on 2018/11/21.
//  Copyright © 2018年 YC科技有限公司. All rights reserved.
//

#import "YCRunTimeModel.h"
#import "YCPeople.h"
#import <objc/message.h>
#import "UIImage+Swizzling.h"
#import "NSObject+hook.h"
#import "YCArchieveModel.h"
#import "NSObject+YCKVO.h"
#import "YCNewModel.h"
@interface YCRunTimeModel()
@property(nonatomic,strong)YCPeople *people;
@end
@implementation YCRunTimeModel
- (instancetype)init {
    self = [super init];
    if (self) {
        [self getIMPFromSelector:@selector(aaa)];
        [self getIMPFromSelector:@selector(test1)];
        [self getIMPFromSelector:@selector(test2)];
    }
    return self;
}

- (void)test1 {
    NSLog(@"test1");
}

- (void)test2 {
    NSLog(@"test2");
}
#pragma mark - 增加属性
-(void)addProperty{
    NSObject *object=[[NSObject alloc]init];
    object.name=@"yongchao";
    DebugLog(@"增加属性=%@",object.name);
}
-(void)showKVO{
   
}
-(void)showNotification{
    [self yc_postNotificationWithName:@"YCNotification" userInfo:@{@"date" : @"2018-9-20"}];

    
}
#pragma mark - 数组异常处理
/*在debug模式下回崩溃，在release模式下正常，切换模式即可，可以减少线上闪退*/
-(void)ArrayAbnormal:(NSArray *)array{
    [array objectAtIndex:22];
}

#pragma mark - 归档和解档
-(void)encodeAndDecode{
    YCArchieveModel *model=[[YCArchieveModel alloc]init];
    model.name=@"张三";
    model.age=@25;
    model.height=@168;
    //  归档文件的路径
    NSString *filePath = [NSHomeDirectory()stringByAppendingPathComponent:@"person.archiver"];
    //  判断该文件是否存在
    if (![[NSFileManager defaultManager]fileExistsAtPath:filePath]) {
        //  不存在的时候，归档存储一个Student的对象
        NSMutableData *data = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
        [archiver encodeObject:model forKey:@"student"];
        [archiver finishEncoding];
        BOOL success = [data writeToFile:filePath atomically:YES];
        if (success) {
            NSLog(@"归档成功！");
        }
    }
    else{
        //  存在的时候，不再进行归档，而是解挡！
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        YCArchieveModel *studentFromSaving = [unArchiver decodeObjectForKey:@"student"];
        NSLog(@"%@",studentFromSaving.name);
    }
    
}
#pragma mark - 字典转模型
-(void)modelWithDict{
    NSDictionary *dic = @{@"name":@"我",
                          @"sex":@"男",
                          @"age":@25
                          };
    YCPeople *model = [YCPeople modelWithDict:dic];
    NSLog(@"name:%@  sex:%@  age:%@",model.name,model.sex,model.age);
}
#pragma mark - 获取所有的方法
-(void)getAllMethod{
        NSArray *array =[UIButton getAllMethods];//获取类中所有方法
    //    NSArray *propArray =[Person yc_objcProperties];//获取类中所有属性
//    NSArray *protolArray=[YCArchieveModel getProtocolList];//获取类中所有协议
    //    NSString *className =[ViewController getClassName];//类名
    //    NSArray *array =[ViewController getIvarList];//获取类中所有成员变量
    
    //    NSLog(@"array==%@",array);
    NSLog(@"protolArray==%@",array);
}
#pragma mark - 交换方法
//-(void)swizzleImage{
//    UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENT_WIDTH, SCREENT_HEIGHT)];
//    imgView.image=[UIImage yc_imageNamed:@"guide"];
//    [self.view addSubview:imgView];
//}
#pragma mark - 消息转发机制
-(void)messageLearn{
    // 使用 Runtime 创建一个对象
    // 根据类名获取到类
    Class personClass=objc_getClass("YCPeople");
    // 同过类创建实例对象
    // 如果这里报错，请将 Build Setting -> Enable Strict Checking of objc_msgSend Calls 改为 NO
    YCPeople *person=objc_msgSend(personClass, @selector(alloc));
    // 通过 Runtime 初始化对象
    person=objc_msgSend(person, @selector(init));
    // 通过 Runtime 调用对象方法
    // 调用的这个方法没有声明只有实现所以这里会有警告
    // 但是发送消息的时候会从方法列表里寻找方法
    // 所以这个能够成功执行
    objc_msgSend(person, @selector(eat));
    // 当然，objc_msgSend 可以传递参数
    YCPeople *per=objc_msgSend(objc_msgSend(objc_getClass("Person"), sel_registerName("alloc")), sel_registerName("init"));
        objc_msgSend(per, @selector(run:), 100);
}
- (void)getIMPFromSelector:(SEL)aSelector{
    // first method
    IMP instanceIMP1 = class_getMethodImplementation(objc_getClass("YCRunTimeModel"), aSelector);
    IMP classIMP1 = class_getMethodImplementation(objc_getMetaClass("YCRunTimeModel"), aSelector);
    
    // second method
    Method instanceMethod = class_getInstanceMethod(objc_getClass("YCRunTimeModel"), aSelector);
    IMP instanceIMP2 = method_getImplementation(instanceMethod);
    
    Method classMethod1 = class_getClassMethod(objc_getClass("YCRunTimeModel"), aSelector);
    IMP classIMP2 = method_getImplementation(classMethod1);
    
    Method classMethod2 = class_getClassMethod(objc_getMetaClass("YCRunTimeModel"), aSelector);
    IMP classIMP3 = method_getImplementation(classMethod2);
    
    NSLog(@"instance1:%p instance2:%p class1:%p class2:%p class3:%p",instanceIMP1,instanceIMP2,classIMP1,classIMP2,classIMP3);
    /*2018-12-28 16:41:42.587371+0800 YCSummary[14040:289609] instance1:0x1064e8a00 instance2:0x0 class1:0x1064e8a00 class2:0x0 class3:0x0
     2018-12-28 16:41:42.587534+0800 YCSummary[14040:289609] instance1:0x1052b2240 instance2:0x1052b2240 class1:0x1064e8a00 class2:0x0 class3:0x0
     2018-12-28 16:41:42.587658+0800 YCSummary[14040:289609] instance1:0x1052b2270 instance2:0x1052b2270 class1:0x1064e8a00 class2:0x0 class3:0x0
     2018-12-28 16:41:42.587763+0800 YCSummary[14040:289609] instance1:0x1064e8a00 instance2:0x0 class1:0x1064e8a00 class2:0x0 class3:0x0
     2018-12-28 16:41:42.587858+0800 YCSummary[14040:289609] instance1:0x1052b2240 instance2:0x1052b2240 class1:0x1064e8a00 class2:0x0 class3:0x0
     2018-12-28 16:41:42.587949+0800 YCSummary[14040:289609] instance1:0x1052b2270 instance2:0x1052b2270 class1:0x1064e8a00 class2:0x0 class3:0x0*/
    /*0x1064e8a00出现了8次，这个是在调用class_getMethodImplementation()方法时，无法找到对应实现时返回的相同的一个地址，无论该方法是在实例方法或类方法，无论是否对一个实例调用该方法，返回的地址都是相同的，但是每次运行该程序时返回的地址并不相同，而对于另一种方法，如果找不到对应的实现，则返回0x0
     
    */
}
@end
