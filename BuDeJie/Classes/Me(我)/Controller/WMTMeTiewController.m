//
//  WMTMeTiewController.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/14.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "WMTMeTiewController.h"
#import "WMTSettingViewController.h"
static NSString * const ID=@"cell";
@interface WMTMeTiewController () <UICollectionViewDataSource>

@end

@implementation WMTMeTiewController

- (void)viewDidLoad {
    [super viewDidLoad];
//     self.automaticallyAdjustsScrollViewInsets = NO; 
    [self setupNarBar];
    // 设置tableView 底部视图
    [self setupFootView];
}


-(void) setupFootView{
    /*
        1.初始化要设置流水布局
        2.cell 必须要注册
       3.cell 必须要自定义
     */
    //创建布局
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout alloc];
    // 创建UICollectionView
    UICollectionView *collectionView =[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    collectionView.backgroundColor=[UIColor redColor];
    self.tableView.tableFooterView=collectionView;
    collectionView.dataSource=self;
    
    //注册cell
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

//-(UICollectionViewCell *) collection

- (UICollectionViewCell *) collectionView:(UICollectionView *) collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
     // 从缓存池取
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor=[UIColor greenColor];
    return cell;
   
    
}


-(void)setupNarBar{
    
    //左边的按钮
    //把UIButton包装在buttonitem. 就导致按钮点击扩大
    UIBarButtonItem *settingItem= [UIBarButtonItem itemWithimage1:[UIImage imageNamed:@"mine-moon-icon"] hightImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:nil];
    UIBarButtonItem *nightItem= [UIBarButtonItem itemWithimage1:[UIImage imageNamed:@"mine-setting-icon"] hightImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    self.navigationItem.rightBarButtonItems=@[nightItem,settingItem];
    
    //titleView
    self.navigationItem.title= @"我的";
    // 只要是通过模型设置，都是通过富文本设置
   
    
}


-(void)setting{
    WMTSettingViewController *settingVc=[[WMTSettingViewController alloc] init];
//    settingVc
    //隐藏底部条
    //这个属性必须要在跳转之前设置
    settingVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settingVc animated:YES];
    
}



@end
