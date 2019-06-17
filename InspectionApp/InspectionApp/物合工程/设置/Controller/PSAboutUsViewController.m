//
//  PSAboutUsViewController.m
//  物联宝管家
//
//  Created by guokang on 2019/5/25.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PSAboutUsViewController.h"
#import "PSOfficialWechatVC.h"
#import "MyViewControllerCell.h"
#import "GJWebViewController.h"
#import "MyselfRequest.h"

@interface PSAboutUsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView  *tableView;
@property (weak, nonatomic) IBOutlet UILabel *appNameLab;
@property (nonatomic, strong)NSArray  *nameArr;
@property (weak, nonatomic) IBOutlet UILabel *versionLab;
@property (nonatomic, strong)AboutModel  *aboutModel;
@property (nonatomic, strong)WKWebViewController * webVC;
@end

@implementation PSAboutUsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
     self.webVC = [[WKWebViewController alloc]init];
        self.aboutModel = [UserManager getAboutModel];
    self.appNameLab.text = self.aboutModel.app_name;
    self.versionLab.text = self.aboutModel.ver;
    UIButton *leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [leftBtn addTarget:self action:@selector(clickToBack) forControlEvents:(UIControlEventTouchUpInside)];
    [leftBtn setImage: [UIImage imageNamed:@"图标-返回"]forState:(UIControlStateNormal)];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = left;
    self.title = @"关于物合宝管家";
//    self.nameArr = @[@"免责声明",@"官方微信",@"客服邮箱",@"服务热线"];
    self.nameArr = @[@"免责声明",@"官方公众号",@"客服邮箱",@"服务热线"];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 310,SCREEN_WIDTH, 220) style:(UITableViewStylePlain)];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyViewControllerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyViewControllerCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
}
- (void)clickToBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyViewControllerCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLab.text = self.nameArr[indexPath.row];

    if (indexPath.row == 1) {
         cell.isHidden = YES;
        cell.detailsLab.text = self.aboutModel.wechat;
    }else if (indexPath.row == 2){
        cell.isHidden = YES;
        cell.detailsLab.text =self.aboutModel.email;
    }else if (indexPath.row == 3){
        cell.isHidden = YES;
        cell.detailsLab.text = self.aboutModel.tel;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self requestDisclamierData:indexPath.row];
    }else if (indexPath.row == 1){
//        PSOfficialWechatVC *wechatVC = [[PSOfficialWechatVC alloc]init];
//        wechatVC.imageUrl = self.aboutModel.wechat_qrc;
//        [wechatVC showInVC:self];
    }else if (indexPath.row == 2){
          [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto://%@",self.aboutModel.email]]];
    }else if (indexPath.row == 3){
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.aboutModel.tel]]];
    }
}
-(void)requestDisclamierData:(NSInteger)index
{
    [MyselfRequest disclaimer:^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            self.webVC.titleStr = [self.nameArr objectAtIndex:index];
            self.webVC.webUrl = data;
            [self.navigationController pushViewController:self.webVC animated:YES];
        }
    }];
}
@end
