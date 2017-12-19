//
//  WMTNavigationViewController.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/18.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "WMTNavigationViewController.h"

@interface WMTNavigationViewController () <UIGestureRecognizerDelegate>

@end

@implementation WMTNavigationViewController

+(void)load
{
    UINavigationBar *narBar=[UINavigationBar appearanceWhenContainedIn:self, nil];
    //设置导航条的标题
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName]=[UIFont boldSystemFontOfSize:20];
    [narBar setTitleTextAttributes:attrs];
   
    [narBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //控制我们的手势什么时候被触发，只有非根控制器 的时候
    self.interactivePopGestureRecognizer.delegate=self;
    //假死状态：程序还在运行 但是界面死了
}

#pragma mark - UIGestureRecognizerDelegate
//觉得是否触发手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    return self.childViewControllers.count>1;
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
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //在这里设置返回按钮,只有非跟控制器才有返回按钮
    if(self.childViewControllers.count>0){ //判断非根控制器
        // 恢复滑动返回功能
        //1.手势被清空 2.可能手势代理做了一些事情
        viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem backItemWithimage1:[UIImage imageNamed:@"navigationButtonReturn"]  hightImage:[UIImage imageNamed:@"navigationButtonReturnClick"]  target:self action:@selector(back) title:@"返回"];
    }
    // 这句话才是真正的跳转
    [super pushViewController:viewController animated:animated];
    
}
-(void) back{
    [self popViewControllerAnimated:YES];
}

@end
