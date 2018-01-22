//
//  WMTAllViewController.m
//  BuDeJie
//
//  Created by wangmutian on 2018/1/11.
//  Copyright © 2018年 wangmutian. All rights reserved.
//

#import "WMTAllViewController.h"

@interface WMTAllViewController ()
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(35, 0, 0, 0);
    self.dataCount=7;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    self.footer.hidden = (self.dataCount == 0);
    return self.dataCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"id";
    // Configure the cell...
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%@  - %zd",self.class,indexPath.row];
    return cell;
}

//松开scrollView 时调用
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if(self.isHeaderRefeshing) return;
    CGFloat offsetY= - (self.tableView.contentInset.top + self.header.wmt_height);
    if(self.tableView.contentOffset.y <= offsetY){ //header 已经出现
        self.headerLabel.text=@"正在刷新新数据...";
        self.headerRefreshing=YES;
        
        //增加内边距
        [UIView animateWithDuration:0.25 animations:^{
            UIEdgeInsets insert = self.tableView.contentInset;
            insert.top += self.header.wmt_height;
            self.tableView.contentInset = insert;
        }];
        
        //发送数据请求
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           //假设服务器到这里回来
            self.dataCount=7;
            [self.tableView reloadData];
            //结束刷新
              //减小内边距
            
            [UIView animateWithDuration:0.25 animations:^{
                UIEdgeInsets insert = self.tableView.contentInset;
                insert.top -= self.header.wmt_height;
                self.tableView.contentInset = insert;
//                self.headerLabel.text=@"下拉可以刷新";
                self.headerRefreshing=NO;
            }];
            
        });
        
        
    }
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
    
    if(self.tableView.contentOffset.y >= ofsetY){
        self.footerRefreshing=YES;
        //        NSLog(@"走到这里了！！！！！！");
        self.footerLabel.text=@"正在加载更多数据....";
        self.footerLabel.backgroundColor=[UIColor blueColor];
        //时间是2秒钟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC )),
                       dispatch_get_main_queue(),^{
                           _dataCount+=10;
                           [self.tableView reloadData];
                           self.footerRefreshing=NO;
                           self.footerLabel.text=@"上拉加载更多";
                           self.footerLabel.textColor=[UIColor whiteColor];
                       });
    }
    
}


@end
