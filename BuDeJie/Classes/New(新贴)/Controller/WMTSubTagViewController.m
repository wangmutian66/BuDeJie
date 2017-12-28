//
//  WMTSubTagViewController.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/26.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "WMTSubTagViewController.h"
#import "AFNetWorking/AFNetWorking.h"
#import "MJExtension/MJExtension.h"
#import "WMTSubTagItem.h"
#import "WMTSubTagcel.h"
#import "SVProgressHUD/SVProgressHUD.h"
NSString * const ID=@"cell";
@interface WMTSubTagViewController ()
@property(nonatomic,strong) NSArray *subTags;
@property(nonatomic,weak) AFHTTPSessionManager *mgr;
@end

@implementation WMTSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //展示标签的数据 -> 请求数据（接口文档）
    [self loadData];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"WMTSubTagcel" bundle:nil] forCellReuseIdentifier:ID];
    self.navigationItem.title=@"订阅号";
    
    //处理cell 分割线
    self.tableView.separatorInset = UIEdgeInsetsZero;
//    self.tableView.layoutMargins=UIEdgeInsetsZero;
    [SVProgressHUD showWithStatus:@"加载中"];
}

//界面消失调用
-(void)viewWillDisappear:(BOOL)animated{
    [SVProgressHUD dismiss];
    //取消之前的请求
    [_mgr.tasks makeObjectsPerformSelector:@selector(cancel)];
    
}


#pragma mark - 请求数据
-(void)loadData{
    //加载数据
    
    //1.创建请求会话管理者
    AFHTTPSessionManager *mgr=[AFHTTPSessionManager manager];
    _mgr=mgr;
    //2.拼接参数
    NSMutableDictionary *parameters=[NSMutableDictionary dictionary];
    parameters[@"a"]=@"tag_recommend";
    parameters[@"action"]=@"sub";
    parameters[@"c"]=@"topic";
    //3.发送请求
    
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //关闭load
        [SVProgressHUD dismiss];
        //字典数组转模型数组
        NSLog(@"%@",responseObject);
        _subTags=[WMTSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        //刷新表格
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.subTags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    WMTSubTagcel *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //cell.layoutMargins=UIEdgeInsetsZero; 将此处代码修改到视图页
    //注意 如果cell 从 xib加载，一定要记得绑定标识符，否则没有循环利用
    //   方法一：identifier 里绑定
    // 方法二:注册 cell
//    if(cell == nil){
//        //cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//        cell= [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WMTSubTagcel class]) owner:nil options:nil][0];
//    }
    // Configure the cell...
    WMTSubTagItem *item=self.subTags[indexPath.row];
    //cell.textLabel.text=item.theme_name;
    cell.item=item;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
