//
//  AppDelegate.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/14.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "AppDelegate.h"
#import "WMTTabBarController.h"
#import "WMTADViewController.h"

//每次程序启动的时候进入广告界面
//1.在启动的时候去 加一个广告位
//2.在启动完成 的时候加个广告位 （展示了一个启动图片）
/*
 方案1.程序一启动就进入广告界面，窗口的根控制器设置为广告位
 方案2.加上一个广告界面，等几秒过去了，再去广告界面移除
 */
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //1.创建一个windows
//    self.window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //2.设置窗口根控制器
    WMTTabBarController *tarBarVc=[[WMTTabBarController alloc] init];
//    WMTADViewController *adVc = [[WMTADViewController alloc] init];
    
    
//    self.window.rootViewController =  adVc;
    self.window.rootViewController =  tarBarVc;
    //2.1 添加子控制器（5 个子控件） 自定义控制器 划分项目文件结构
    
    //3.显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
