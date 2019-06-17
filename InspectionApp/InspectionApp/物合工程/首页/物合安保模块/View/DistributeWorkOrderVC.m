//
//  DistributeWorkOrderVC.m
//  InspectionApp
//
//  Created by guokang on 2019/5/29.
//  Copyright © 2019 yang. All rights reserved.
//

#import "DistributeWorkOrderVC.h"
#import "MyViewControllerCell.h"
#import "PPSelectCarVC.h"
#import "PPCarModel.h"
@interface DistributeWorkOrderVC ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bigBackView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITextView *remarkTV;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancleBTN;
@property (weak, nonatomic) IBOutlet UIView *littleBackView;
@property (strong, nonatomic)UITableView *tableView;
@property (nonatomic, strong)UIButton  *selectBtn;
@property (nonatomic, strong)PPSelectCarVC  *selectMemberVC;
@property (nonatomic, strong)NSMutableDictionary *distribute_dict;
@end

@implementation DistributeWorkOrderVC
-(void)showInVC:(UIViewController *)VC {
    
    if (self.isBeingPresented) {
        return;
    }
    self.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    /**
     *  根据系统版本设置显示样式
     */
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        self.modalPresentationStyle=UIModalPresentationOverFullScreen;
    }else {
        self.modalPresentationStyle=UIModalPresentationCustom;
    }
    [VC presentViewController:self animated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self   createUI];
    
}
- (void)createUI
{
    
    self.backView.layer.cornerRadius = 8.0f;
    self.bigBackView.layer.cornerRadius = 8.0f;
    self.bigBackView.layer.masksToBounds = YES;
    self.littleBackView.layer.cornerRadius = 8.0f;
    self.littleBackView.layer.shadowRadius = 2;
    self.littleBackView.layer.shadowColor = SHADOW_COLOR.CGColor;
    self.littleBackView.layer.shadowOffset = CGSizeMake(0, 0);
    self.littleBackView.layer.shadowOpacity = 0.2;
    self.remarkTV.layer.cornerRadius = 8.0f;
    self.remarkTV.delegate = self;
    [self.backView addSubview:self.tableView];
}
- (NSMutableDictionary *)distribute_dict
{
    if (!_distribute_dict) {
        _distribute_dict  = [NSMutableDictionary dictionary];
    }
    return _distribute_dict;
}
- (void)textViewDidChange:(UITextView *)textView
{
    [_distribute_dict setObject:textView.text forKey:@"remarks"];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 12, SCREEN_WIDTH -70, 44) style:(UITableViewStylePlain)];
        [_tableView registerNib:[UINib nibWithNibName:@"MyViewControllerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MyViewControllerCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyViewControllerCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLab.text = @"请选择分派人员";
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MJWeakSelf
    _selectMemberVC = [[PPSelectCarVC alloc]init];
    _selectMemberVC.block = ^(id  _Nullable data, UIView * _Nullable view, NSInteger index) {
        PPCarModel *model = data;
        [weakSelf.distribute_dict setObject:model.user_id forKey:@"Repair_user_id"];
    };
    [_selectMemberVC showInVC:self Type:4];
}
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)confirmAction:(id)sender {
    if (_block) {
        _block(self.distribute_dict,WorkOrderAlertDistribute);
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
