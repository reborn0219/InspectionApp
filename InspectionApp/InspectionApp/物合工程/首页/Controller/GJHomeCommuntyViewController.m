//
//  GJHomeCommuntyViewController.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/25.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJHomeCommuntyViewController.h"
#import "FMDB.h"
#import "GJCommunityModel.h"
#import "YYModel.h"
@interface GJHomeCommuntyViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UIImageView *placeimageView;
    UILabel *placelable;
    NSArray *namearray;
//    //存放小区名称
//    NSMutableArray *communityNameArray;
//    //存放小区id
//    NSMutableArray *communitIDArray;
    //物业ID
// NSString *propertyid;
    //存放点击的button  tag
    int tag;

}
@property(nonatomic,strong)NSMutableArray *UnitDataArray;
@property(nonatomic,strong)NSMutableArray *RoomDataArray;
@property(nonatomic,strong)NSMutableArray *UserDataArray;
@property(nonatomic,strong)NSMutableArray *AllUserDataArray;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong) GJFMDatabase *db;

@property (nonatomic,strong) NSMutableArray *comminityArray;

@end

@implementation GJHomeCommuntyViewController
#pragma mark - LifeCycle Menthod
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.backgroundColor = viewbackcolor;
    self.view = self.tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self getCommunityData];
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [GJMJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getCommunityData];
    }];
    
    //导航栏标题
    UILabel *titlelable = [UILabel lableWithName:@"请选择小区"];
    self.navigationItem.titleView = titlelable;
    self.tabBarController.tabBar.translucent = NO;
    //左侧导航栏按钮
    UIImageView *leftbutton = [[UIImageView alloc]init];
    leftbutton.backgroundColor = NAVCOlOUR;
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = leftBtn;
}
#pragma mark - UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.comminityArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cell_id = @"flag";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
    }
    GJCommunityModel *model = self.comminityArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
    cell.textLabel.text = model.community_name;
    return cell;

}

//cell的选中状态
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"是否切换小区?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
    alert.tag = 100;
    alert.delegate =self;
    tag = indexPath.row;
    [alert show];
}

-(void)getCommunityData
{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    NSArray *communityArray = [[NSArray alloc]init];
    communityArray = [userdefault objectForKey:@"my_community"];
    
    SLog(@"---%@---",communityArray);
    
    if (self.comminityArray.count > 0) {
        [self.comminityArray removeAllObjects];
    }
    
    /*将小区的model信息存到数组*/
    [communityArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *tmpDict = obj;
        GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:tmpDict];
        [self.comminityArray addObject:model];
        
        /*将请求的默认小区存起来*/
        if ([model.is_default isEqualToString:@"Y"]) {
            [KUserDefault setObject:tmpDict forKey:KCurrentSelectCommunity];
        }
        
    }];
    
    if (self.comminityArray.count == 0) {
        placeimageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.tableView.width/2 - 80, self.tableView.height/2 - 130, 160, 160)];
        placeimageView.layer.cornerRadius = placeimageView.size.width/2;
        placeimageView.backgroundColor = [UIColor clearColor];
        placeimageView.image = [UIImage imageNamed:@"100x100"];
        placelable = [[UILabel alloc]initWithFrame:CGRectMake(0, self.tableView.height/2+40, WIDTH, 30)];
        placelable.textColor = gycolor;
        placelable.text = @"无法获取到小区信息，请联系客服人员";
        placelable.textAlignment = NSTextAlignmentCenter;
        [self.tableView addSubview:placelable];
        [self.tableView addSubview:placeimageView];
        GJLoginViewController *LoginVC = [[GJLoginViewController alloc]init];
        [self.navigationController presentViewController:LoginVC animated:YES completion:nil];

        
    }else
    {
        [placeimageView removeFromSuperview];
        [placelable removeFromSuperview];
        [self.tableView reloadData];
    }
    [self.tableView.mj_header endRefreshing];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        if (buttonIndex == 0) {
            [alertView removeFromSuperview];
            
        }else{
          
            /*将当前选中的小区信息保存下来,如果该小区物业公司为空则直接返回*/
            GJCommunityModel *model = self.comminityArray[tag];
            if ([model.property_id isEqualToString:@""]) {
                [GJSVProgressHUD showErrorWithStatus:@"该小区暂无物业公司"];
                return;
            }
            
            NSDictionary *tmpDict = [model yy_modelToJSONObject];
            [KUserDefault setObject:tmpDict forKey:KCurrentSelectCommunity];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ChangeCommunityIDName" object:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"changeCommunityID" object:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"HomewageNumData" object:nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"getOwnerData" object:nil];
            
            [self changeMyCommunityWithModel:model];
        }
}

-(void)reloadOwnerData
{
    
    NSDictionary *dict = [KUserDefault objectForKey:KCurrentSelectCommunity];
    GJCommunityModel *model = [GJCommunityModel yy_modelWithJSON:dict];
    
    if ([model.property_id isEqualToString:@""]) {
        //[GJSVProgressHUD showErrorWithStatus:@"该小区暂未开通物业公司"];
        //return;
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
   
    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"msg" andA:@"owner_list" andBodyOfRequestForKeyArr:@[@"property_id",@"community_id"] andValueArr:@[model.property_id,model.community_id] andBlock:^(id dictionary)
     {
         
         SLog(@"------%@-----",dictionary);
         NSString *state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
         if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
//             [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 //推登录
                 GJLoginViewController *LoginVC = [[GJLoginViewController alloc]init];
                 [self.navigationController presentViewController:LoginVC animated:YES completion:nil];
             });
         }
         else if ([state isEqualToString:@"0"])
         {
             [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
         }
         else if ([state isEqualToString:@"-1"])
         {
             [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
         }else if ([state isEqualToString:@"1"])
         {
             _UnitDataArray = [NSMutableArray array];
             _RoomDataArray = [NSMutableArray array];
             _UserDataArray = [NSMutableArray array];
             _AllUserDataArray = [NSMutableArray array];
             for (NSDictionary *UNitdict in dictionary[@"return_data"]) {
                 NSArray *array = [NSArray array];
                 array = UNitdict[@"unit"];
                 if (array.count == 0) {
                     NSLog(@"nil");
                 }else
                 {
                     [_UnitDataArray addObject:array];
                 }
             }
             for (int i = 0; i < _UnitDataArray.count; i++) {
                 for (NSDictionary *unitDict  in _UnitDataArray[i]) {
                     [_RoomDataArray addObject:unitDict[@"room_list"]];
                 }
             }
             for (int i = 0; i < _RoomDataArray.count; i++) {
                 for (NSDictionary *unitDict  in _RoomDataArray[i]) {
                     [_UserDataArray addObject:unitDict[@"user_list"]];
                 }
             }
             
             for (int i = 0; i < _UserDataArray.count; i ++) {
                 for (NSDictionary *userdataDic in _UserDataArray[i]) {
                     [_AllUserDataArray addObject:userdataDic];
                 }
             }
             [userDefaults setObject:_AllUserDataArray forKey:@"NIMAllUserDataArray"];
             [userDefaults synchronize];
             [GJSVProgressHUD dismiss];
         }else
         {
             [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
         }
     }];
}

#pragma mark - NetRequest Menthod 点击切换
- (void)changeMyCommunityWithModel:(GJCommunityModel*)model{

    GJLCLNetWork *netWork = [[GJLCLNetWork alloc]init];
    [GJSVProgressHUD showWithStatus:@"正在切换"];
    [netWork submitRequestNetWithInterface:@"" andM:@"mlgj_api" andF:@"user" andA:@"change_mycommunity" andBodyOfRequestForKeyArr:@[@"property_id",@"community_id"] andValueArr:@[model.property_id,model.community_id] andBlock:^(id dictionary) {
        NSLog(@"%@",dictionary);
        [GJSVProgressHUD dismiss];
        NSString *state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
        if ([state isEqualToString:@"1"]) {
            [GJSVProgressHUD showSuccessWithStatus:dictionary[@"return_data"]];
            [self reloadOwnerData];
            [self.navigationController popViewControllerAnimated:YES];

        } else if([state isEqualToString:@"0"]){
            [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
            
        }else if ([state isEqualToString:@"-1"]){
            [GJSVProgressHUD showErrorWithStatus:@"网络错误"];
            
        }else if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
//            [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                GJLoginViewController *loginVC = [[GJLoginViewController alloc]init];
                [self presentViewController:loginVC animated:YES completion:nil];
            });
        }else{
            [GJSVProgressHUD showErrorWithStatus:dictionary[@"return_data"]];
        }
    }];
}

#pragma mark - Setter && Getter
- (NSMutableArray *)comminityArray{
    if (!_comminityArray) {
        _comminityArray = [[NSMutableArray alloc]init];
    }
    return _comminityArray;
}

@end
