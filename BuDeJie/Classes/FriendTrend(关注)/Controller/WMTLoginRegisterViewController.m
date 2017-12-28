//
//  WMTLoginRegisterViewController.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/27.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "WMTLoginRegisterViewController.h"
#import "WMTLoginRegister.h"
@interface WMTLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *middleView;

@end

@implementation WMTLoginRegisterViewController
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickRegister:(UIButton *)sender {
    sender.selected=!sender.selected;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    //创建登录的view
//    WMTLoginRegister *loginView=[WMTLoginRegister loginView];
//    // 添加到中间的view
//    [self.middleView addSubview:loginView];
    
    //创建登录的view
    WMTLoginRegister *registerView=[WMTLoginRegister registerView];
    // 添加到中间的view
    [self.middleView addSubview:registerView];
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
