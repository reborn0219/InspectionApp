//
//  GJnewsViewController.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJnewsViewController.h"
#import "GJNewsTableViewCell.h"
#import "GJNewsChildViewController.h"
#import "GJNewsTableViewTopCell.h"
#import "GJmyViewController.h"
#import "GJKSDatePicker.h"
#import "GJNewsTableViewSexCell.h"
#import "GJViewController.h"
#import "GJSliderViewController.h"
#import "GJLoginViewController.h"
#import "UIImage+HYBmageCliped.h"

BOOL IsFullScreenss;
@interface GJnewsViewController ()<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>
{
    NSString *datastr;
    NSInteger selecteds;
    NSString *nickname;
    NSString *turename;
    NSString *topImageUrl;
//    NSString *changeImageUrl;
    NSString *changeTopurl;
    NSString *mobile_phone;
    NSString *uploadUrl;
}

@end

@implementation GJnewsViewController
-(void)viewWillAppear:(BOOL)animated{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    nickname = [userDefaults objectForKey:@"nick_name"];
    turename = [userDefaults objectForKey:@"ture_name"];
    mobile_phone = [userDefaults objectForKey:@"mobile_phone"];
    NSString *topurl = [userDefaults objectForKey:@"app_avatar_url"];
    NSString *imageurl = [userDefaults objectForKey:@"avatar"];
    changeTopurl = [userDefaults objectForKey:@"HeadportraitImage"];
    topImageUrl = [NSString stringWithFormat:@"%@",imageurl];
//    changeImageUrl = [NSString stringWithFormat:@"%@%@",topurl,changeTopurl];
//    self.tableView.mj_header = [GJMJRefreshNormalHeader headerWithRefreshingBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [self.tableView reloadData];
//            // 结束刷新
//            [self.tableView.mj_header endRefreshing];
//        });
//    }];
    [self.tableView reloadData];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titlelable = [UILabel lableWithName:@"个人信息"];
    self.navigationItem.titleView = titlelable;
    self.tabBarController.tabBar.translucent = NO;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //获取部门类型
//    NSArray *departmentarray = [userDefaults objectForKey:@"department_info"];
//    self.departmentNameArray = [NSMutableArray array];
//    for (NSDictionary *departmentdic in departmentarray) {
//        NSString *departmentname = departmentdic[@"department_name"];
//        [self.departmentNameArray addObject:departmentname];
//    }
    
    
    //获取部门id
//    NSString *departmentid = [userDefaults objectForKey:@"department_id"];
    //nsstring类型转换成int类型
//    int intstring = [departmentid intValue];
    _leftArray = @[@"头像",@"昵称",@"姓名",@"出生日期",@"性别",@"电话"];
    //取消tableview的线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
// 自定义cell
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        GJNewsTableViewTopCell *acell = [GJNewsTableViewTopCell createCellWithTableView:tableView withIdentifier:@"flags"];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 1)];
        alable.backgroundColor = gycoloers;
        [acell addSubview:alable];
        acell.LeftLable.text = _leftArray[indexPath.row];
        acell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (changeTopurl == nil) {
            [acell.HeadportraitView sd_setImageWithURL:[NSURL URLWithString:topImageUrl]];
        }
        else
        {
            [acell.HeadportraitView sd_setImageWithURL:[NSURL URLWithString:changeTopurl]];
        }
        acell.accessoryType = UITableViewCellAccessoryNone;
        return acell;
    }
    else if (indexPath.row == 4)
    {
        GJNewsTableViewSexCell *sexacell = [GJNewsTableViewSexCell createCellWithTableView:tableView withIdentifier:@"sexflag"];
        sexacell.LeftLable.text = _leftArray[indexPath.row];
        sexacell.selectionStyle = UITableViewCellSelectionStyleNone;
        sexacell.accessoryType = UITableViewCellAccessoryNone;
        return sexacell;
    }
    else
    {
        GJNewsTableViewCell *acell = [GJNewsTableViewCell createCellWithTableView:tableView withIdentifier:@"flag"];
        acell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        acell.LeftLable.text = _leftArray[indexPath.row];
        acell.selectedBackgroundView = [[UIView alloc] initWithFrame:acell.frame];
        acell.selectedBackgroundView.backgroundColor = buttonHighcolor;
        if(indexPath.row == 1)
        {
            acell.RightLable.text = nickname;
                    }else if (indexPath.row == 2)
        {
            acell.RightLable.text = turename;
        }else if (indexPath.row == 3) {
            acell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *befordatastr = [userDefaults objectForKey:@"birthday"];
            acell.RightLable.text = befordatastr;
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [dateFormatter dateFromString:befordatastr];
            NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
            [userdefaults setObject:date forKey:@"birthdayDate"];
            [userdefaults synchronize];
        }

        else if (indexPath.row == 5)
        {
            acell.selectionStyle = UITableViewCellSelectionStyleNone;
            acell.accessoryType = UITableViewCellAccessoryNone;
            acell.RightLable.text = mobile_phone;
            acell.RightLable.textColor = gycoloer;
        }
    return acell;
    }
}
#pragma mark cell 的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self ButtonDidClickeds];
    }else if (indexPath.row == 3)
    {
        //x,y 值无效，默认是居中的
        GJKSDatePicker* picker = [[GJKSDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 40, 300)];
        //配置中心，详情见KSDatePikcerApperance
        picker.appearance.radius = 5;
        //设置回调
        picker.appearance.resultCallBack = ^void(GJKSDatePicker* datePicker,NSDate* currentDate,KSDatePickerButtonType buttonType){
            if (buttonType == KSDatePickerButtonCommit) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                datastr = [formatter stringFromDate:currentDate];
                NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
                [userDefault setObject:currentDate forKey:@"currentdate"];
                [userDefault synchronize];
                //传mfa返回access_token
                [GJSVProgressHUD showWithStatus:@"修改中"];
                GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
                [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"user" andA:@"save_userinfo" andBodyOfRequestForKeyArr:@[@"ovapp_data[birthday]"] andValueArr:@[datastr] andBlock:^(id dictionary) {
                    NSString *state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
                    if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"]) {
                        [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            GJLoginViewController *LoginViewController = [[GJLoginViewController alloc]init];
                            [self presentViewController:LoginViewController animated:YES completion:nil];
                        });
                    }else if ([state isEqualToString:@"-1"])
                    {
                        [GJSVProgressHUD showErrorWithStatus:@"网络错误修改失败"];
                    }
                    else if([state isEqualToString:@"1"])
                    {
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        [userDefaults setObject:dictionary[@"return_data"][@"birthday"] forKey:@"birthday"];
                        
                        [userDefaults synchronize];
                        [self.tableView reloadData];
                        [GJSVProgressHUD dismiss];
                        [GJSVProgressHUD showSuccessWithStatus:@"修改成功"];
                    }else if([state isEqualToString:@"3"])
                    {
                        self.shengjialert = [[UIAlertView alloc] initWithTitle:nil message:@"物联宝管家有新的版本，是否需要升级？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
                        self.shengjialert.delegate = self;
                        [self.shengjialert show];
                    }
                }];
            }
        };
        // 显示
        [picker show];
    }
    else if (indexPath.row == 4)
    {
//        NSArray *namearray = [[NSArray alloc]init];
//        namearray = @[@"技术部",@"客服部",@"运营部",@"售后部"];
//            GJTePopList *pop = [[GJTePopList alloc]initWithListDataSource:namearray withSelectedBlock:^(NSInteger select)
//            {
//                
//                GJNetworkDetermine *connect = [[GJNetworkDetermine alloc]init];
//                if(!connect.connectedToNetwork)
//                {
//                    [GJSVProgressHUD showErrorWithStatus:@"网络错误,修改失败"];
//                }else{
//                    [GJSVProgressHUD showWithStatus:@"修改中"];
//                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//                    NSString *typeid = [NSString stringWithFormat:@"%ld",(long)select];
//                    GJLCLNetWork *network = [[GJLCLNetWork alloc]init];
//                    [network requestNetWithInterface:@"" andM:@"mlgj_api" andF:@"user" andA:@"save_userinfo" andBodyOfRequestForKeyArr:@[@"ovapp_data[department_id]"] andValueArr:@[typeid] andBlock:^(id dictionary) {
//                        NSString *state = [NSString stringWithFormat:@"%@",dictionary[@"state"]];
//                        if ([state isEqualToString:@"5"]) {
//                            [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
//                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                                GJLoginViewController *LoginViewController = [[GJLoginViewController alloc]init];
//                                [self presentViewController:LoginViewController animated:YES completion:nil];
//                            });
//                        }
//                       else
//                        {
//                            [userDefaults setObject:dictionary[@"return_data"][@"department_id"] forKey:@"department_id"];
//                            [userDefaults synchronize];
//                            [self.tableView reloadData];
//                            [GJSVProgressHUD dismiss];
//                            [GJSVProgressHUD showSuccessWithStatus:@"修改成功"];
//                        }
//                    }];
//                }
//            }];
//        [pop show];
//        //获取部门id
//        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//        NSString *departmentid = [userDefaults objectForKey:@"department_id"];
//        //nsstring类型转换成int类型
//        int intstring = [departmentid intValue];
//        [pop selectIndex:intstring];
    }
    else if(indexPath.row == 1 || indexPath.row == 2)
    {
        GJNewsChildViewController *newsChildVC = [[GJNewsChildViewController alloc]init];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.row == 1) {
            newsChildVC.titlelables = self.leftArray[indexPath.row];
            newsChildVC.rightTitle = nickname;
        }else if(indexPath.row == 2)
        {
            newsChildVC.titlelables = self.leftArray[indexPath.row];
            newsChildVC.rightTitle = turename;
        }
        [self.navigationController pushViewController:newsChildVC animated:YES];
    }
}
-(void)ButtonDidClickeds
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        [[[UIAlertView alloc] initWithTitle:nil
                                    message:@"app需要访问您的相机。\n请启用相机-设置/隐私/相机"
                                   delegate:nil
                          cancelButtonTitle:@"关闭"
                          otherButtonTitles:nil] show];
        return;
    }else
    {
    UIActionSheet *sheet;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 255;
    [sheet showInView:self.view];
    }
}

#pragma UIActionSheet Delegate



- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = 0;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        if (sourceType==UIImagePickerControllerSourceTypePhotoLibrary) {
            NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"Yes",@"XC", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"aaa" object:self userInfo:dic];
        }
    
        [self presentViewController:imagePickerController animated:YES completion:^{

        }];
    }
}



#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"No",@"XC", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"aaa" object:self userInfo:dic];
    
    GJNetworkDetermine *connect = [[GJNetworkDetermine alloc]init];
    if(!connect.connectedToNetwork)
    {
    [GJSVProgressHUD showErrorWithStatus:@"网络错误,修改失败"];
    [picker dismissViewControllerAnimated:YES completion:^{}];
    }
    else
    {
    //修改头像参数
        [GJSVProgressHUD showWithStatus:@"修改中"];
//        UIImage *currentImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
    //朱滴20181013修复选取裁剪照片后照片没有被编辑的bug
    UIImage *currentImage = [info objectForKey:UIImagePickerControllerEditedImage];
    self.imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    
    //获取头像数据
    //传mfa返回access_token
    NSString *accesstoken = [NSString stringWithModule:@"mlgj_api" Filename:@"upload" Action:@"avatar"];
    //1,请求管理者
    GJAFHTTPRequestOperationManager *mgr = [GJAFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", @"text/json", nil];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    //2,拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userid = [userDefaults objectForKey:@"user_id"];
    NSString *session = [userDefaults objectForKey:@"session_key"];
    params[@"m"] = @"mlgj_api";
    params[@"f"] = @"upload";
    params[@"a"] = @"avatar";
    params[@"app_id"] = APP_ID;
    params[@"app_secret"] = APP_SECRET;
    params[@"access_token"] = accesstoken;
    params[@"user_id"] = userid;
    params[@"session_key"] = session;
        
    //3,发送请求
    [mgr POST:URL_LOCAL parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [formData appendPartWithFileData:self.imageData name:@"upload_file" fileName:fileName mimeType:@"image/png"];
    } success:^(GJAFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *state = [NSString stringWithFormat:@"%@",responseObject[@"state"]];
        if ([state isEqualToString:@"5"] || [state isEqualToString:@"4"] || [state isEqualToString:@"2"]) {
            [GJSVProgressHUD showErrorWithStatus:@"登录失效，请重新登录"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [picker dismissViewControllerAnimated:YES completion:^{}];
                GJLoginViewController *LoginViewController = [[GJLoginViewController alloc]init];
                [self presentViewController:LoginViewController animated:YES completion:nil];
            });
        }else if ([state isEqualToString:@"3"]){
            NSString *info = responseObject[@"upgrade_info"][@"info"];
            uploadUrl = responseObject[@"upgrade_info"][@"url"];
            self.shengjialert = [[UIAlertView alloc] initWithTitle:nil message:info delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
            self.shengjialert.delegate = self;
            [self.shengjialert show];
        }
        else if([state isEqualToString:@"1"])
        {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:responseObject[@"return_data"] forKey:@"avatar"];
        [userDefaults synchronize];
            
      
            
            
        
        [picker dismissViewControllerAnimated:YES completion:^{}];
        [GJSVProgressHUD dismiss];
        [GJSVProgressHUD showSuccessWithStatus:@"修改完成"];
        //通知中心改变左侧菜单栏头像
        [[NSNotificationCenter defaultCenter]postNotificationName:@"logoImage" object:nil];
        }else
        {
            [GJSVProgressHUD showErrorWithStatus:responseObject[@"return_data"]];
        }
    } failure:^(GJAFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"-----------%@",error);
        [GJSVProgressHUD dismiss];
        [picker dismissViewControllerAnimated:YES completion:^{}];
    }];
//    GJLeftTbaleViewController *leftVC = [[GJLeftTbaleViewController alloc]init];
//    leftVC.tongzhi = @"change";
//    IsFullScreenss = NO;
    }
}
#pragma mark - UIImagePickerDelegate
- (void)imagePickerControllerDidCancel:(UIImagePickerController *) picker {
    NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"No",@"XC", nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"aaa" object:self userInfo:dic];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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
-(NSArray *)rightArray
{
    if (!_rightArray) {
        self.rightArray = [NSArray array];
    }
    return _rightArray;
}
-(NSArray *)leftArray
{
    if (!_leftArray) {
        self.leftArray = [NSArray array];
    }
    return _leftArray;
}

-(void)backhomeDidClicked
{
    if ([self.tongzhi isEqualToString:@"push"]) {
        GJmyViewController *myVC = [[GJmyViewController alloc]init];
        [myVC.myview.tableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        //切换控制器
        GJViewController * tabbar = [[GJViewController alloc]init];
        [[GJSliderViewController sharedSliderController]showContentControllerWithModel:tabbar];
        [[GJSliderViewController sharedSliderController]showLeftViewController];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
