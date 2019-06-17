//
//  PSBasicWorkOrderVC.m
//  InspectionApp
//
//  Created by guokang on 2019/5/31.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSBasicWorkOrderVC.h"
#import "PPNoDataView.h"
#import "PSWOHeaderTextCell.h"
#import "PSWOHeaderImagaeCell.h"
#import "PSWOHeaderVoiceCell.h"
#import "PSWOHeaderVideoCell.h"
#import "PSWODetailsDistributeVC.h"
#import "PSWOHeaderInvalidMarkVC.h"
#import "PSTranformWorkOrderVC.h"
#import "PSWOMarkFinishedWorkVC.h"
#import "PSWorkOrderDetailsVC.h"
#import "WorkOrderListModel.h"
#import "GJZXVideo.h"
#import "GJVideoPlayViewController.h"

@interface PSBasicWorkOrderVC ()<UITableViewDataSource,UITableViewDelegate>
{
    
    NSString *pageSize;
}
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray  *task_listArr;
@property (nonatomic, strong)NSString *currentPage;
@end

@implementation PSBasicWorkOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = @"1";
    pageSize = @"30";
    // Do any additional setup after loading the view.

   PSWODetailsDistributeVC  *transferVC = [[PSWODetailsDistributeVC alloc]init];
    transferVC.type = 1;
    [self.view addSubview:self.tableView];
    MJWeakSelf
    self.tableView.mj_header = [PPMJRefreshHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = @"1";
        [weakSelf requestDataWithOrderType:self.orderType];
    }];
}
- (void)requestDataWithOrderType:(NSInteger)orderType{
    MJWeakSelf
     self.tableView.tableHeaderView = [UIView new];
    [SecurityRequest security_list:[PPViewTool orderTypeToString:orderType] Page:self.currentPage :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            NSLog(@"security_list====%@",data);
            NSDictionary * obj = data;
            NSArray * task_list = [obj objectForKey:@"repair_data"];
            NSArray * modelArr = [NSArray yy_modelArrayWithClass:[WorkOrderListModel class] json:task_list];
            if (weakSelf.currentPage.integerValue == 1) {
            [weakSelf.task_listArr removeAllObjects];
            }
            [weakSelf.task_listArr addObjectsFromArray:modelArr];
            [weakSelf.tableView reloadData];
            if (weakSelf.task_listArr.count == 0) {
                weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
            }
        }else{
            if (weakSelf.currentPage.integerValue>=1) {
                weakSelf.currentPage = [NSString stringWithFormat:@"%ld",(long)weakSelf.currentPage.integerValue-1];
            }
            [weakSelf.task_listArr removeAllObjects];
            weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
        }
        [self.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
}
#pragma mark ====== lazy loading ======
- (PPNoDataView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [[[NSBundle mainBundle]loadNibNamed:@"PPNoDataView" owner:self options:nil]lastObject];
        [_noDataView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT/2)];
    }
    return _noDataView;
}
-(NSMutableArray *)task_listArr{
    if (!_task_listArr) {
        _task_listArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _task_listArr;
}

-(UITableView *)tableView{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,self.view.bounds.size.width, self.view.bounds.size.height-NavBar_H-30) style:UITableViewStylePlain];
        _tableView.backgroundColor  =[UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight=UITableViewAutomaticDimension;
        [_tableView registerNib:[UINib nibWithNibName:@"PSWOHeaderTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PSWOHeaderTextCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"PSWOHeaderImagaeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PSWOHeaderImagaeCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"PSWOHeaderVoiceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PSWOHeaderVoiceCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"PSWOHeaderVideoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PSWOHeaderVideoCell"];

    }
    return _tableView;
}
#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _task_listArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MJWeakSelf
    WorkOrderListModel *cellModel = self.task_listArr[indexPath.row];
    WorkOrderBaseCell *cell =[tableView dequeueReusableCellWithIdentifier:[self getCellIdentitifierWithType:cellModel.ivv_type.integerValue]];

    NSObject *obj = (NSObject*)cellModel;
    [cell assignmentWithModel:obj];
    cell.block = ^(id  _Nullable data, WorkAlertType type) {
        switch (type) {
            case WorkOrderAlertGrab:
            {
                [weakSelf requestGrabWorkOrders:cellModel.repair_id];
            }
                break;
              case WorkOrderAlertMarkInvalid:
            {
                PSWOHeaderInvalidMarkVC  *invalidMarkVC = [[PSWOHeaderInvalidMarkVC alloc]init];
                [invalidMarkVC showInVC:weakSelf];
                invalidMarkVC.block = ^(id  _Nullable data, WorkAlertType type) {
                    NSString *remarks = data;
                    [SecurityRequest edit_invalid:cellModel.repair_id Work_remarks:remarks :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
                        if (resultCode == SucceedCode) {
                            NSString *success = data;
                            [GJMBProgressHUD showSuccess:success];
                            [weakSelf.task_listArr removeAllObjects];
                            [weakSelf requestDataWithOrderType:self.orderType];
                        }
                    }];
                };
                
            }
                break;
                case WorkOrderAlertHandle:
            {
                [weakSelf requestHandleWorkOrder:cellModel.repair_id];
            }
                break;
                case WorkOrderAlertDistribute:
            {
                 PSWODetailsDistributeVC  *distributeVC = [[PSWODetailsDistributeVC alloc]init];
                [distributeVC showInVC:weakSelf];
                distributeVC.block = ^(id  _Nullable data, WorkAlertType type) {
                    NSDictionary *dict = data;
                  
                    [SecurityRequest fen_pei:cellModel.repair_id Remarks:[dict objectForKey:@"remarks"]  Repair_user_id:[dict objectForKey:@"repair_user_id"] :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
                        if (resultCode == SucceedCode) {
                            NSString *success = data;
                            [GJMBProgressHUD showSuccess:success];
                            [weakSelf.task_listArr removeAllObjects];
                            [weakSelf requestDataWithOrderType:self.orderType];
                        }
                    }];
                    
                };
               
            }
                break;
                case WorkOrderAlertTranform:
            {
                PSWODetailsDistributeVC  *transferVC = [[PSWODetailsDistributeVC alloc]init];
                transferVC.type = 1;
                [transferVC showInVC:weakSelf];
                transferVC.block = ^(id  _Nullable data, WorkAlertType type) {
                    NSDictionary *dict = data;
                    [SecurityRequest  repair_transfer:cellModel.repair_id Remarks:[dict objectForKey:@"remarks"] Repair_user_id:[dict objectForKey:@"repair_user_id"] :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
                        if (resultCode == SucceedCode) {
                            NSString *success = data;
                            [GJMBProgressHUD showSuccess:success];
                            [weakSelf.task_listArr removeAllObjects];
                            [weakSelf requestDataWithOrderType:self.orderType];
                        }
                    }];
                };
            }
                break;
                case WorkOrderAlertPlayVedio:
            {
                NewOrderModelIvv_json *json = cellModel.ivv_json;
                NSDictionary *dict = [json.video objectAtIndex:0];
                NSString *videoUrl =[dict objectForKey:@"video"];
                if (videoUrl.length) {
                    GJZXVideo *video = [[GJZXVideo alloc] init];
                    video.playUrl = videoUrl;
                    GJVideoPlayViewController *vc = [[GJVideoPlayViewController alloc] init];
                    vc.video = video;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
                break;
                case WorkOrderAlertPlayVoice:
            {
                
            }
            default:
                break;
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (NSString *)getCellIdentitifierWithType:(NSInteger)type
{
          //3视频，2语音，1图片，0文字
    switch (type) {
        case 0:
            return @"PSWOHeaderTextCell";
            break;
        case 1:
            return @"PSWOHeaderImagaeCell";
            break;
        case 2:
            return @"PSWOHeaderVoiceCell";
            break;
        case 3:
            return @"PSWOHeaderVideoCell";
            break;
        default:
            break;
    }
    return @"";
}
- (void)requestGrabWorkOrders:(NSString *)repair_id
{
    MJWeakSelf
    [SecurityRequest grab:repair_id :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            NSString *success = data;
            [GJMBProgressHUD showSuccess:success];
            [weakSelf.task_listArr removeAllObjects];
            [weakSelf requestDataWithOrderType:self.orderType];
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
            [weakSelf.task_listArr removeAllObjects];
            [weakSelf requestDataWithOrderType:self.orderType];
        }
    }];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorkOrderListModel *cellModel = self.task_listArr[indexPath.row];
    PSWorkOrderDetailsVC *detailsVC = [[PSWorkOrderDetailsVC alloc]init];
    detailsVC.repair_id = cellModel.repair_id;
    detailsVC.type = self.orderType;
    [self.navigationController pushViewController:detailsVC animated:YES];
}

@end
