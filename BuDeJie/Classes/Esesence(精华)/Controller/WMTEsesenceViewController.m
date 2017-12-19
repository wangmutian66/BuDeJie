//
//  WMTEsesenceViewController.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/14.
//  Copyright © 2017年 wangmutian. All rights reserved.
//
//UIBarButtonItem:描述按钮具体的内容
//UINavigationItem:设置导航条上的内容(左边，右边，中间)
//设置tabBar上按钮的内容（tabBarButton按钮上的东西 ）

#import "WMTEsesenceViewController.h"

@interface WMTEsesenceViewController ()

@end

@implementation WMTEsesenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor brownColor];
    
    // Do any additional setup after loading the view.
    [self setupNarBar];
}

-(void)setupNarBar{
    
    //左边的按钮
    //把UIButton包装在buttonitem. 就导致按钮点击扩大
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithimage1:[UIImage imageNamed:@"nav_item_game_icon"] hightImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    //设置右边的按钮
     self.navigationItem.rightBarButtonItem=[UIBarButtonItem itemWithimage1:[UIImage imageNamed:@"navigationButtonRandom"] hightImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:nil];
    //titleView
    self.navigationItem.titleView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}

-(void)gethttp{
//    // 1.创建请求会话管理者
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    
//    // 2.拼接参数
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"code2"] = code2;
//    
//    // 3.发送请求
//    [mgr GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        // 请求数据 -> 解析数据 -> 展示数据
//        
//        NSLog(@"%@",responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error);
//    }];
}



-(void)game{
    WMTFun;
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
