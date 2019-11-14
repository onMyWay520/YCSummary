//
//  YCBezierPathVC.m
//  YCSummary
//
//  Created by wuyongchao on 2019/11/14.
//  Copyright © 2019 YC科技有限公司. All rights reserved.
//

#import "YCBezierPathVC.h"
#import "YCBezierPathView.h"
@interface YCBezierPathVC ()
@property (nonatomic, strong) CAShapeLayer *loadingLayer;
@property (nonatomic, strong) NSTimer       *timer;
@property (nonatomic, strong) NSArray       *animationTypes;
@property (nonatomic, assign) NSUInteger    index;
@property (nonatomic, strong) YCBezierPathView *pathView;
@end

@implementation YCBezierPathVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"BezierPath演练";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self testBezierPath];
    
}
- (void)testBezierPath {
  YCBezierPathView *v = [[YCBezierPathView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-150)];
  v.backgroundColor=WHITECOLOR;
  v.type = kThirdBezierPath;
  [self.view addSubview:v];
  self.index = 0;
  self.animationTypes = @[@(kDefaultPath),
                          @(kRectPath),
                          @(kCirclePath),
                          @(kOvalPath),
                          @(kRoundedRectPath),
                          @(kArcPath),
                          @(kSecondBezierPath)];

  self.timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                target:self
                                              selector:@selector(updateType)
                                              userInfo:nil
                                               repeats:YES];


  self.pathView = v;
}
- (void)updateType {
  if (self.index + 1 < self.animationTypes.count) {
    self.index ++;
  } else {
    self.index = 0;
  }
  
  self.pathView.type = [[self.animationTypes objectAtIndex:self.index] intValue];
  [self.pathView setNeedsDisplay];
}
-(void)dealloc{
    [self.timer invalidate];
    self.timer=nil;
}
@end
