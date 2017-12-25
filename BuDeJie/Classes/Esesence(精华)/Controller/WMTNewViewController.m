//
//  WMTNewViewController.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/14.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "WMTNewViewController.h"
#import "WMTSubTagViewController.h"

@interface WMTNewViewController ()

@end

@implementation WMTNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor brownColor];
    [self setupNarBar];
}

-(void)setupNarBar{
    
    //左边的按钮
    //把UIButton包装在buttonitem. 就导致按钮点击扩大
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithimage1:[UIImage imageNamed:@"MainTagSubIcon"] hightImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(tagclick)];
 
    //titleView
    self.navigationItem.titleView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
}

#pragma mark - 点击订阅标签调用
-(void)tagclick{
    //进入推荐标签界面
    WMTSubTagViewController *subtag=[[WMTSubTagViewController alloc] init];
    [self.navigationController pushViewController:subtag animated:YES];
    
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
