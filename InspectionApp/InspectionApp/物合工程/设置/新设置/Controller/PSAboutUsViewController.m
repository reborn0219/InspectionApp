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
@interface PSAboutUsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView  *tableView;
@property (nonatomic, strong)NSArray  *nameArr;
@end

@implementation PSAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *leftBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [leftBtn addTarget:self action:@selector(clickToBack) forControlEvents:(UIControlEventTouchUpInside)];
    [leftBtn setImage: [UIImage imageNamed:@"图标-返回黑"]forState:(UIControlStateNormal)];
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = left;
    self.title = @"关于物合宝管家";
    self.nameArr = @[@"免责声明",@"常见问题",@"官方微信",@"客服邮箱",@"服务热线"];
    // Do any additional setup after loading the view from its nib.
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
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyViewControllerCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;    cell.titleLab.text = self.nameArr[indexPath.row];
    if (indexPath.row == 2) {
        cell.detailsLab.text = @"MeiDYY";
    }else if (indexPath.row == 3){
        cell.detailsLab.text = @"MeiDYY@meidyy.com";
    }else if (indexPath.row == 4){
        cell.detailsLab.text = @"400-68-36524";
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
        WKWebViewController * webVC = [[WKWebViewController alloc]init];
        webVC.titleStr = [self.nameArr objectAtIndex:indexPath.row];
        webVC.webUrl = @"https://www.baidu.com";
        [self.navigationController pushViewController:webVC animated:YES];
    }else if (indexPath.row == 1){
        WKWebViewController * webVC = [[WKWebViewController alloc]init];
        webVC.titleStr = [self.nameArr objectAtIndex:indexPath.row];
        webVC.webUrl = @"https://www.baidu.com";
        [self.navigationController pushViewController:webVC animated:YES];
    }else if (indexPath.row == 2){
        PSOfficialWechatVC *wechatVC = [[PSOfficialWechatVC alloc]init];
        [wechatVC showInVC:self];
    }else if (indexPath.row == 3){
          [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto://MeiDYY@meidyy.com"]]];
    }else if (indexPath.row == 4){
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://400-68-36524"]]];
    }

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
