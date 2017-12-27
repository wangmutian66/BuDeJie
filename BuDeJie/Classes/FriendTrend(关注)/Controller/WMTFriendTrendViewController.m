//
//  WMTFriendTrendViewController.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/14.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "WMTFriendTrendViewController.h"

@interface WMTFriendTrendViewController ()

@end

@implementation WMTFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNarBar];
}

-(void)setupNarBar{
    
    //左边的按钮
    //把UIButton包装在buttonitem. 就导致按钮点击扩大
    
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem itemWithimage1:[UIImage imageNamed:@"friendsRecommentIcon"] hightImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    
    //titleView
    self.navigationItem.title= @"我的关注";
    
}

// 推荐关注
-(void)friendsRecomment{
    
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
