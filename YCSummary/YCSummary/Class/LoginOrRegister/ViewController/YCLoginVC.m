//
//  YCLoginVC.m
//  YCSummary
//
//  Created by admin on 2018/12/4.
//  Copyright © 2018 YC科技有限公司. All rights reserved.
//

#import "YCLoginVC.h"
#import "YCLoginViewModel.h"
#import "ReactiveCocoa.h"
#import "YCBaseTabbarController.h"
@interface YCLoginVC ()
@property (nonatomic, strong) YCLoginViewModel *loginVM;
@property (nonatomic,strong) UITextField *accountTF;///<
@property (nonatomic,strong) UITextField *passwordTF;///<
@property (nonatomic,strong) UIButton *loginBtn;///<

@end

@implementation YCLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.accountTF];
    [self.view addSubview:self.passwordTF];
    [self.view addSubview:self.loginBtn];
    RAC(self.loginVM,account) = _accountTF.rac_textSignal;
    RAC(self.loginVM,password) = _passwordTF.rac_textSignal;
    
    RAC(_loginBtn,enabled) = self.loginVM.btnEnableSignal;
    
    [self.loginVM.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"登录成功，跳转页面");
        YCBaseTabbarController *tabbarVC=[[YCBaseTabbarController alloc]init];
        [UIApplication sharedApplication].keyWindow.rootViewController=tabbarVC;
    }];
    
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击了  点击了");
        [self.loginVM.loginCommand execute:@{
            @"account":self->_accountTF.text,
            @"password":self->_passwordTF.text}];
    }];
}
- (YCLoginViewModel *)loginVM{
    if (!_loginVM){
        _loginVM = [[YCLoginViewModel alloc] init];
    }
    return _loginVM;
}
-(UITextField *)accountTF{
    if (!_accountTF) {
        _accountTF=[[UITextField alloc]initWithFrame:CGRectMake(WIDTH(20), HEIGHT(200), SCREENT_WIDTH-WIDTH(40), HEIGHT(40))];
        _accountTF.placeholder = @"请输入账号，至少1位";
        _accountTF.borderStyle = UITextBorderStyleRoundedRect;

    }
    return _accountTF;
}
-(UITextField *)passwordTF{
    if (!_passwordTF) {
        _passwordTF=[[UITextField alloc]initWithFrame:CGRectMake(self.accountTF.left, self.accountTF.bottom+HEIGHT(20), self.accountTF.width, self.accountTF.height)];
        _passwordTF.placeholder = @"请输入密码，至少6位";
        _passwordTF.borderStyle = UITextBorderStyleRoundedRect;


    }
    return _passwordTF;
}
-(UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        [_loginBtn setTitle:@"登陆" forState:0];
        _loginBtn.titleLabel.font=FONT(18);
//        [_loginBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
_loginBtn.frame=CGRectMake(self.accountTF.left, self.passwordTF.bottom+HEIGHT(40), self.accountTF.width, HEIGHT(50));
    
//        _loginBtn.backgroundColor=[UIColor redColor];
    }
    return _loginBtn;
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
