//
//  WMTADViewController.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/19.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "WMTADViewController.h"
#import "AFNetWorking/AFNetWorking.h"

@interface WMTADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *LaunchImageView;
@property (weak, nonatomic) IBOutlet UIView *addContainView;


@end

@implementation WMTADViewController

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
    
    AFHTTPSessionManager *mgr=[AFHTTPSessionManager manager];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    [mgr GET:@"" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
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
