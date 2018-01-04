//
//  WMTADViewController.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/19.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "WMTADViewController.h"
#import "AFNetWorking/AFNetWorking.h"
#import "MJExtension/MJExtension.h"
#import "UIImageView+WebCache.h"
#import "WMTADItem.h"
#import "WMTTabBarController.h"


#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"
@interface WMTADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *LaunchImageView;
@property (weak, nonatomic) IBOutlet UIView *addContainView;
@property(nonatomic,weak) UIImageView *adView;
@property(nonatomic,strong) WMTADItem * item1;
//@property (weak, nonatomic) IBOutlet UIImageView *LaunchImageView;
@property (weak, nonatomic) IBOutlet UIButton *jumpBtn;

@property(nonatomic,weak) NSTimer *timer;
@end

@implementation WMTADViewController
- (IBAction)click_jump:(id)sender {
    //修改按钮的时间
    
    //销毁广告
    WMTTabBarController *tabBarVc=[[WMTTabBarController alloc] init];
    
    [UIApplication sharedApplication].keyWindow.rootViewController=tabBarVc;
    //干掉定时器
    [_timer invalidate];
}

-(UIImageView *) adView{
    if(_adView == nil){
        UIImageView *imageView=[[UIImageView alloc] init];
        [self.addContainView addSubview:imageView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
        imageView.userInteractionEnabled = YES;
        _adView=imageView;
    }
    return _adView;
}

//点击广告界面调用的方法
-(void)tap{
    // 跳转界面 = 》 safari
    NSLog(@"%@",_item1.w_picurl);
    
    NSURL *url=[NSURL URLWithString:_item1.w_picurl];
    UIApplication *app=[UIApplication sharedApplication];
    
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
    
    //[[UIApplication sharedApplication] canOpenURL:url];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupLaunchImage];
    
    //加载数据
    //cocodpods步骤
    //1.找到根目录touch podfile
    //2.打开open podfile
    /* 3.编写如下代码
         platform :ios, '8.0'
         #use_frameworks!个别需要用到它，比如reactiveCocoa
     
         def pods
         pod 'AFNetworking', '~> 3.0.4’
         pod 'ORStackView', '~> 3.0'
     
         end
         target ‘BuDeJie’ do
         pods
         end
     */
    //4.安装第三方框架 pod install --no-repo-update
    //加载广告数据 => 拿到活时间 => 服务器 =>查看接口文档 1 判断接口对不对 2 解析数据（w_picurl,ori_curl:跳转到广告界面,w,h）
    //=> 请求数据（AFN）
    [self loadData];
   //创建定时器
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
}

-(void)timeChange{
//    [timenumber setTitle:@"0" forState:nil];
    static int i=3;
    if(i==0){
        //修改按钮的时间

        //销毁广告
        WMTTabBarController *tabBarVc=[[WMTTabBarController alloc] init];

        [UIApplication sharedApplication].keyWindow.rootViewController=tabBarVc;
        //干掉定时器
        [_timer invalidate];

        [self click_jump:nil];
    }
    i--;
     [_jumpBtn setTitle:[NSString stringWithFormat:@"跳过(%d)",i] forState:UIControlStateNormal];
}


/*
 http://mobads.baidu.com/cpro/ui/mads.php?code2=phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam
 */

-(void)loadData{
    //1.创建请求会话管理者
    AFHTTPSessionManager *mgr=[AFHTTPSessionManager manager];
    //2.拼接参数
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"code2"]=code2;
    //3.发送请求
    
    //点击项目 进入 info 添加-> "App Transport Security Settings" 在子下在添加 -> "Allow Arbitrary Loads" 配置写yes
    /*
     AFURLResponseSerialization.m中修改代码就能解决：
     修改文件223行处
     self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", nil nil];
     为
     self.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil nil];
     */
    
    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *_Nullable responseObject) {
        [responseObject writeToFile:@"/Users/apple/Desktop/plist/ad.plist" atomically:YES];
        NSDictionary *adDict=[responseObject[@"ad"] lastObject];
        //字典转模型
        _item1= [WMTADItem mj_objectWithKeyValues:adDict];
        
        CGFloat h =  WMTScreenW/_item1.w*_item1.h;
        //_item1.ori_curl;
        
        
        self.adView.frame = CGRectMake(0, 0,WMTScreenW, h);
        //加载广告数据
        [self.adView sd_setImageWithURL:[NSURL URLWithString:_item1.w_picurl]];
        
        
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



-(void) setupLaunchImage{
    //设置启动图片
    //6p  LaunchImage-800-Portrait-736h@3x
    //6 LaunchImage-800-667h@2x
    //5 LaunchImage-568h@2x
    //4s LaunchImage@2x
//    self.LaunchImageView.image  = [UIImage imageNamed:];
    if(iphone6p){
        self.LaunchImageView.image  = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iphone6){
        self.LaunchImageView.image  = [UIImage imageNamed:@"LaunchImage-800-667h@2x"];
    } else if (iphone5){
        self.LaunchImageView.image  = [UIImage imageNamed:@"LaunchImage@2x"];
    } else if (iphone4s){
        self.LaunchImageView.image  = [UIImage imageNamed:@"LaunchImage@2x"];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
