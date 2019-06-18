//
//  PSShowWorkOrderVC.m
//  InspectionApp
//
//  Created by guokang on 2019/5/29.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSShowWorkOrderVC.h"
#import "PSWorkOrderDetalisImageCell.h"
#import "PSWorkOrderDetailsCell.h"

@interface PSShowWorkOrderVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UIView *bigBackView;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *grabOrderBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextOrderBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIButton *noVoiceBtn;
@property (nonatomic, strong)UITableView  *tableView;
@property (nonatomic, strong)NSArray  *leftArr;

@end

@implementation PSShowWorkOrderVC
-(void)nextOrder{
    _typeLab.text = _controllerModel.type_name;
    [self.tableView reloadData];
}
-(void)showInVC:(UIViewController *)VC withModel:(nonnull NewOrderModel *)model{
    _controllerModel = model;
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
    self.bigBackView.layer.masksToBounds = YES;
    self.bigBackView.layer.cornerRadius = 8.0f;
    self.backView.layer.cornerRadius = 8.0f;
    self.backView.layer.masksToBounds = YES;
    [self.backView addSubview:self.tableView];
    self.leftArr = @[@"服务人：",@"联系电话：",@"预约时间：",@"工单内容：",@"备注："];
      if ([UserManager iscaptain].integerValue == 1) {
          [self.grabOrderBtn setTitle:@"派单" forState:(UIControlStateNormal)];
      }else{
        [self.grabOrderBtn setTitle:@"抢单" forState:(UIControlStateNormal)];
      }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _typeLab.text = _controllerModel.type_name;
    [self.tableView reloadData];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 12, SCREEN_WIDTH - 65, (SCREEN_HEIGHT/750)*177) style:(UITableViewStylePlain)];
        [_tableView registerNib:[UINib nibWithNibName:@"PSWorkOrderDetailsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PSWorkOrderDetailsCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"PSWorkOrderDetalisImageCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PSWorkOrderDetalisImageCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     if (_controllerModel.add.length == 0) {
          return 5;
     }else{
          return 6;
     }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_controllerModel.add.length == 0) {
        PSWorkOrderDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PSWorkOrderDetailsCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLab.text = self.leftArr[indexPath.row ];
        if (indexPath.row == 0) {
            cell.detailsLab.text =_controllerModel.name;
        }else if (indexPath.row == 1){
            cell.detailsLab.text =_controllerModel.tel;
        }else if (indexPath.row == 2){
            cell.detailsLab.text = _controllerModel.time;
        }else if (indexPath.row == 3){
            cell.detailsLab.text =@"暂无";
        }else if (indexPath.row == 4){
            cell.detailsLab.text =_controllerModel.remarks;
        }
        return cell;
    }else{
        if (indexPath.row == 0) {
            PSWorkOrderDetalisImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PSWorkOrderDetalisImageCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.addressLab.text = _controllerModel.add?:@"";
            return cell;
        }else{
            PSWorkOrderDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PSWorkOrderDetailsCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleLab.text = self.leftArr[indexPath.row -1];
            if (indexPath.row == 1) {
                cell.detailsLab.text =_controllerModel.name;
            }else if (indexPath.row == 2){
                cell.detailsLab.text =_controllerModel.tel;
            }else if (indexPath.row == 3){
                cell.detailsLab.text = _controllerModel.time;
            }else if (indexPath.row == 4){
                cell.detailsLab.text =@"暂无";
            }else if (indexPath.row == 5){
                cell.detailsLab.text =_controllerModel.remarks;
            }
            return cell;
        }
    }
   
}
- (IBAction)grabOrderAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

    if ([UserManager iscaptain].integerValue == 1) {
        //队长
        if (_block) {
            _block(nil,WorkOrderAlertDistribute);
        }
    }else{
        //队员
        if (_block) {
            _block(nil,WorkOrderAlertGrab);
        }
    }
}
- (IBAction)nextAction:(id)sender {
    if (_block) {
        _block(nil,WorkOrderAlertNext);
    }
}

- (IBAction)cancleAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    if (_block) {
        _block(nil,WorkOrderAlertClose);
    }
}
- (IBAction)BequietAction:(id)sender {
    if (_block) {
        _block(nil,WorkOrderAlertQuiet);
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
