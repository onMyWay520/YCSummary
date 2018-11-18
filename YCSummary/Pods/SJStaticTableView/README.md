# SJStaticTableView

一个基于MVVM，用于快速搭建设置页，个人信息页的框架。
封装了cell和section的viewModel，用另外一个类来充当``UITableViewDataSource``的角色。

**使用方法**：只需继承``SJStaticTableViewController``并给数据源传入viewModel数组即可。

支持的cell类型：

```objc
typedef NS_ENUM(NSInteger, SSJStaticCellType) {
    
    //系统风格的各种cell类型，已封装好，可以直接用
    SSJStaticCellTypeSystemLogout,                          //退出登录cell（已封装好）
    SSJStaticCellTypeSystemAccessoryNone,                   //右侧没有任何控件
    SSJStaticCellTypeSystemAccessorySwitch,                 //右侧是开关
    SSJStaticCellTypeSystemAccessoryDisclosureIndicator,    //右侧是三角箭头(箭头左侧可以有一个image或者一个label，或者二者都有，根据传入的参数决定)
    
    //需要用户自己添加的自定义cell类型
    SSJStaticCellTypeMeAvatar,                              //个人页“我”cell  
};
```

![支持cell类型](http://oih3a9o4n.bkt.clouddn.com/sjstatictableview_6.png)

## 集成方法：
1. 静态：手动将SJStaticTableViewComponent文件夹拖入到工程中。
2. 动态：CocoaPods：``pod 'SJStaticTableView', '~> 1.0.3'``。

## 1. Demo效果图：
![发现页 | 个人页 | 个人信息页 | 设置页](http://oih3a9o4n.bkt.clouddn.com/sjstatictableview_1.png)

## 2. 页面与代码展示

### 2.1 发现页
#### 效果图：
![发现页](http://oih3a9o4n.bkt.clouddn.com/sjstatictableview_4.png)

#### 数据源设置代码：
```objc
+ (NSArray *)momentsPageData
{
    // ========== section 0
    SJStaticTableviewCellViewModel *vm0 = [[SJStaticTableviewCellViewModel alloc] init];
    vm0.leftImage = [UIImage imageNamed:@"ff_IconShowAlbum"];
    vm0.leftTitle = @"朋友圈";
    vm0.indicatorLeftImage = [UIImage imageNamed:@"avatar"];
    vm0.identifier = 0;
    
    SJStaticTableviewSectionViewModel *section0 = [[SJStaticTableviewSectionViewModel alloc] initWithCellViewModelsArray: @[vm0]];
    
    
    // ========== section 1
    SJStaticTableviewCellViewModel *vm1 = [[SJStaticTableviewCellViewModel alloc] init];
    vm1.leftImage = [UIImage imageNamed:@"ff_IconQRCode"];
    vm1.leftTitle = @"扫一扫";
    vm1.identifier = 1;
    
    SJStaticTableviewCellViewModel *vm2 = [[SJStaticTableviewCellViewModel alloc] init];
    vm2.leftImage = [UIImage imageNamed:@"ff_IconShake"];
    vm2.leftTitle = @"摇一摇";
    vm2.identifier = 2;
    
    
    SJStaticTableviewSectionViewModel *section1 = [[SJStaticTableviewSectionViewModel alloc] initWithCellViewModelsArray:@[vm1,vm2]];
    
    
    SJStaticTableviewCellViewModel *vm3 = [[SJStaticTableviewCellViewModel alloc] init];
    vm3.leftImage = [UIImage imageNamed:@"ff_IconLocationService"];
    vm3.leftTitle = @"附近的人";
    vm3.identifier = 3;
    
    
    SJStaticTableviewCellViewModel *vm4 = [[SJStaticTableviewCellViewModel alloc] init];
    vm4.leftImage = [UIImage imageNamed:@"ff_IconBottle"];
    vm4.leftTitle = @"漂流瓶";
    vm4.identifier = 4;
    
    
    SJStaticTableviewSectionViewModel *section2 = [[SJStaticTableviewSectionViewModel alloc] initWithCellViewModelsArray:@[vm3,vm4]];
    
    
    // ========== section 2
    SJStaticTableviewCellViewModel *vm5 = [[SJStaticTableviewCellViewModel alloc] init];
    vm5.leftImage = [UIImage imageNamed:@"CreditCard_ShoppingBag"];
    vm5.leftTitle = @"购物";
    vm5.identifier = 5;

    
    // ========== section 3
    SJStaticTableviewCellViewModel *vm6 = [[SJStaticTableviewCellViewModel alloc] init];
    vm6.leftImage = [UIImage imageNamed:@"MoreGame"];
    vm6.leftTitle = @"游戏";
    vm6.indicatorLeftImage = [UIImage imageNamed:@"wzry"];
    vm6.indicatorLeftTitle = @"一起来玩王者荣耀呀!";
    vm6.identifier = 7;
    
    
    SJStaticTableviewSectionViewModel *section3 = [[SJStaticTableviewSectionViewModel alloc] initWithCellViewModelsArray:@[vm5,vm6]];
    
    return @[section0,section1,section2,section3];
}
```
#### 发现页ViewController：
```objc
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationItem.title = @"发现";
}


- (void)createDataSource
{
    self.dataSource = [[SJStaticTableViewDataSource alloc] initWithViewModelsArray:[Factory momentsPageData] configureBlock:^(SJStaticTableViewCell *cell, SJStaticTableviewCellViewModel *viewModel) {
        
        switch (viewModel.staticCellType)
        {
            case SSJStaticCellTypeSystemAccessoryDisclosureIndicator:
            {
                [cell configureAccessoryDisclosureIndicatorCellWithViewModel:viewModel];
            }
                break;
                
            default:
                break;
        }
    }];
}
```
### 2.2 设置页

#### 效果图：
![设置页](http://oih3a9o4n.bkt.clouddn.com/sjstatictableview_3.png)

#### 数据源设置代码：
```objc
+ (NSArray *)settingPageData
{
    // ========== section 0
    SJStaticTableviewCellViewModel *vm0 = [[SJStaticTableviewCellViewModel alloc] init];
    vm0.leftTitle = @"账号与安全";
    vm0.identifier = 0;
    vm0.indicatorLeftTitle = @"已保护";
    vm0.indicatorLeftImage = [UIImage imageNamed:@"ProfileLockOn"];
    vm0.isImageFirst = NO;
    
    SJStaticTableviewSectionViewModel *section0 = [[SJStaticTableviewSectionViewModel alloc] initWithCellViewModelsArray:@[vm0]];
    
    
    // ========== section 1
    SJStaticTableviewCellViewModel *vm1 = [[SJStaticTableviewCellViewModel alloc] init];
    vm1.leftTitle = @"新消息通知";
    vm1.identifier = 1;
    
    //额外添加switch
    SJStaticTableviewCellViewModel *vm7 = [[SJStaticTableviewCellViewModel alloc] init];
    vm7.leftTitle = @"夜间模式";
    vm7.switchValueDidChangeBlock = ^(BOOL isON){
        NSString *message = isON?@"打开夜间模式":@"关闭夜间模式";
        NSLog(@"%@",message);
    };
    vm7.staticCellType = SSJStaticCellTypeSystemAccessorySwitch;
    vm7.identifier = 7;
    
    SJStaticTableviewCellViewModel *vm8 = [[SJStaticTableviewCellViewModel alloc] init];
    vm8.leftTitle = @"清理缓存";
    vm8.indicatorLeftTitle = @"12.3M";
    vm8.identifier = 8;
    
    SJStaticTableviewCellViewModel *vm2 = [[SJStaticTableviewCellViewModel alloc] init];
    vm2.leftTitle = @"隐私";
    vm2.identifier = 2;
    
    
    SJStaticTableviewCellViewModel *vm3 = [[SJStaticTableviewCellViewModel alloc] init];
    vm3.leftTitle = @"通用";
    vm3.identifier = 3;
    
    
    SJStaticTableviewSectionViewModel *section1 = [[SJStaticTableviewSectionViewModel alloc] initWithCellViewModelsArray:@[vm1,vm7,vm8,vm2,vm3]];
    
    // ========== section 2
    SJStaticTableviewCellViewModel *vm4 = [[SJStaticTableviewCellViewModel alloc] init];
    vm4.leftTitle = @"帮助与反馈";
    vm4.identifier = 4;
    
    SJStaticTableviewCellViewModel *vm5 = [[SJStaticTableviewCellViewModel alloc] init];
    vm5.leftTitle = @"关于微信";
    vm5.identifier = 5;
    
    SJStaticTableviewSectionViewModel *section2 = [[SJStaticTableviewSectionViewModel alloc] initWithCellViewModelsArray:@[vm4,vm5]];
    
    SJStaticTableviewCellViewModel *vm9 = [[SJStaticTableviewCellViewModel alloc] init];
    vm9.leftTitle = @"定制性cell展示页面 - 分组";
    vm9.identifier = 9;
    
    SJStaticTableviewCellViewModel *vm10 = [[SJStaticTableviewCellViewModel alloc] init];
    vm10.leftTitle = @"定制性cell展示页面 - 同组";
    vm10.identifier = 10;
    
    SJStaticTableviewSectionViewModel *section4 = [[SJStaticTableviewSectionViewModel alloc] initWithCellViewModelsArray:@[vm9,vm10]];
    
    
    // ========== section 3
    SJStaticTableviewCellViewModel *vm6 = [[SJStaticTableviewCellViewModel alloc] init];
    vm6.staticCellType = SSJStaticCellTypeSystemLogout;
    vm6.cellID = @"logout";
    vm6.identifier = 6;
    
    
    SJStaticTableviewSectionViewModel *section3 = [[SJStaticTableviewSectionViewModel alloc] initWithCellViewModelsArray:@[vm6]];
    
    return @[section0,section1,section2,section4,section3];
}
```

#### 设置页ViewController：
```objc
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
}


- (void)createDataSource
{
    self.dataSource = [[SJStaticTableViewDataSource alloc] initWithViewModelsArray:[Factory settingPageData] configureBlock:^(SJStaticTableViewCell *cell, SJStaticTableviewCellViewModel *viewModel) {
        
        switch (viewModel.staticCellType)
        {
            case SSJStaticCellTypeSystemAccessoryDisclosureIndicator:
            {
                [cell configureAccessoryDisclosureIndicatorCellWithViewModel:viewModel];
            }
                break;
                
            case SSJStaticCellTypeSystemAccessorySwitch:
            {
                [cell configureAccessorySwitchCellWithViewModel:viewModel];
            }
                break;
                
            case SSJStaticCellTypeSystemLogout:
            {
                [cell configureLogoutTableViewCellWithViewModel:viewModel];
            }
                break;
                
            case SSJStaticCellTypeSystemAccessoryNone:
            {
                [cell configureAccessoryNoneCellWithViewModel:viewModel];
            }
                break;
                
            default:
                break;
        }
    }];
}


- (void)didSelectViewModel:(SJStaticTableviewCellViewModel *)viewModel atIndexPath:(NSIndexPath *)indexPath
{
    
    switch (viewModel.identifier)
    {
            
        case 6:
        {
            NSLog(@"退出登录");
            [self showAlertWithMessage:@"真的要退出登录嘛？"];
        }
            break;
            
        case 8:
        {
            NSLog(@"清理缓存");
        }
            break;
            
        case 9:
        {
            NSLog(@"跳转到定制性cell展示页面 - 分组");
            SJCustomCellsViewController *vc = [[SJCustomCellsViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 10:
        {
            NSLog(@"跳转到定制性cell展示页面 - 同组");
            SJCustomCellsOneSectionViewController *vc = [[SJCustomCellsOneSectionViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}
```

## 3. 定制性展示
![分组定制 | 同组定制](http://oih3a9o4n.bkt.clouddn.com/sjstatictableview_2.png)


分组页面：
```objc
+ (NSArray *)customCellsPageData
{
    //默认配置
    SJStaticTableviewCellViewModel *vm1 = [[SJStaticTableviewCellViewModel alloc] init];
    vm1.leftImage = [UIImage imageNamed:@"MoreGame"];
    vm1.leftTitle = @"全部默认配置，用于对照";
    vm1.indicatorLeftImage = [UIImage imageNamed:@"wzry"];
    vm1.indicatorLeftTitle = @"王者荣耀!";
    
    SJStaticTableviewSectionViewModel *section1 = [[SJStaticTableviewSectionViewModel alloc] initWithCellViewModelsArray:@[vm1]];
    
    SJStaticTableviewCellViewModel *vm2 = [[SJStaticTableviewCellViewModel alloc] init];
    vm2.leftImage = [UIImage imageNamed:@"MoreGame"];
    vm2.leftTitle = @"左侧图片变小";
    vm2.indicatorLeftImage = [UIImage imageNamed:@"wzry"];
    vm2.indicatorLeftTitle = @"王者荣耀!";
    
    SJStaticTableviewSectionViewModel *section2 = [[SJStaticTableviewSectionViewModel alloc] initWithCellViewModelsArray:@[vm2]];
    section2.leftImageSize = CGSizeMake(20, 20);
    
    SJStaticTableviewCellViewModel *vm3 = [[SJStaticTableviewCellViewModel alloc] init];
    vm3.leftImage = [UIImage imageNamed:@"MoreGame"];
    vm3.leftTitle = @"字体变小变红";
    vm3.indicatorLeftImage = [UIImage imageNamed:@"wzry"];
    vm3.indicatorLeftTitle = @"王者荣耀!";
    
    SJStaticTableviewSectionViewModel *section3 = [[SJStaticTableviewSectionViewModel alloc] initWithCellViewModelsArray:@[vm3]];
    section3.leftLabelTextFont = [UIFont systemFontOfSize:8];
    section3.leftLabelTextColor = [UIColor redColor];
    
    
    SJStaticTableviewCellViewModel *vm4 = [[SJStaticTableviewCellViewModel alloc] init];
    vm4.leftImage = [UIImage imageNamed:@"MoreGame"];
    vm4.leftTitle = @"左侧两个控件距离变大";
    vm4.indicatorLeftImage = [UIImage imageNamed:@"wzry"];
    vm4.indicatorLeftTitle = @"王者荣耀!";
    
    SJStaticTableviewSectionViewModel *section4 = [[SJStaticTableviewSectionViewModel alloc] initWithCellViewModelsArray:@[vm4]];
    section4.leftImageAndLabelGap = 20;
    
    
    SJStaticTableviewCellViewModel *vm5 = [[SJStaticTableviewCellViewModel alloc] init];
    vm5.leftImage = [UIImage imageNamed:@"MoreGame"];
    vm5.leftTitle = @"右侧图片变小";
    vm5.indicatorLeftImage = [UIImage imageNamed:@"wzry"];
    vm5.indicatorLeftTitle = @"王者荣耀!";
    
    SJStaticTableviewSectionViewModel *section5 = [[SJStaticTableviewSectionViewModel alloc] initWithCellViewModelsArray:@[vm5]];
    section5.indicatorLeftImageSize = CGSizeMake(15, 15);
    
    
    SJStaticTableviewCellViewModel *vm6= [[SJStaticTableviewCellViewModel alloc] init];
    vm6.leftImage = [UIImage imageNamed:@"MoreGame"];
    vm6.leftTitle = @"右侧字体变大变蓝";
    vm6.indicatorLeftImage = [UIImage imageNamed:@"wzry"];
    vm6.indicatorLeftTitle = @"王者荣耀!";
    
    SJStaticTableviewSectionViewModel *section6 = [[SJStaticTableviewSectionViewModel alloc] initWithCellViewModelsArray:@[vm6]];
    section6.indicatorLeftLabelTextFont = [UIFont systemFontOfSize:18];
    section6.indicatorLeftLabelTextColor = [UIColor blueColor];
    
    
    SJStaticTableviewCellViewModel *vm7= [[SJStaticTableviewCellViewModel alloc] init];
    vm7.leftImage = [UIImage imageNamed:@"MoreGame"];
    vm7.leftTitle = @"右侧两个控件距离变大";
    vm7.indicatorLeftImage = [UIImage imageNamed:@"wzry"];
    vm7.indicatorLeftTitle = @"王者荣耀!";
    
    SJStaticTableviewSectionViewModel *section7 = [[SJStaticTableviewSectionViewModel alloc] initWithCellViewModelsArray:@[vm7]];
    section7.indicatorLeftImageAndLabelGap = 18;
    
    
    return @[section1,section2,section3,section4,section5,section6,section7];
    
}
```
>我们可以看到，定制的代码都作用于section的viewModel。

同组页面：

```objc
+ (NSArray *)customCellsOneSectionPageData
{
    //默认配置
    SJStaticTableviewCellViewModel *vm1 = [[SJStaticTableviewCellViewModel alloc] init];
    vm1.leftImage = [UIImage imageNamed:@"MoreGame"];
    vm1.leftTitle = @"全部默认配置，用于对照";
    vm1.indicatorLeftImage = [UIImage imageNamed:@"wzry"];
    vm1.indicatorLeftTitle = @"王者荣耀!";
    
    
    SJStaticTableviewCellViewModel *vm2 = [[SJStaticTableviewCellViewModel alloc] init];
    vm2.leftImage = [UIImage imageNamed:@"MoreGame"];
    vm2.leftTitle = @"左侧图片变小";
    vm2.indicatorLeftImage = [UIImage imageNamed:@"wzry"];
    vm2.indicatorLeftTitle = @"王者荣耀!";
    vm2.leftImageSize = CGSizeMake(20, 20);
    
    
    SJStaticTableviewCellViewModel *vm3 = [[SJStaticTableviewCellViewModel alloc] init];
    vm3.leftImage = [UIImage imageNamed:@"MoreGame"];
    vm3.leftTitle = @"字体变小变红";
    vm3.indicatorLeftImage = [UIImage imageNamed:@"wzry"];
    vm3.indicatorLeftTitle = @"王者荣耀!";
    vm3.leftLabelTextFont = [UIFont systemFontOfSize:8];
    vm3.leftLabelTextColor = [UIColor redColor];
    
    
    SJStaticTableviewCellViewModel *vm4 = [[SJStaticTableviewCellViewModel alloc] init];
    vm4.leftImage = [UIImage imageNamed:@"MoreGame"];
    vm4.leftTitle = @"左侧两个控件距离变大";
    vm4.indicatorLeftImage = [UIImage imageNamed:@"wzry"];
    vm4.indicatorLeftTitle = @"王者荣耀!";
    vm4.leftImageAndLabelGap = 20;
    
    
    SJStaticTableviewCellViewModel *vm5 = [[SJStaticTableviewCellViewModel alloc] init];
    vm5.leftImage = [UIImage imageNamed:@"MoreGame"];
    vm5.leftTitle = @"右侧图片变小";
    vm5.indicatorLeftImage = [UIImage imageNamed:@"wzry"];
    vm5.indicatorLeftTitle = @"王者荣耀!";
    vm5.indicatorLeftImageSize = CGSizeMake(15, 15);
    
    
    SJStaticTableviewCellViewModel *vm6= [[SJStaticTableviewCellViewModel alloc] init];
    vm6.leftImage = [UIImage imageNamed:@"MoreGame"];
    vm6.leftTitle = @"右侧字体变大变蓝";
    vm6.indicatorLeftImage = [UIImage imageNamed:@"wzry"];
    vm6.indicatorLeftTitle = @"王者荣耀!";
    vm6.indicatorLeftLabelTextFont = [UIFont systemFontOfSize:18];
    vm6.indicatorLeftLabelTextColor = [UIColor blueColor];
    
    
    SJStaticTableviewCellViewModel *vm7= [[SJStaticTableviewCellViewModel alloc] init];
    vm7.leftImage = [UIImage imageNamed:@"MoreGame"];
    vm7.leftTitle = @"右侧两个控件距离变大";
    vm7.indicatorLeftImage = [UIImage imageNamed:@"wzry"];
    vm7.indicatorLeftTitle = @"王者荣耀!";
    vm7.indicatorLeftImageAndLabelGap = 18;
    
    SJStaticTableviewSectionViewModel *section1 = [[SJStaticTableviewSectionViewModel alloc] initWithCellViewModelsArray:@[vm1,vm2,vm3,vm4,vm5,vm6,vm7]];
    
    return @[section1];
}
```
>为了方便比较，同组页面的定制和分组是一致的。我们可以看到，定制代码都作用于cell的viewModel上了。


## 4. 刷新数据源
----
支持更新数据源后，刷新数据源。比如在发现页模拟网络请求，在请求结束后更新某个cell的viewmodel：

```objc
//模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //请求成功x
        NSDictionary *responseDict = @{@"title_info":@"新游戏上架啦",
                                       @"title_icon":@"game_1",
                                       @"game_info":@"一起来玩斗地主呀！",
                                       @"game_icon":@"doudizhu"
                                       };
        //将要刷新cell的indexPath
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:3];
        
        //获取cell对应的viewModel
        SJStaticTableviewCellViewModel *viewModel = [self.dataSource tableView:self.tableView cellViewModelAtIndexPath:indexPath];
        
        if (viewModel) {
            //更新viewModel
            viewModel.leftTitle = responseDict[@"title_info"];
            viewModel.leftImage = [UIImage imageNamed:responseDict[@"title_icon"]];
            viewModel.indicatorLeftImage = [UIImage imageNamed:responseDict[@"game_icon"]];
            viewModel.indicatorLeftTitle = responseDict[@"game_info"];
            
            //刷新tableview
           [self.tableView reloadData];
        }
    });
```

效果图：

![](http://oih3a9o4n.bkt.clouddn.com/sjstatictableview_8.png)

## 5. 没有默认数据源的情况

SJStaticViewController在创建的时候分为两种情况:

```objc
//SJStaticTableViewController.h
typedef enum : NSUInteger {
    
    SJDefaultDataTypeExist,    //在表格生成之前就有数据（1. 完全不依赖网络请求，有现成的完整数据 2. 先生成默认数据，然后通过网络请求来更新数据并刷新表格）
    SJDefaultDataTypeNone,     //无法生成默认数据，需要完全依赖网络请求，在拿到数据后，生成表格
    
}SJDefaultDataType;

- (instancetype)initWithDefaultDataType:(SJDefaultDataType)defualtDataType;
```

```objc
//SJStaticTableViewController.m
- (instancetype)initWithDefaultDataType:(SJDefaultDataType)defualtDataType
{
    self = [super init];
    if (self) {
        self.defualtDataType = defualtDataType;
    }
    return self;
}

- (instancetype)init
{
    self = [self initWithDefaultDataType:SJDefaultDataTypeExist];//默认是SJDefaultDataTypeExist
    return self;
}
```

详细说明一下这两种情况：
1. SJDefaultDataTypeExist：在表格生成之前就存在数据，可以是表格的全部数据，也可以是表格的默认数据（后来通过网络请求来更新部分数据，参考上一节）。
2. SJDefaultDataTypeNone：意味着当前没有任何的默认数据可以使用，也就是无法生成tableview，需要在网络请求拿到数据后，再手动调用生成数据源，生成表格的方法。
```objc
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self configureNav];
    
    //在能够提供给tableivew全部，或者部分数据源的情况下，可以先构造出tableview；
    //否则，需要在网络请求结束后，手动调用configureTableView方法
    if (self.defualtDataType == SJDefaultDataTypeExist) {
        [self configureTableView];
    }
}

//只有在SJDefaultDataTypeExist的时候才会自动调用，否则需要手动调用
- (void)configureTableView
{
    [self createDataSource];//生成数据源
    [self createTableView];//生成表格
}
```
看一个例子，我们将表情页设置为``SJDefaultDataTypeNone``，那么就意味着我们需要手动调用``configureTableView``方法：

```objc
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
     self.navigationItem.title = @"表情";
    [self networkRequest];
}


- (void)networkRequest
{
    [MBProgressHUD showHUDAddedTo: self.view animated:YES];
    
    //模拟网络请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [MBProgressHUD hideHUDForView: self.view animated:YES];
         self.modelsArray = [Factory emoticonPage];//网络请求后，将数据保存在self.modelsArray里面
        [self configureTableView];//手动调用
        
    });
}

- (void)createDataSource
{
    self.dataSource = [[SJStaticTableViewDataSource alloc] initWithViewModelsArray:self.modelsArray configureBlock:^(SJStaticTableViewCell *cell, SJStaticTableviewCellViewModel *viewModel) {
        
        switch (viewModel.staticCellType) {
                
            case SJStaticCellTypeSystemAccessoryDisclosureIndicator:
            {
                [cell configureAccessoryDisclosureIndicatorCellWithViewModel:viewModel];
            }
                break;
                
            default:
                break;
        }
    }];
}
```

看一下效果图：
![](http://oih3a9o4n.bkt.clouddn.com/sjstatictableview_9.png)

## License

SJStaticTableView is released under the MIT license. 

