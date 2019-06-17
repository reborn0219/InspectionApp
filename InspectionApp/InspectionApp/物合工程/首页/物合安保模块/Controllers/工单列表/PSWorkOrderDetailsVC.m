//
//  PSWorkOrderDetailsVC.m
//  InspectionApp
//
//  Created by guokang on 2019/6/9.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWorkOrderDetailsVC.h"
#import "PSWODetailsHeaderCell.h"
#import "PSWODetailsImageCell.h"
#import "PSWODetailsSignatureCell.h"
#import "PSWODetailsVoiceCell.h"
#import "PSWODetailsVideoCell.h"
#import "PSWorkOrderDetailsCell.h"
#import "PSWODetailsListCell.h"
#import "PSWODetailsQrCodeCell.h"
#import "PSWODetailsDescriptionCell.h"
#import "SecurityRequest.h"
#import "BottomBarView.h"
#import "OwnerSignatureVC.h"
#import "PSWOMarkFinishedWorkVC.h"
#import "PSWODetailsDistributeVC.h"
#import "PSWOHeaderInvalidMarkVC.h"

@interface PSWorkOrderDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * titleArr;
}
@property (nonatomic, strong)BottomBarView  *bottomV;
@property (nonatomic, strong)UITableView  *tableView;
@property (nonatomic,strong) NSMutableArray *cellArr;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong) OrderDetailModel *controllerModel;
@end

@implementation PSWorkOrderDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _cellArr = [NSMutableArray array];
    _dataArr = [NSMutableArray array];
     NSArray * arr = @[@"PSWODetailsHeaderCell",@"PSWODetailsSignatureCell",@"PSWODetailsDescriptionCell",@"PSWODetailsVoiceCell",@"PSWODetailsImageCell",@"PSWODetailsVideoCell",@"PSWODetailsListCell",@"PSWODetailsQrCodeCell"];
    titleArr = @[@"工作性质",@"工作编号",@"安保人",@"安保电话",@"预约时间",@"安保时间",@"执行状态",@"服务人",@"联系方式",@"开始服务时间",@"服务费",@"用户承担费用",@"服务开始时间",@"服务结束时间",@"完工时间",@"备注",@"服务质量",@"满意度",@"其他建议"];
    [_cellArr addObjectsFromArray:arr];
    [self showNaBar:2];
    [self setBarTitle:@"工单详情"];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomV];
    MJWeakSelf
    self.bottomV.block = ^(id  _Nullable data, WorkAlertType type) {
         if (type == WorkOrderAlertMarkInvalid)
        {
             PSWOHeaderInvalidMarkVC  *invalidMarkVC = [[PSWOHeaderInvalidMarkVC alloc]init];
                [invalidMarkVC showInVC:weakSelf];
                invalidMarkVC.block = ^(id  _Nullable data, WorkAlertType type) {
                    NSString *remarks = data;
                    [weakSelf requestEditInvalid:weakSelf.controllerModel.repair_id work_remarks:remarks];
                };
        }else if (type == WorkOrderAlertTranform){
            PSWODetailsDistributeVC  *transferVC = [[PSWODetailsDistributeVC alloc]init];
            [transferVC showInVC:weakSelf];
            transferVC.type = 1;
            transferVC.block = ^(id  _Nullable data, WorkAlertType type) {
                NSDictionary *dict = data;
                [weakSelf requestTransformWorkOrders:weakSelf.controllerModel.repair_id Remarks:[dict objectForKey:@"remarks"] Repair_user_id:[dict objectForKey:@"repair_user_id"]];
            };
        }else if (type == WorkOrderAlertDistribute){
        PSWODetailsDistributeVC  *distributeVC = [[PSWODetailsDistributeVC alloc]init];
        [distributeVC showInVC:weakSelf];
        distributeVC.type = 0;
        distributeVC.block = ^(id  _Nullable data, WorkAlertType type) {
            NSDictionary *dict = data;
             [weakSelf requestDistributeWorkOrder:weakSelf.controllerModel.repair_id Remarks:[dict objectForKey:@"remarks"] Repair_user_id:[dict objectForKey:@"repair_user_id"]];
            };
        }else if (type == WorkOrderAlertHandle){
            [weakSelf requestHandleWorkOrder:weakSelf.controllerModel.repair_id];
        }else if (type == WorkOrderAlertGrab){
            [weakSelf requestGrabWorkOrders:weakSelf.controllerModel.repair_id];
        }
    };
    

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}
-(BottomBarView*)bottomV{
    if (!_bottomV) {
        _bottomV = BundleToObj(@"BottomBarView");
        [_bottomV assginmentWithType:self.type];
        [_bottomV setFrame:CGRectMake(0, SCREEN_HEIGHT-55, SCREEN_WIDTH, 55)];
    }
    return _bottomV;
}
-(UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(15,NavBar_H,SCREEN_WIDTH-30 ,SCREEN_HEIGHT-NavBar_H) style:UITableViewStyleGrouped];
        _tableView.scrollEnabled = YES;
        _tableView.backgroundColor  =[UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight=UITableViewAutomaticDimension;
        for (NSString *cellIdentifier in _cellArr) {
            [_tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
        }
        
  
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _cellArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIndentifier = [_cellArr objectAtIndex:indexPath.section];
    WorkOrderBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;

    if ([cellIndentifier isEqualToString:@"PSWODetailsListCell"]) {
        
        if (indexPath.row<_dataArr.count&&indexPath.row<titleArr.count) {
            NSString * content = [_dataArr objectAtIndex:indexPath.row];
            NSString * title = [titleArr objectAtIndex:indexPath.row];
            [cell assignmentWithModel:@[title,content]];
        }
     
    }else{
        [cell assignmentWithModel:_controllerModel];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *cellIndentifier = [_cellArr objectAtIndex:section];

    if ([cellIndentifier isEqualToString:@"PSWODetailsListCell"]) {
        return _dataArr.count;
        
    }else{
        return 1;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *cellIndentifier = [_cellArr objectAtIndex:section];
    if ([cellIndentifier isEqualToString:@"PSWODetailsListCell"]) {

        UIView * v = [[UIView alloc]init];
        UILabel * lb = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 40)];
        [v addSubview:lb];
        lb.text = @"执行情况";
        return v;

    }
    return [UIView new];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.3f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    NSString *cellIndentifier = [_cellArr objectAtIndex:section];
    
    if ([cellIndentifier isEqualToString:@"PSWODetailsListCell"]) {
         return 40;
    }else{
        return 0.3f;
    }
   
}
-(void)requestData{
    MJWeakSelf
    [SecurityRequest security_info:_repair_id :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            NSLog(@"%@",data);
            weakSelf.controllerModel = [OrderDetailModel yy_modelWithJSON:data];
            if (weakSelf.controllerModel.repaird.autograph==nil||weakSelf.controllerModel.repaird.autograph.length==0) {
                [weakSelf.cellArr removeObject:@"PSWODetailsSignatureCell"];
            }
            NSArray *imgs = weakSelf.controllerModel.ivv_json.images;
            NSArray *videos = weakSelf.controllerModel.ivv_json.video;
            NSArray *voics = weakSelf.controllerModel.ivv_json.voice;
            if (imgs.count==0||imgs==nil) {
                [weakSelf.cellArr removeObject:@"PSWODetailsImageCell"];

            }
            if (videos.count==0||videos==nil) {
                [weakSelf.cellArr removeObject:@"PSWODetailsVideoCell"];

            }
            if (voics.count==0||voics==nil) {
                [weakSelf.cellArr removeObject:@"PSWODetailsVoiceCell"];

            }
            [weakSelf dealWithData];
        }
    }];
}
-(void)dealWithData{
    
    [_dataArr addObject:@"公共服务"];
    [_dataArr addObject:_controllerModel.repair_no];
    [_dataArr addObject:_controllerModel.name];
    [_dataArr addObject:_controllerModel.contact];
    [_dataArr addObject:_controllerModel.repair_time];
    [_dataArr addObject:_controllerModel.post_time];
    if ([_controllerModel.repair_status isEqualToString:@"处理中"]){
        [_dataArr addObject:_controllerModel.repair_status];
        [_dataArr addObject:_controllerModel.repaird.repair_master_name];
        [_dataArr addObject:_controllerModel.repaird.repair_master_phone];
        [self showNaBar:200];
        [self setBarTitle:@"工单详情"];
    }else if ([_controllerModel.repair_status isEqualToString:@"已处理"]){
        [_dataArr addObject:_controllerModel.repair_status];
        [_dataArr addObject:_controllerModel.repaird.repair_master_name];
        [_dataArr addObject:_controllerModel.repaird.repair_master_phone];
        [_dataArr addObject:_controllerModel.repaird.come_in_time];
        [_dataArr addObject:_controllerModel.repaird.service_charge];
        [_dataArr addObject:_controllerModel.repaird.owner_cost];
        [_dataArr addObject:_controllerModel.repaird.post_time];
        [_dataArr addObject:_controllerModel.repaird.come_out_time];
        [_dataArr addObject:_controllerModel.repaird.finished_time];
        [_dataArr addObject:_controllerModel.repaird.work_remarks];
        
    }else if ([_controllerModel.repair_status isEqualToString:@"已完成"]){
        [_dataArr addObject:_controllerModel.repair_status];
        [_dataArr addObject:_controllerModel.repaird.repair_master_name];
        [_dataArr addObject:_controllerModel.repaird.repair_master_phone];
        [_dataArr addObject:_controllerModel.repaird.come_in_time];
        [_dataArr addObject:_controllerModel.repaird.service_charge];
        [_dataArr addObject:_controllerModel.repaird.owner_cost];
        [_dataArr addObject:_controllerModel.repaird.post_time];
        [_dataArr addObject:_controllerModel.repaird.come_out_time];
        [_dataArr addObject:_controllerModel.repaird.finished_time];
        [_dataArr addObject:_controllerModel.repaird.work_remarks];
        
        [_dataArr addObject:_controllerModel.service_quality];
        [_dataArr addObject:_controllerModel.satisfied];
        [_dataArr addObject:_controllerModel.contents];
    }
   
    [self.tableView reloadData];

}
- (void)requestGrabWorkOrders:(NSString *)repair_id
{
    MJWeakSelf
    [SecurityRequest grab:repair_id :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            NSString *success = data;
            [GJMBProgressHUD showSuccess:success];
        [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}
-(void)requestEditInvalid:(NSString *)repair_id work_remarks:(NSString *)work_remarks
{
    MJWeakSelf
    [SecurityRequest edit_invalid:repair_id Work_remarks:work_remarks :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            NSString *success = data;
            [GJMBProgressHUD showSuccess:success];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}
- (void)requestHandleWorkOrder:(NSString *)repair_id
{
    MJWeakSelf
    [SecurityRequest receive:repair_id :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            NSString *success = data;
            [GJMBProgressHUD showSuccess:success];
        [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}
- (void)requestDistributeWorkOrder:(NSString *)repair_id Remarks:(NSString *)remarks Repair_user_id:(NSString *)repair_user_id
{
    MJWeakSelf
    [SecurityRequest fen_pei:repair_id Remarks:remarks Repair_user_id:repair_user_id :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            NSString *success = data;
            [GJMBProgressHUD showSuccess:success];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}
- (void)requestTransformWorkOrders:(NSString *)repair_id Remarks:(NSString *)remarks Repair_user_id:(NSString *)repair_user_id
{
    MJWeakSelf
    [SecurityRequest  repair_transfer:repair_id Remarks:remarks Repair_user_id:repair_user_id :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            NSString *success = data;
            [GJMBProgressHUD showSuccess:success];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
}

-(void)markOverAction
{
    PSWOMarkFinishedWorkVC *qm=[[PSWOMarkFinishedWorkVC alloc]init];
    qm.controllerModel = _controllerModel;
    [self.navigationController pushViewController:qm animated:YES];
}
@end
