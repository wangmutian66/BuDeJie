//
//  WMTSubTagViewController.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/25.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "WMTSubTagViewController.h"
#import "AFNetWorking/AFNetWorking.h"
#import "MJExtension/MJExtension.h"
#import "WMTSubTagItem.h"
#import "WMTTableViewCell.h"
static NSString * const ID= @"cell";
@interface WMTSubTagViewController ()
@property(nonatomic,strong) NSArray *subTas;
@end

@implementation WMTSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //展示标签数据
    //设计模型 
    [self loadData];
    
    //注册cell
    //[self.tableView registerNib:[UINib nibWithNibName:@"WMTTableViewCell" bundle:nil] forCellReuseIdentifier:ID];
}

-(void)loadData{
    //1.创建请求的会话管理者
    AFHTTPSessionManager *mgr=[AFHTTPSessionManager manager];
    
    //2.拼接参数
    NSMutableDictionary *paramenters=[NSMutableDictionary dictionary];
    paramenters[@"a"]=@"tag_recommend";
    paramenters[@"action"]=@"sub";
    paramenters[@"c"]=@"topic";
    //3.发送请求
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:paramenters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         NSLog(@"%@",responseObject);
        [responseObject writeToFile:@"/Users/apple/Desktop/plist1/open.plist" atomically:YES];
        _subTas=[WMTSubTagItem mj_objectArrayWithKeyValuesArray:responseObject];
        //刷新表格
        [self.tableView reloadData];
        NSLog(@"SUCCESS");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"ERROR");
    }];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.subTas.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //自定义cell
    WMTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //注意：如果我们的cell从xib加载，一定要绑定标识符
    if(cell == nil){
        //cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell =[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WMTTableViewCell class]) owner:nil options:nil][0];
    }
    // Configure the cell...
    WMTSubTagItem *item=self.subTas[indexPath.row];
    cell.item=item;
   
    //NSLog(@"---->%@",item.theme_name);
    //cell.textLabel.text=item.theme_name;
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
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
