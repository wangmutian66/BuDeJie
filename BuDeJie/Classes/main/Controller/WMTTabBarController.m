//
//  WMTTabBarController.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/14.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "WMTTabBarController.h"
#import "WMTMeTiewController.h"
#import "WMTNewViewController.h"
#import "WMTPublishViewController.h"
#import "WMTEsesenceViewController.h"
#import "WMTFriendTrendViewController.h"
#import "UIImage+Image.h"
#import "WMTTabBar.h"
#import "WMTNavigationViewController.h"


@interface WMTTabBarController ()

@end

@implementation WMTTabBarController

//只会调用一次
+(void) load{
    /*
     只有在控件之前显示才有意义
     appearance:
     */
    // 获取UITabarItem
    
    //获取整个程序下的UITabBarItem
    //UITabBarItem *item=[UITabBarItem appearance];
    UITabBarItem *item=[UITabBarItem appearanceWhenContainedIn:self, nil];
    //创建一个描述文本属性的字典
    //设置按钮中标题的颜色 富文本 描述一个文字的颜色
    NSMutableDictionary *atrr=[NSMutableDictionary dictionary];
    atrr[NSForegroundColorAttributeName]=[UIColor blackColor];
    [item setTitleTextAttributes:atrr forState:UIControlStateSelected];
    //设置字体尺寸：只有正常状态下，才会有效果
    NSMutableDictionary *atrrMol=[NSMutableDictionary dictionary];
    atrrMol[NSFontAttributeName]=[UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:atrrMol forState:UIControlStateNormal];
}


//注意可能会调用多次
//+(void) initialize
//{
//    if(self == [WMTTabBarController class]){
//
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupAllViewController];
    
    //2.2 设置tableBar   上 按钮的内容 #df0912
    [self setUpAllTileButton];
    
    //自定义tabBar
    [self setupTabBar];
    
}

//系统的tabBar在这里被占用
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSLog(@"----->%@",self.tabBar.subviews);
}

-(void)setupTabBar{
    WMTTabBar *tabBar=[[WMTTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
//    self.tabBar=tabBar;
}

-(void)setupAllViewController{
    // 精华
    WMTEsesenceViewController *essence =[[WMTEsesenceViewController alloc] init];
    WMTNavigationViewController *nav=[[WMTNavigationViewController alloc] initWithRootViewController:essence];
    [self addChildViewController:nav];
    // 新帖
    WMTNewViewController *newVC =[[WMTNewViewController alloc] init];
    WMTNavigationViewController *nav1=[[WMTNavigationViewController alloc] initWithRootViewController:newVC];
    [self addChildViewController:nav1];
    // 发布
//    WMTPublishViewController *publish =[[WMTPublishViewController alloc] init];
    //UINavigationController *nav2=[[UINavigationController alloc] initWithRootViewController:publish];
//    [self addChildViewController:publish];
    
    
    // 关注
    WMTFriendTrendViewController *friend =[[WMTFriendTrendViewController alloc] init];
    WMTNavigationViewController *nav3=[[WMTNavigationViewController alloc] initWithRootViewController:friend];
    [self addChildViewController:nav3];
    // 我
    WMTMeTiewController *me =[[WMTMeTiewController alloc] init];
    WMTNavigationViewController *nav4=[[WMTNavigationViewController alloc] initWithRootViewController:me];
    [self addChildViewController:nav4];
}


//设置tabBar 上的内容
-(void)setUpAllTileButton{
    UINavigationController *nav=self.childViewControllers[0];
    nav.tabBarItem.title=@"精华";
    nav.tabBarItem.image=[UIImage imageNamed:@"na"];
    //快速生成一个没有渲染的图片
    nav.tabBarItem.selectedImage=[UIImage imageOriginalWithName:@"na1hover"];
    
    
    
    
    UINavigationController *nav1=self.childViewControllers[1];
    nav1.tabBarItem.title=@"精华";
    nav1.tabBarItem.image=[UIImage imageNamed:@"na2"];
    nav1.tabBarItem.selectedImage=[UIImage imageOriginalWithName:@"na2hover"];
    
//     WMTPublishViewController *publish=self.childViewControllers[2];
//    //publish.tabBarItem.title=@"发布";
//    publish.tabBarItem.image=[UIImage imageNamed:@"na3"];
//    publish.tabBarItem.selectedImage=[UIImage imageOriginalWithName:@"jiaclick"];
    //设置图片的位置
    //publish.tabBarItem.imageInsets=UIEdgeInsetsMake(3,0,-3,0);
    
    
   UINavigationController *nav3=self.childViewControllers[2];
    nav3.tabBarItem.title=@"精华";
    nav3.tabBarItem.image=[UIImage imageNamed:@"na4"];
    nav3.tabBarItem.selectedImage=[UIImage imageOriginalWithName:@"na4hover"];
    
    UINavigationController *nav4=self.childViewControllers[3];
    nav4.tabBarItem.title=@"我";
    nav4.tabBarItem.image=[UIImage imageNamed:@"na5"];
    nav4.tabBarItem.selectedImage=[UIImage imageOriginalWithName:@"na5hover"];
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
