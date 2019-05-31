//
//  GJMessageViewController.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJMessageViewController.h"
#import "GJLoginViewController.h"
#import "GJMessageTableViewCell.h"
#import "GJMessageNewsViewController.h"
#import "GJViewController.h"
#import "GJSliderViewController.h"
#import "GJCommunityModel.h"
@interface GJMessageViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSString *uploadUrl;
    NSArray *NewsdataArray;
}
@end

@implementation GJMessageViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titlelable = [UILabel lableWithName:@"消息通知"];
    self.navigationItem.titleView = titlelable;
    self.tabBarController.tabBar.translucent = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NewsdataArray = [NSArray array];
    NewsdataArray = [userdefaults objectForKey:@"MessageNewsArray"];
    if (NewsdataArray != nil) {
        [self.tableView reloadData];
    }else
    {
        [self TheMessageData];
    }
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [GJMJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self TheMessageData];
            // 结束刷新
    }];
}

-(void)TheMessageData
{
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
//    property_id = model.property_id;
   NSString * community_id = model.community_id;
    
    
    [GJSVProgressHUD showWithStatus:@"正在载入中"];
    
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"user" andA:@"msg" andBodyOfRequestForKeyArr:@[@"community_id"] andValueArr:@[community_id] andBlock:^(id dictionary) {
        NSLog(@"%@",[dictionary yy_modelToJSONString]);
        NSArray *returndataArray = dictionary[@"return_data"];
        NSString *state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
        if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
            [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                GJLoginViewController *LoginViewController = [[GJLoginViewController alloc]init];
                [self presentViewController:LoginViewController animated:YES completion:nil];
            });
        }else if ([state isEqualToString:@"-1"])
        {
            [GJSVProgressHUD showErrorWithStatus:@"网络错误，请检查您的网络中设置"];
        }else if ([state isEqualToString:@"3"])
        {
            NSString *info = dictionary[@"upgrade_info"][@"info"];
            uploadUrl = dictionary[@"upgrade_info"][@"url"];
            self.shengjialert = [[UIAlertView alloc] initWithTitle:nil message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            self.shengjialert.delegate = self;
            [self.shengjialert show];
        }
        else if([state isEqualToString:@"1"])
        {
            self.contentNewsArray = [NSMutableArray array];
            self.nameNewsArray = [NSMutableArray array];
            self.timeNewsArray = [NSMutableArray array];
            self.h5_urlArr=[NSMutableArray array];
            for (NSDictionary *dict in returndataArray)
            {
                NSString *msgcontent = dict[@"msg_content"];
                NSString *msgname = dict[@"msg_name"];
                NSString *msgtime = dict[@"post_time"];
                NSString *h5_url=dict[@"h5_url"];
                [self.contentNewsArray addObject:msgcontent];
                [self.nameNewsArray addObject:msgname];
                [self.timeNewsArray addObject:msgtime];
                [self.h5_urlArr addObject:h5_url];
            }
            NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];

            //获取沙盒路径
//            NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//            NSString *path = [doc stringByAppendingPathComponent:@"account.plist"];
            
            NewsdataArray = [NSArray arrayWithObjects:self.contentNewsArray,self.nameNewsArray,self.timeNewsArray,self.h5_urlArr,nil];
//            [NSKeyedArchiver archiveRootObject:NewsArray toFile:path];
            [userdefaults setObject:NewsdataArray forKey:@"MessageNewsArray"];
            [userdefaults synchronize];
            [self.tableView reloadData];
            [GJSVProgressHUD dismiss];
            [self.tableView.mj_header endRefreshing];
        }else if([state isEqualToString:@"0"])
        {
            [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
        }
    }];
}
//升级弹窗
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.shengjialert removeFromSuperview];
    }else
    {
        //升级
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:uploadUrl]];
    }
}


// 自定义cell
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [NSArray array];
    array = NewsdataArray[1];
    return array.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
//cell内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    //获取沙盒路径
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//    NSString *path = [doc stringByAppendingPathComponent:@"account.plist"];
//    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NewsdataArray = [userdefaults objectForKey:@"MessageNewsArray"];
    GJMessageTableViewCell *acell = [GJMessageTableViewCell createCellWithTableView:tableView withIdentifier:@"flag"];
    acell.topimageView.image =[UIImage imageNamed:@"wode_2x04"];
    NSArray *contentarray = [NewsdataArray objectAtIndex:0];
    NSArray *namenewsArray = [NewsdataArray objectAtIndex:1];
    NSArray *timenewsArray = [NewsdataArray objectAtIndex:2];
    
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[contentarray[indexPath.row] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
//    diLab.attributedText=attrStr;

    acell.contentLables.attributedText = attrStr;
    
    acell.rightLables.text = timenewsArray[indexPath.row];
    acell.topTitleLable.text = namenewsArray[indexPath.row];
    acell.selectionStyle = NO;
     acell.accessoryType = UITableViewCellAccessoryNone;
    return acell;
}
#pragma mark cell 的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GJMessageNewsViewController *messageNewsVC = [[GJMessageNewsViewController alloc]init];
    messageNewsVC.receive = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:messageNewsVC animated:YES];
}



-(void)backhomeDidClicked
{
    if ([self.tongzhi isEqualToString:@"push"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        //切换控制器
        GJViewController * tabbar = [[GJViewController alloc]init];
        [[GJSliderViewController sharedSliderController]showContentControllerWithModel:tabbar];
        [[GJSliderViewController sharedSliderController]showLeftViewController];
    }

}
//-(NSMutableArray *)nameNewsArray
//{
//    if (!_nameNewsArray) {
//        self.nameNewsArray = [NSMutableArray array];
//    }
//    return _nameNewsArray;
//}
//-(NSMutableArray *)timeNewsArray
//{
//    if (!_timeNewsArray) {
//        self.timeNewsArray = [NSMutableArray array];
//    }
//    return _timeNewsArray;
//}
//-(NSMutableArray *)contentNewsArray
//{
//    if (!_contentNewsArray) {
//        self.contentNewsArray = [NSMutableArray array];
//    }
//    return _contentNewsArray;
//}
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
