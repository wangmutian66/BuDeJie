//
//  WMTAllViewController.m
//  BuDeJie
//
//  Created by wangmutian on 2018/1/11.
//  Copyright © 2018年 wangmutian. All rights reserved.
//

#import "WMTAllViewController.h"
#import "WMTTabBarController.h"
#import "AFNetWorking/AFNetWorking.h"
#import "MJExtension/MJExtension.h"
#import "WMTSubTagItem.h"
#import "WMTSubTagcel.h"
#import "SVProgressHUD/SVProgressHUD.h"
#import "WMTTopic.h"
#import "WMTTopicCell.h"

//#define baseurl @"http://api.budejie.com/api/api_open.php";
NSString const *baseURL =@"http://api.budejie.com/api/api_open.php";
@interface WMTAllViewController ()
/** 用来缓存 cell 高度 （key ：模型, value:cell 高度）**/
@property (nonatomic,strong) NSMutableDictionary *cellHeightDict;
/** 当前最后一条帖子数据的描述信息，专门用来加载下一页数据 */
@property (nonatomic, copy) NSString *maxtime;
///**页码**/
//@property(nonatomic,assign) NSUInteger page;
/**所有帖子数据**/
@property(nonatomic,strong) NSMutableArray *topics;
/**数据量**/
@property(nonatomic,assign) NSInteger dataCount;
/**上拉刷新控件里面的文字**/
@property(nonatomic,weak) UILabel *footerLabel;
/**上拉刷新控件**/
@property(nonatomic,weak) UIView *footer;
/**上拉刷新刷新控件时候正在刷新**/
@property(nonatomic,assign,getter=isFooterRefeshing) BOOL footerRefreshing;

/**下拉刷新刷新控件时候正在刷新**/
@property(nonatomic,assign,getter=isHeaderRefeshing) BOOL headerRefreshing;
/**下拉刷新控件里面的文字**/
@property(nonatomic,weak) UILabel *headerLabel;
/**下拉刷新控件**/
@property(nonatomic,weak) UIView *header;


@end

@implementation WMTAllViewController

/**cell 的重用标识**/
static NSString * const WMTTopicCellId = @"WMTTopicCellId";

-(NSMutableDictionary *)cellHeightDict{
    if(!_cellHeightDict){
        _cellHeightDict = [NSMutableDictionary dictionary];
    }
    return _cellHeightDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor colorWithRed:206/256.0 green:206/256.0 blue:206/256.0 alpha:1];
//    self.view.backgroundColor =[UIColor grayColor];
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    //去掉cell 的分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
//    self.dataCount=7;
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WMTTopicCell class]) bundle:nil] forCellReuseIdentifier:WMTTopicCellId];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:nil object:nil];
//    self.tableView.rowHeight = 300;
    [self setupRefresh];
}

-(void)setupRefresh{
    
    //header
    UIView *header= [[UIView alloc] init];
    header.frame=CGRectMake(0, -50, self.tableView.wmt_width, 50);
    UILabel *headerLabel=[[UILabel alloc] init];
    headerLabel.frame=header.bounds;
    headerLabel.backgroundColor=[UIColor blueColor];
    headerLabel.text=@"下拉可以刷新";
    headerLabel.textColor=[UIColor whiteColor];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    [header addSubview:headerLabel];
    self.headerLabel=headerLabel;
    self.header=header;
//    self.tableView.tableHeaderView = header;
    [self.tableView addSubview:header];
    
    //进来后自动刷新
     [self headerBeginRefreshing];
    
    //footer
    UIView *footer= [[UIView alloc] init];
    footer.frame=CGRectMake(0, 0, self.tableView.wmt_width, 35);
    UILabel *footerLabel=[[UILabel alloc] init];
    footerLabel.frame=footer.bounds;
    footerLabel.backgroundColor=[UIColor blueColor];
    footerLabel.text=@"上拉加载更多";
    footerLabel.textColor=[UIColor whiteColor];
    footerLabel.textAlignment = NSTextAlignmentCenter;
    [footer addSubview:footerLabel];
    self.footerLabel=footerLabel;
    self.footer=footer;
    self.tableView.tableFooterView = footer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    self.footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}




//松开scrollView 时调用
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(self.isHeaderRefeshing) return;
    CGFloat offsetY= - (self.tableView.contentInset.top + self.header.wmt_height);
    if(self.tableView.contentOffset.y <= offsetY){ //header 已经出现
        [self headerBeginRefreshing];
    }
}


-(void) headerBeginRefreshing{
    self.headerLabel.text=@"正在刷新新数据...";
    self.headerRefreshing=YES;
    
    //增加内边距
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets insert = self.tableView.contentInset;
        insert.top += self.header.wmt_height;
        self.tableView.contentInset = insert;
    }];
    
    //发送数据请求
    [self loadNewTopic];
    
}

-(void)loadNewTopic{

    
    AFHTTPSessionManager *mgr=[AFHTTPSessionManager manager];
     NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"a"]=@"list";
    parameters[@"c"]=@"data";
     parameters[@"type"]=@"1";//31 音频数据
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典数组 - 》 模型数组
        self.topics = [WMTTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self headEndRefreshing];
//        NSLog(@"请求成功！！！");
        WMTAfwriteToPlist(@"1111d")
        //防止字典里的数据越来越多 清除之前计算的高度
        [self.cellHeightDict removeAllObjects];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败！！！");
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，稍后重试"];
        //结束刷新
        [self headEndRefreshing];
        
        
    }];
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //假设服务器到这里回来
//        self.dataCount=7;
//        [self.tableView reloadData];
//        //结束刷新
//        [self headEndRefreshing];
//    });
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    static NSString *ID = @"id";
//    // Configure the cell...
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if(cell == nil){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//        cell.backgroundColor = [UIColor clearColor];
//    }
//     NSLog(@"%@",self.topics);
//    WMTTopic *topic=self.topics[indexPath.row];
//
//    cell.textLabel.text=topic.name;
//    cell.detailTextLabel.text=topic.text;
//    return cell;
    WMTTopicCell *cell  = [tableView dequeueReusableCellWithIdentifier:WMTTopicCellId];
//    if(cell  == nil){
//        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WMTTopicCell class]) owner:nil options:nil].firstObject;
//    }
    cell.topic=self.topics[indexPath.row];
//    @"😀"; control + command + 空格 - > 弹出emoji 表情键盘
    return cell;
    
}
//-(void)loadNewData{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //假设服务器到这里回来
//        self.dataCount=7;
//        [self.tableView reloadData];
//        //结束刷新
//        [self headEndRefreshing];
//    });
//}

//结束刷洗
-(void)headEndRefreshing{
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets insert = self.tableView.contentInset;
        insert.top -= self.header.wmt_height;
        self.tableView.contentInset = insert;
        //                self.headerLabel.text=@"下拉可以刷新";
        self.headerRefreshing=NO;
    }];
    
}

#pragma mark - 代理方法
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //处理header
    [self dealHeader];
    //处理footer下拉刷新
    [self dealFoote];
}

/**
 * 处理header
 */
-(void)dealHeader{
    
    if(self.isHeaderRefeshing) return;
    //当我们的scrollView 偏移量y值 <= offsetY,代表header 已经完全出现
    //99是顶部的高度 50 是 刷新的高度
    CGFloat offsetY = -(99 + 50);
    if(self.tableView.contentOffset.y <= offsetY){
        self.headerLabel.text=@"松开立即刷新";
    } else {
        self.headerLabel.text=@"下拉可以刷新";
    }
    
}

/**
 * 处理footer
 */
-(void)dealFoote{
    //还没有任何内容的时候
    if (self.tableView.contentSize.height == 0) return;
    
    //如果正在刷新就，就直接返回
    if(self.isFooterRefeshing) return ;
    
    
    //    NSLog(@"%f",scrollView.contentOffset.y);
    //contentOffset.y = 内容高度 + 底部内边距  - frame高度
    CGFloat  ofsetY=self.tableView.contentSize.height + self.tableView.contentInset.bottom  - self.tableView.wmt_height;
    //footer完全出现，并不是往上拖拽
    //当数量少的时候下拉刷新 footer也是完全显示的 所以需要判断一下 self.tableView.contentOffset.y>-99
    if(self.tableView.contentOffset.y >= ofsetY && self.tableView.contentOffset.y>-99){
        self.footerRefreshing=YES;
        //        NSLog(@"走到这里了！！！！！！");
        self.footerLabel.text=@"正在加载更多数据....";
        self.footerLabel.backgroundColor=[UIColor blueColor];
        //时间是2秒钟
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC )),
//                       dispatch_get_main_queue(),^{
//                           _dataCount+=10;
//                           [self.tableView reloadData];
//                           self.footerRefreshing=NO;
//                           self.footerLabel.text=@"上拉加载更多";
//                           self.footerLabel.textColor=[UIColor whiteColor];
//                       });
        [self loadmoretopics];
    }
    
}

//
-(void)loadmoretopics{
    AFHTTPSessionManager *mgr=[AFHTTPSessionManager manager];
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"a"]=@"list";
    parameters[@"c"]=@"data";
    parameters[@"type"]=@"1";//31 音频数据
    parameters[@"maxtime"]=self.maxtime;
    
    
//    self.page++;
//    parameters[@"page"]=@(self.page);
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
         self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典数组 - 》 模型数组
        NSArray *moretopics = [WMTTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moretopics];
        
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self footerEndRefreshing];
        
//        self.page = [parameters[@"page"] integerValue];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败！！！");
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，稍后重试"];
        //结束刷新
        [self footerEndRefreshing];
        //失败的时候来个
//        self.page--;
    }];
}
-(void)footerEndRefreshing{
    self.footerRefreshing=NO;
    self.footerLabel.text=@"上拉加载更多";
    self.footerLabel.textColor=[UIColor whiteColor];
}

#pragma 代理方法
/*
 这个方法的特点
 1.默认情况下
  1》. 每次刷新表格的时候，有多少数据，这个方法就一次性调用多少次 （比如有100条数据，每次reloadData 这个方法就会一次性调用100次）
  2》每次cell进入屏幕范围内，就会调用一次这个方法
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WMTTopic *top = self.topics[indexPath.row];
    //用模型内存地址做key
    NSString *key = [NSString stringWithFormat:@"%p",top];
    CGFloat cellHeight  = [self.cellHeightDict[key] doubleValue];
    
    if(cellHeight == 0){
        //    CGFloat cellHeight = 0;
    
        //文字的y值
        cellHeight += 75;
        //文字的高度 MAXFLOAT 表示不限制高度
        CGSize textMaxSize = CGSizeMake(WMTScreenW - 2 * WMTMarn, MAXFLOAT);
    //  这个方法是老方法 oc 已经不推荐使用了    cellHeight += [top.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:textMaxSize].height + WMTMarn;
        cellHeight += [top.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height + WMTMarn;
    //    [top.text sizeWithFont:[UIFont systemFontOfSize:15]].height; //只能算出单行的高度
        
        //中间内容的高度
//        NSLog()
        if(top.type != 29){ //不等于段子类型 （图片，声音，视频）
    
        
            CGFloat middleW = WMTScreenW - 2 * WMTMarn;
            CGFloat middleH = middleW  *  top.height /top.width;
            CGFloat middleY = cellHeight;
            CGFloat middleX =WMTMarn;
            
            top.middleFrame=CGRectMake(middleX, middleY, middleW, middleH);
            cellHeight += middleH + WMTMarn;
        }
        
    
        
        //最热评论
        if(top.top_cmt.count){ //有最新评论
            //标题
            cellHeight += 21;
            //内容
            NSDictionary *cmt = top.top_cmt.firstObject;
            NSString *connect = cmt[@"content"];
            NSString *username = cmt[@"user"][@"username"];
            if(connect.length == 0){
                connect = @"[语音评论]";
            }
           NSString  *textSTR= [NSString stringWithFormat:@"%@:%@",username,connect];
            cellHeight += [textSTR boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin  attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height + WMTMarn;
            
        }
        
        //工具条
        cellHeight += 35;
        NSLog(@"%zd - %f",indexPath.row,cellHeight);
        cellHeight += WMTMarn;
    //存储高度
//            self.cellHeightDict[top]=@{cellHeight};
        [self.cellHeightDict setObject:@(cellHeight) forKey:key];
        
        
    }
    
    
    return cellHeight;
}
@end
