//
//  YCKVOVC.m
//  YCSummary
//
//  Created by admin on 2019/1/15.
//  Copyright © 2019 YC科技有限公司. All rights reserved.
//

#import "YCKVOVC.h"
#import "YCPeople.h"
@interface YCKVOVC ()
@property (nonatomic,strong) YCPeople *people;///<
@end

@implementation YCKVOVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.people=[[YCPeople alloc]init];
    
    [self.people setName:@"zhangsan"];
    
//    NSLog(@"%@", object_getClass(self.people));
 [self.people addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    NSLog(@"%@", object_getClass(self.people));
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.people setName:@"lisi"];
    //    [self.person willChangeValueForKey:@"name"];
    //    [self.person didChangeValueForKey:@"name"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@"%@", change);
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
