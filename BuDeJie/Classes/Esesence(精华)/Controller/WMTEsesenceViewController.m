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
#import "WMTAllViewController.h"
#import "WMTPictureViewController.h"
#import "WMTViewViewController.h"
#import "WMTVoiceViewController.h"
#import "WMTWordViewController.h"


@interface WMTEsesenceViewController ()
//标题栏
@property (nonatomic,weak) UIView *titlesValue;
//下划线
@property (nonatomic,weak) UIView *titlesUnderline;
//记录上一次点击标题按钮
@property(nonatomic,weak) UIButton *previousClicked;
@end

@implementation WMTEsesenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor brownColor];
    
    // Do any additional setup after loading the view.
    [self setupNarBar];
    
    //初始化自控制器
    [self setupAllChildVcs];
    //scrollview
    [self setupScrollView];
    
    //标题栏
    [self setupTitleView];
}

-(void)setupAllChildVcs{
    [self addChildViewController:[[WMTAllViewController alloc] init]];
    [self addChildViewController:[[WMTPictureViewController alloc] init]];
    [self addChildViewController:[[WMTViewViewController alloc] init]];
    [self addChildViewController:[[WMTVoiceViewController alloc] init]];
    [self addChildViewController:[[WMTWordViewController alloc] init]];
}

//滚动条是 tabBar  是叫scroll 的内容向下移动 64
-(void) setupScrollView{
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    scrollview.backgroundColor =[UIColor greenColor];
    scrollview.frame= self.view.bounds;
    [self.view addSubview:scrollview];
    
//    for(NSInteger i = 0; i<5;i++){
//        UITableView *tableview = [[UITableView alloc] init];
////        tableview.wmt_width = scrollview.wmt_width;
////        tableview.wmt_height=scrollview.wmt_height;
////        tableview.wmt_y = 0;
////        tableview.wmt_x=scrollview.wmt_width*i;
//        tableview.frame=CGRectMake(scrollview.wmt_width*i, 0, scrollview.wmt_width, scrollview.wmt_height);
//        if(i%2==0){
//            tableview.backgroundColor=[UIColor grayColor];
//        }
//        [scrollview addSubview:tableview];
//    }
    for(NSInteger i =0;i<5;i++){
        UIViewController *childVc=self.childViewControllers[i];
        //自控制器的view
        
        UIView *childView=childVc.view;
        childView.frame=CGRectMake(scrollview.wmt_width*i, 54, scrollview.wmt_width, scrollview.wmt_height - 54);
        [scrollview addSubview:childView];
        
    }
    
    scrollview.contentSize = CGSizeMake(5 *scrollview.wmt_width , 0);
    
    
    /*
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 100,50);
    [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@""]  forState:UIControlStateNormal];
    [scrollview addSubview:btn];
     */
}



//标题
-(void)setupTitleView{
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.5];
//    titleView.backgroundColor =[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
//    titleView.alpha=0.5;
    titleView.frame= CGRectMake(0, 64, self.view.wmt_width, 35);
    self.titlesValue=titleView;
    [self.view addSubview:titleView];
    
    //标题栏按钮
    [self setupTitleButtons];
    
    //下划线
    [self setuptitleUnderline];
}

-(void)setupTitleButtons{
    NSArray *titlearr=@[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSUInteger count = titlearr.count;
    CGFloat titleButtonW=self.titlesValue.wmt_width / count;
    CGFloat titleButtonH=self.titlesValue.wmt_height;
    
    for (NSInteger i=0; i < count; i++) {
        UIButton *titleButton = [[UIButton alloc] init];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesValue addSubview:titleButton];
        [titleButton setTitleColor:[UIColor darkGrayColor]  forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor]  forState:UIControlStateSelected];
        titleButton.frame=CGRectMake(titleButtonW * i, 0, titleButtonW, titleButtonH);
        [titleButton setTitle:titlearr[i] forState:UIControlStateNormal];
        
    }
}
-(void)titleButtonClick:(UIButton *) titleButton{
//    self.previousClicked=titleButton;
//    [self.previousClicked setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    //[titleButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.previousClicked.selected=NO;
    titleButton.selected=YES;
    self.previousClicked = titleButton;
    
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat centerx=titleButton.center.x;
//        [titleButton titleForState:UIControlStateNormal]; 获取图片的文字
        self.titlesUnderline.wmt_width= [titleButton.currentTitle sizeWithFont:titleButton.titleLabel.font].width;
        
        self.titlesUnderline.wmt_centerX = centerx;
    }];
    
}
-(void)setuptitleUnderline{
    
    UIButton *btn=self.titlesValue.subviews.firstObject;
    
    
    UIView *titleUnderline= [[UIView alloc] init];
    titleUnderline.frame= CGRectMake(0, self.titlesValue.wmt_height - 2, 70, 2);

    titleUnderline.backgroundColor = [btn titleColorForState:UIControlStateSelected];
    [self.titlesValue addSubview:titleUnderline];
    self.titlesUnderline = titleUnderline;
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
