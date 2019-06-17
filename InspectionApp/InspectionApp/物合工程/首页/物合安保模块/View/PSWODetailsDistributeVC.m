//
//  PSWODetailsDistributeVC.m
//  InspectionApp
//
//  Created by guokang on 2019/6/5.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWODetailsDistributeVC.h"
#import "PSWOSelectMemberCell.h"
#import "PPCarModel.h"

@interface PSWODetailsDistributeVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *bigView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIView *textViewBackView;
@property (weak, nonatomic) IBOutlet UITextView *remarkTV;
@property (strong, nonatomic)UITableView *tableView;
@property (nonatomic, strong)UIButton  *selectBtn;
@property (nonatomic, strong)NSMutableArray  *taskList_Arr;
@property (nonatomic, strong)NSString  *memberName;
@property (nonatomic, strong)NSMutableDictionary *distribute_dict;
@property (nonatomic, strong)NSMutableDictionary *transfer_dict;
@end

@implementation PSWODetailsDistributeVC
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
    _distribute_dict = [NSMutableDictionary dictionary];
    [self   createUI];
    [self requestRepair_whoList];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keybaordClickToBack)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    [self.distribute_dict setValue:@"" forKey:@"remarks"];
    [self.distribute_dict setValue:@"" forKey:@"repair_user_id"];
    [self.transfer_dict setValue:@"" forKey:@"remarks"];
    [self.transfer_dict setValue:@"" forKey:@"repair_user_id"];
}
- (void)keybaordClickToBack
{
    [self.view endEditing:YES];
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (_type == 0) {
        if ([textView.text isEqualToString:@"备注"]) {
            textView.text = @"";
        }
    }else{
        if ([textView.text isEqualToString:@"原因"]) {
            textView.text = @"";
        }
    }
}
- (NSMutableDictionary *)distribute_dict
{
    if (!_distribute_dict) {
        _distribute_dict  = [NSMutableDictionary dictionary];
    }
    return _distribute_dict;
}
- (NSMutableDictionary *)transfer_dict
{
    if (!_transfer_dict) {
        _transfer_dict  = [NSMutableDictionary dictionary];
    }
    return _transfer_dict;
}
- (NSMutableArray *)taskList_Arr
{
    if (!_taskList_Arr) {
        _taskList_Arr = [NSMutableArray array];
    }
    return _taskList_Arr;
}
- (void)createUI
{
    if (_type == 0) {
        _titleLab.text = @"分配工单";
        _remarkTV.text = @"备注";
    }else{
        _titleLab.text = @"工单转移";
         _remarkTV.text = @"原因";
    }
    self.backView.layer.cornerRadius = 8.0f;
    self.bigView.layer.cornerRadius = 8.0f;
    self.bigView.layer.masksToBounds = YES;
    self.bigView.layer.cornerRadius = 8.0f;
    self.textViewBackView.layer.cornerRadius = 8.0f;
    self.textViewBackView.layer.shadowOffset = CGSizeMake(0, 0);
    self.textViewBackView.layer.shadowColor = SHADOW_COLOR.CGColor;
    self.textViewBackView.layer.shadowRadius = 2;
    self.textViewBackView.layer.shadowOpacity = 0.2;
    self.remarkTV.layer.cornerRadius = 8.0f;
    self.remarkTV.delegate = self;
    [self.backView addSubview:self.tableView];
  
}
- (void)textViewDidChange:(UITextView *)textView
{
    if (_type == 0) {
     [_distribute_dict setValue:textView.text forKey:@"remarks"];
    }else{
    [_transfer_dict setValue:textView.text forKey:@"remarks"];
    }
}
- (void)requestRepair_whoList
{
    MJWeakSelf
    [SecurityRequest repair_whoPage:@"1" Nums:@"30" :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
        NSArray *modelArr = [NSArray yy_modelArrayWithClass:[PPCarModel class] json:data];
            [weakSelf.taskList_Arr addObjectsFromArray:modelArr];
//            PPCarModel *model = modelArr[0];
//            [weakSelf.distribute_dict setObject:model.user_id forKey:@"repair_user_id"];
            [weakSelf.tableView reloadData];
        }
    }];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 12, SCREEN_WIDTH -85, 116) style:(UITableViewStylePlain)];
        [_tableView registerNib:[UINib nibWithNibName:@"PSWOSelectMemberCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PSWOSelectMemberCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.taskList_Arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MJWeakSelf
    PSWOSelectMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PSWOSelectMemberCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectBtn.tag=100+ indexPath.row;
    PPCarModel *cellModel = self.taskList_Arr[indexPath.row];
    [cell assignmentWithModel:cellModel];
    [cell.selectBtn addTarget:self action:@selector(clickToSelectMember:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.block = ^(id  _Nullable data, WorkAlertType type) {
        NSString *member_id = data;
        if (weakSelf.type == 0) {
        [weakSelf.distribute_dict setValue:member_id forKey:@"repair_user_id"];
        }else{
        [weakSelf.transfer_dict setValue:member_id forKey:@"repair_user_id"];
        }

    };
    self.selectBtn = cell.selectBtn;
//    if (self.selectBtn.tag == 100) {
//        self.selectBtn.selected = YES;
//    }
    return cell;
}
- (void)clickToSelectMember:(UIButton*)button
{
    if(button !=self.selectBtn) {
        self.selectBtn.selected=NO;
        button.selected=YES;
        self.selectBtn= button;
    }else{
        self.selectBtn.selected=YES;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 34;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 20)];
    if (_type == 0) {
    titleLab.text = @"请选择分派人员";
    }else{
    titleLab.text = @"请选择转移人员";
    }
    titleLab.font = [UIFont systemFontOfSize:14];
    [headerView addSubview:titleLab];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return 20;
}
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)confoirmAction:(id)sender {

    if (_block) {
       
        if (_type == 0) {
             NSString *repair_user_id =[NSString stringWithFormat:@"%@",[self.distribute_dict objectForKey:@"repair_user_id"]];
            if (repair_user_id.length != 0) {
              _block(self.distribute_dict,WorkOrderAlertDistribute);
              [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [GJMBProgressHUD showError:@"请选择分派人员"];
            }
        }else{
             NSString *repair_user_id =[NSString stringWithFormat:@"%@",[self.transfer_dict objectForKey:@"repair_user_id"]];
            if (repair_user_id.length != 0) {
                _block(self.transfer_dict,WorkOrderAlertTranform);
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                 [GJMBProgressHUD showError:@"请选择转移人员"];
            }
        }
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
