//
//  PatrolOrderListVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolOrderListVC.h"
#import "PatrolTaskCell.h"
#import "PatrolOrderCell.h"
#import "PatrolOnlinePlayersCell.h"
#import "OrderBottomView.h"
#import "PPOrderHeaderView.h"
#import "Masonry.h"
#import "PPSelectCarVC.h"
#import "PatrolTaskMapVC.h"
#import "PatrolTeamDetailsVC.h"
#import "PatrolTeamAndDeviceVC.h"
#import "PatrolMembersDetailVC.h"
#import "PatrolCommunityDetailVC.h"
#import "PPComunityOrderCell.h"
#import "PatrolHttpRequest.h"
#import "PPTaskDetailModel.h"
#import "PPGroupInfoModel.h"
#import "SubmitSucceedVC.h"
#import "PPLocationMapVC.h"
#import "PatrolTaskMapVC.h"
#import "PPDeviceMapVC.h"

@interface PatrolOrderListVC()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)PPOrderHeaderView *headerView;
@property(nonatomic,strong)OrderBottomView  *bottomView;
@property(nonatomic,strong)NSMutableArray  *order_listArr;
@property(nonatomic,strong)PPTaskDetailModel  *detailModel;

@end

@implementation PatrolOrderListVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:2];
    if (_type.integerValue == 1) {
        [self setBarTitle:@"任务巡查社区"];
    }else{
       [self setBarTitle:@"任务巡逻社区"];
    }
  
    [self requestData];
    
    MJWeakSelf
    self.tableView.mj_header = [PPMJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self hiddenNaBar];

}

//-(void)viewDidLayoutSubviews{
//    [super viewDidLayoutSubviews];
//    [self.headerView setFrame:CGRectMake(0, 0, KScreenWigth,180)];
//}
-(void)requestData{
    _tableView.tableHeaderView = [UIView new];
    if (_type.integerValue == 1) {//巡查
        MJWeakSelf
        [PatrolHttpRequest inspecttaskdetail:@{@"work_id":self.work_id} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
            
            if (resultCode == SucceedCode) {
                NSDictionary * obj = data;
                weakSelf.detailModel = [PPTaskDetailModel yy_modelWithJSON:obj];
                [weakSelf.headerView assignmentWithModel:weakSelf.detailModel Type:1];
                [weakSelf.tableView reloadData];
                if (weakSelf.detailModel.member_list.count == 0 && weakSelf.detailModel.community_list.count == 0) {
                    weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
                }
                if ([weakSelf.detailModel.task_status intValue]== 3) {
                    [weakSelf.bottomView setHidden:NO];
                    [weakSelf.tableView setFrame:CGRectMake(15,181+NavBar_H,KScreenWigth-30,KScreenHeight-182-NavBar_H-48)];
                }
            }else{
                weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
            }
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }else{//巡逻
        MJWeakSelf
        [PatrolHttpRequest patroltaskdetail:@{@"work_id":self.work_id,@"currentPage":@"1",@"pageSize":@"20"} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
            
            if (resultCode == SucceedCode) {
                NSDictionary * obj = data;
                weakSelf.detailModel = [PPTaskDetailModel yy_modelWithJSON:obj];
                [weakSelf.headerView assignmentWithModel:weakSelf.detailModel Type:2];

                if (weakSelf.detailModel.member_list.count == 0 && weakSelf.detailModel.community_list.count == 0) {
                    weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
                }
                if ([weakSelf.detailModel.task_status intValue]== 3) {
                    [weakSelf.bottomView setHidden:NO];
                    [weakSelf.tableView setFrame:CGRectMake(15,181+NavBar_H,KScreenWigth-30,KScreenHeight-182-NavBar_H-48)];
                }
                [weakSelf.tableView reloadData];

            }else{
               weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
            }
            [weakSelf.tableView.mj_header endRefreshing];
        }];
    }
   
}
-(void)creatUI{
    MJWeakSelf
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    [_headerView mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NavBar_H);
        make.height.equalTo(@180);
    }];
    _headerView.block = ^(NSInteger index) {
        if (index==1) {
           //小组详情
            PatrolTeamDetailsVC * ptdVC = [[PatrolTeamDetailsVC alloc]init];
            ptdVC.teamID = weakSelf.detailModel.team_id;
            ptdVC.carID = weakSelf.detailModel.car_id;
            [weakSelf.navigationController pushViewController:ptdVC animated:YES];
        }else{
             //位置任务
            PPDeviceMapVC * mapVC = [[PPDeviceMapVC alloc]init];
    
//            PatrolTaskMapVC *mapVC = [[PatrolTaskMapVC alloc]init];
            NSMutableArray * annotationArr = [NSMutableArray array];
            for (PPTaskDetailModelCommunity_list * communityModel in weakSelf.detailModel.community_list) {
                PatrolAnnotationModel *pointAnnotation = [[PatrolAnnotationModel alloc] init];
                pointAnnotation.coordinate = CLLocationCoordinate2DMake(communityModel.latitude.doubleValue,communityModel.longitude.doubleValue);
                pointAnnotation.annotation_status = communityModel.work_sheet_status;
                pointAnnotation.annotation_name = communityModel.community_name;
                if (weakSelf.type.integerValue==1) {
                    
                    pointAnnotation.annotation_name = [NSString stringWithFormat:@"%@\r设备数(%@)",communityModel.community_name,communityModel.device_number];

                }
                [annotationArr addObject:pointAnnotation];
            }
            
          mapVC.annotationArr = annotationArr;
          [weakSelf.navigationController pushViewController:mapVC animated:YES];
            
//                PatrolAnnotationModel *pointAnnotation = [[PatrolAnnotationModel alloc] init];
////                pointAnnotation.coordinate = CLLocationCoordinate2DMake(_detailModel.latitude.doubleValue,_detailModel.longitude.doubleValue);
//                pointAnnotation.annotation_status = _detailModel.task_status;
//                pointAnnotation.annotation_name = _detailModel.community_name;
//                PPLocationMapVC * mapVC = [[PPLocationMapVC alloc]init];
//                mapVC.annotionModel = pointAnnotation;
//                [self.navigationController pushViewController:mapVC animated:YES];
        }
    };
    
   
        
        [self.view addSubview:self.bottomView];
        [_bottomView mas_makeConstraints:^(GJMASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(0);
            make.right.equalTo(self.view).offset(0);
            make.bottom.equalTo(self.view).offset(0);
            make.height.equalTo(@48);
        }];
        
        _bottomView.block = ^(NSInteger index) {
            if (index==1) {
                
                
                PPSelectCarVC * ppcVC = [[PPSelectCarVC alloc]init];
//                ppcVC.isChangeCar = YES;
//                ppcVC.task_id = _detailModel.task_id;
                ppcVC.titleStr = @"更换车辆";
                [ppcVC showInVC:weakSelf];

                ppcVC.block = ^(id  _Nullable data, UIView * _Nullable view, NSInteger index) {
                    PPCarModel *carModel = data;
                    [PatrolHttpRequest carconfirm:@{@"car_id":carModel.car_id,@"task_id":weakSelf.detailModel.task_id} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
                        [GJMBProgressHUD hideHUD];

                        if (resultCode == SucceedCode) {
                            [GJMBProgressHUD showSuccess:@"车辆更换成功！"];
                        }

                    }];

                };
                
            }else{
                if (_type.integerValue == 1) {
                    
                    
                    ConfirmationVC * firmationVC = [[ConfirmationVC alloc]init];
                    [firmationVC showInVC:weakSelf withTitle:@"是否确认提交任务？"];
                    firmationVC.block = ^(NSInteger index) {
                        if (index) {
                            //确定
                            //巡检
                            [PatrolHttpRequest inspecttaskfinish:@{@"work_id":weakSelf.detailModel.work_id,@"task_id":weakSelf.detailModel.task_id} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
                                if (resultCode == SucceedCode) {
                                    [GJMBProgressHUD showSuccess:@"任务提交成功！"];
                                    [weakSelf.navigationController popViewControllerAnimated:YES];
                                }else{
                                    [GJMBProgressHUD showError:@"任务提交失败！"];
                                }
                            }];
                        }else{
                            
                            
                            
                            
                        }
                    };
                   
                }else{
                    ConfirmationVC * firmationVC = [[ConfirmationVC alloc]init];
                    [firmationVC showInVC:weakSelf withTitle:@"是否确认提交任务？"];
                    firmationVC.block = ^(NSInteger index) {
                        if (index) {
                            //巡查
                            [PatrolHttpRequest patrolinspecttaskfinish:@{@"work_id":weakSelf.detailModel.work_id,@"task_id":weakSelf.detailModel.task_id} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
                                if (resultCode == SucceedCode) {
                                    [GJMBProgressHUD showSuccess:@"任务提交成功！"];
                                    [weakSelf.navigationController popViewControllerAnimated:YES];
                                }else{
                                    [GJMBProgressHUD showError:@"任务提交失败！"];
                                }
                            }];
                            
                        }else{
                            
                            
                            
                            
                        }
                    };
                    
                    
                }
               
            }
        };
//    self.tableView.tableHeaderView = self.headerView;
}

#pragma lazy loading
-(NSMutableArray *)order_listArr{
    if (!_order_listArr) {
        _order_listArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _order_listArr;
}
-(PPOrderHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"PPOrderHeaderView" owner:self options:nil] lastObject];
    }
    return _headerView;
}
-(OrderBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[[NSBundle mainBundle]loadNibNamed:@"OrderBottomView" owner:self options:nil] lastObject];
        [_bottomView setHidden:YES];
    }
    return _bottomView;
}
-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(15,181+NavBar_H,KScreenWigth-30,KScreenHeight-182-NavBar_H) style:UITableViewStylePlain];
        _tableView.backgroundColor  =[UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight=44;
        _tableView.rowHeight=UITableViewAutomaticDimension;
        [_tableView registerNib:[UINib nibWithNibName:@"PatrolOrderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PatrolOrderCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"PatrolOnlinePlayersCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PatrolOnlinePlayersCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"PPComunityOrderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PPComunityOrderCell"];

    }
    return _tableView;
}

#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _detailModel.community_list.count +1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == _detailModel.community_list.count) {
        PatrolOnlinePlayersCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolOnlinePlayersCell"];
        MJWeakSelf
        [cell assignmentWithArray:_detailModel.member_list];
        cell.block = ^(id  _Nullable data, UIView * _Nullable view, NSIndexPath * _Nullable index) {
            PatrolMembersDetailVC * pmdVC = [[PatrolMembersDetailVC alloc]init];
            PPTaskDetailModelMember_list * memberModel = data;
            PPGroupInfoModelMember_list * infoModel = [[PPGroupInfoModelMember_list alloc]init];
            infoModel.member_name = memberModel.member_name;
            infoModel.member_phone = memberModel.memeber_phone;
            infoModel.member_id = memberModel.member_id;
            infoModel.member_avatar = memberModel.member_avatar;
            [pmdVC requestData:infoModel];
            [weakSelf.navigationController pushViewController:pmdVC animated:YES];
            
        };
      
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }else{
        PPTaskDetailModelCommunity_list * cellModel = [_detailModel.community_list objectAtIndex:indexPath.row];

        if (_type.integerValue==2) {
            PPComunityOrderCell  * cell = [tableView dequeueReusableCellWithIdentifier:@"PPComunityOrderCell"];
            [cell assignmentWithModel:cellModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            
            PatrolOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolOrderCell"];
            [cell assignmentWithModel:cellModel];
            cell.block = ^(id  _Nullable data, UIView * _Nullable view, NSIndexPath * _Nullable index)
            {
                PPTaskDetailModelCommunity_list *community = data;
                PatrolAnnotationModel *pointAnnotation = [[PatrolAnnotationModel alloc] init];
                
                pointAnnotation.coordinate = CLLocationCoordinate2DMake(community.latitude.doubleValue,community.longitude.doubleValue);
                pointAnnotation.annotation_status = _detailModel.task_status;
//                pointAnnotation.annotation_name = community.community_name;
                pointAnnotation.annotation_name = [NSString stringWithFormat:@"%@\r设备数（%@）",community.community_name,community.device_number];
                PPLocationMapVC * mapVC = [[PPLocationMapVC alloc]init];
                mapVC.annotionModel = pointAnnotation;
                [self.navigationController pushViewController:mapVC animated:YES];
            };
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }

    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     PPTaskDetailModelCommunity_list * Model = [_detailModel.community_list objectAtIndex:indexPath.row];
    if (_type.integerValue == 2) {//巡查
        
        PatrolCommunityDetailVC * pcdVC = [[PatrolCommunityDetailVC alloc]init];
        pcdVC.work_id = self.work_id;
        pcdVC.community_id = Model.community_id;
        pcdVC.tempIndex = Model.patrolled_count.integerValue-1?:0;
        pcdVC.work_sheet_id = Model.work_sheet_id;
        [self.navigationController pushViewController:pcdVC animated:YES];
        
    }else if(_type.integerValue == 1){//巡检
        
        PatrolTeamAndDeviceVC * pcolVC = [[PatrolTeamAndDeviceVC alloc]init];
        pcolVC.work_id = self.work_id;

        pcolVC.community_id = Model.community_id;
        [self.navigationController pushViewController:pcolVC animated:YES];
    }
    
}
@end


