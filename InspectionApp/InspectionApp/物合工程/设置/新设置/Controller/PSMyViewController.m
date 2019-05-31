//
//  PSMyViewController.m
//  物联宝管家
//
//  Created by guokang on 2019/5/25.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PSMyViewController.h"

#import "PSAboutUsViewController.h"
#import "WHZLForgetPasswordVC.h"
#import "WHZLLoginViewController.h"
#import "MyViewControllerCell.h"

@interface PSMyViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *clearCacheName;
}
@property (weak, nonatomic) IBOutlet UIImageView *backImageV;
@property (weak, nonatomic) IBOutlet UILabel *identityLab;
@property (weak, nonatomic) IBOutlet UILabel *companyLab;
@property (weak, nonatomic) IBOutlet UILabel *uncheckLab;
@property (weak, nonatomic) IBOutlet UILabel *checkedLab;
@property (weak, nonatomic) IBOutlet UIView *littleBackView;
@property (weak, nonatomic) IBOutlet UIButton *exitBtn;
@property (nonatomic, strong)UITableView  *tableView;
@property (nonatomic, strong)NSArray  *nameArr;
@property (nonatomic, strong)UIAlertView  *alert;
@property (nonatomic, strong)NSString  *cache;
@end

@implementation PSMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
  self.navigationController.navigationBar.hidden = NO;
}
-(void)createUI
{
    self.nameArr = @[@"修改密码",@"清除缓存",@"关于物合宝"];
    self.view.backgroundColor = HexRGBAlpha(0xFEFEFE, 1);
    self.littleBackView.layer.cornerRadius = 8.0f;
    self.littleBackView.layer.masksToBounds = YES;
    self.littleBackView.backgroundColor = [UIColor whiteColor];
    self.littleBackView.layer.shadowOffset = CGSizeMake(0, 2);
    [self.exitBtn setTitle:@"退出登录" forState:(UIControlStateNormal) ];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 240, KScreenWigth, 150) style:(UITableViewStylePlain)];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyViewControllerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyViewControllerCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)exitAction:(id)sender {
    WHZLLoginViewController *loginVC =[[WHZLLoginViewController alloc]init];
    UINavigationController *loginnav = [[UINavigationController alloc]initWithRootViewController:loginVC];
    APP_DELEGATE.window.rootViewController=loginnav;
    CATransition * animation =  [AnimtionUtils getAnimation:7 subtag:2];
    [loginnav.view.window.layer addAnimation:animation forKey:nil];
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyViewControllerCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLab.text = self.nameArr[indexPath.row];
    if (indexPath.row == 1) {
        cell.detailsLab.text = self.cache;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        WHZLForgetPasswordVC *passwordVC = [[WHZLForgetPasswordVC alloc]init];
        passwordVC.isChange = YES;
        [self.navigationController pushViewController:passwordVC animated:YES];
    }else if (indexPath.row == 1){
        self.alert = [[UIAlertView alloc] initWithTitle:nil message:@"确定要清除缓存数据?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil];
        [self.alert show];
    }else{
        PSAboutUsViewController *aboutVC = [[PSAboutUsViewController alloc]init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.alert removeFromSuperview];
    }else
    {
        [self cleargarbage];
    }
}
- (void)cleargarbage

{
    [[SDImageCache sharedImageCache] clearMemory];
    float tmpSize =  2.3;
    clearCacheName = [NSString stringWithFormat:@"清理了缓存(%.2fM)",tmpSize];
    self.cache= @"0.00M";
    [self.tableView reloadData];
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
