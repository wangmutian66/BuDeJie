//
//  WMTSettingViewController.m
//  BuDeJie
//
//  Created by wangmutian on 2017/12/18.
//  Copyright © 2017年 wangmutian. All rights reserved.
//

#import "WMTSettingViewController.h"

@interface WMTSettingViewController ()

@end

@implementation WMTSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   //设置导航条左边按钮
//    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [backButton setTitle:@"返回" forState:UIControlStateNormal];
//    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
//    [backButton setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
//    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//    [backButton sizeToFit];
//    backButton.contentEdgeInsets=UIEdgeInsetsMake(0, -10, 0, 0);
//    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
//    self.navigationItem.leftBarButtonItem=[UIBarButtonItem backItemWithimage1:[UIImage imageNamed:@"navigationButtonReturn"]  hightImage:[UIImage imageNamed:@"navigationButtonReturnClick"]  target:self action:@selector(back) title:@"返回"];
    self.title=@"设置";
    //self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"JST" style:0 target:self action:@selector(jump)];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
