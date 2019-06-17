//
//  PatrolTeamAndDeviceVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/22.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolTeamAndDeviceVC.h"
#import "PPCommunityOrderListVC.h"
#import "PatrolDeviceCell.h"
#import "PatrolOrderCell.h"
#import "PatrolOrderDetailVC.h"
#import "PPViewTool.h"

@interface PatrolTeamAndDeviceVC ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger sections;
    BOOL isTeam; //1.设备组 2.所有设备
    NSInteger line_w;
}
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) UIView *topSelectView;
@property(nonatomic,strong)NSMutableArray *groupArr;
@property(nonatomic,strong)NSMutableArray *deviceArr;
@property(nonatomic,strong)UIButton * btn_1;
@property(nonatomic,strong)UIButton * btn_2;
@property(nonatomic,strong)UIButton * btn_3;
@property(nonatomic,strong)UIButton * btn_4;
@property(nonatomic,strong)UIView * v_1;
@property(nonatomic,strong)UIView * v_2;
@property(nonatomic,strong)UIView * v_3;
@property(nonatomic,strong)UIView * v_4;

@end

@implementation PatrolTeamAndDeviceVC



#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    line_w = 30;
    self.work_sheet_status = @"0";
    [self creatUI];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:YES];

    self.
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:7];
    [self setBarTitle:@""];
    if (isTeam) {
        [self requestGroupData];
    }else{
        [self requestData];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self hiddenNaBar];
    
}

-(void)requestGroupData{
    MJWeakSelf
    self.tableView.tableHeaderView = [UIView new];
    [PatrolHttpRequest inspectdevicelist:@{@"community_id":weakSelf.community_id,@"work_id":weakSelf.work_id} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            
            NSDictionary * obj = data;
            [weakSelf.groupArr removeAllObjects];
            [weakSelf.groupArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:[PPDeviceGroupModel class] json:[obj objectForKey:@"device_group_list"]]];
            [weakSelf.tableView reloadData];
            if (weakSelf.groupArr.count == 0) {
                weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
            }
        }else{
            weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
        }
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}
-(void)requestData{
    
    MJWeakSelf
      self.tableView.tableHeaderView = [UIView new];
    [PatrolHttpRequest alldevice:@{@"community_id":weakSelf.community_id,@"work_id":weakSelf.work_id,@"work_sheet_status":weakSelf.work_sheet_status} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            NSDictionary * obj = data;
            
            [weakSelf.deviceArr removeAllObjects];
            [weakSelf.deviceArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:[PPDeviceListModel class] json:[obj objectForKey:@"device_list"]]];
            [weakSelf.tableView reloadData];
            if (weakSelf.deviceArr.count == 0) {
                weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
            }
        }else{
            weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
        }
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

-(void)creatUI{
    
    [self.view addSubview:self.topSelectView];
    [self.topSelectView setHidden:YES];
    [self.view addSubview:self.tableView];
    _deviceArr = [NSMutableArray array];
    _groupArr = [NSMutableArray array];
    [self.tableView mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NavBar_H);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.bottom.equalTo(self.view).offset(0);

    }];
    isTeam = YES;
    MJWeakSelf
    self.tableView.mj_header = [PPMJRefreshHeader headerWithRefreshingBlock:^{
        if (isTeam) {
            [weakSelf requestGroupData];
        }else{
            [weakSelf requestData];
        }
    }];
}

- (void)topBtnAction:(id)sender {
    
    UIButton * btn = (UIButton *)sender;
    
    [_btn_1 setTitleColor:HexRGB(0x777777) forState:UIControlStateNormal];
    [_btn_2 setTitleColor:HexRGB(0x777777) forState:UIControlStateNormal];
    [_btn_3 setTitleColor:HexRGB(0x777777) forState:UIControlStateNormal];
    [_btn_4 setTitleColor:HexRGB(0x777777) forState:UIControlStateNormal];
    [_v_2 setHidden:YES];
    [_v_3 setHidden:YES];
    [_v_4 setHidden:YES];
    [_v_1 setHidden:YES];
    
    if (btn.tag == 100) {
        //全部
        [_v_1 setHidden:NO];
        [_btn_1 setTitleColor:HexRGB(0x46CCD9) forState:UIControlStateNormal];
        self.work_sheet_status = @"0";
    }else if (btn.tag == 101) {
        //正常
        [_v_2 setHidden:NO];
        [_btn_2 setTitleColor:HexRGB(0x46CCD9) forState:UIControlStateNormal];
        self.work_sheet_status = @"2";
    }else if (btn.tag == 102) {
        //异常
        [_v_3 setHidden:NO];
        [_btn_3 setTitleColor:HexRGB(0x46CCD9) forState:UIControlStateNormal];
       self.work_sheet_status = @"3";
    }else if (btn.tag == 103) {
        //未巡查
        [_v_4 setHidden:NO];
        [_btn_4 setTitleColor:HexRGB(0x46CCD9) forState:UIControlStateNormal];
      self.work_sheet_status = @"1";
    }
    [self requestData];
}

-(void)segementDidSelected:(NSInteger)type{
    if (type==10) {
        
        [self.tableView mas_updateConstraints:^(GJMASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(NavBar_H);
        }];
        isTeam = YES;
        [_topSelectView setHidden:YES];
        [self requestGroupData];
        [self.tableView reloadData];
    }else{
        [self.tableView mas_updateConstraints:^(GJMASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(NavBar_H+45);
            
        }];
        [_topSelectView setHidden:NO];
        isTeam = NO;
        [self requestData];
     [self.tableView reloadData];
    }
}
-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(15,NavBar_H,KScreenWigth-30,KScreenHeight-NavBar_H) style:UITableViewStylePlain];
        _tableView.backgroundColor  =[UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight=44;
        _tableView.rowHeight=UITableViewAutomaticDimension;
        [_tableView registerNib:[UINib nibWithNibName:@"PatrolOrderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PatrolOrderCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"PatrolDeviceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PatrolDeviceCell"];
    }
    return _tableView;
}
-(UIView *)topSelectView{
    if (!_topSelectView) {
        
        _topSelectView = [[UIView alloc]initWithFrame:CGRectMake(0, NavBar_H, KScreenWigth,45)];
        _btn_1= [[UIButton alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH/4,45)];
        [_btn_1 setTitle:@"全部" forState:UIControlStateNormal];
        [_btn_1 setTitleColor:HexRGB(0x46CCD9) forState:UIControlStateNormal];
        _btn_1.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_btn_1 addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _btn_1.tag = 100;
        
        _btn_2= [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4,0,SCREEN_WIDTH/4,45)];
        [_btn_2 setTitle:@"正常" forState:UIControlStateNormal];
        _btn_2.titleLabel.font = [UIFont systemFontOfSize:15.0f];

        [_btn_2 addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _btn_2.tag = 101;
        
        _btn_3= [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2,0,SCREEN_WIDTH/4,45)];
        _btn_3.titleLabel.font = [UIFont systemFontOfSize:15.0f];

        [_btn_3 setTitle:@"异常" forState:UIControlStateNormal];
        [_btn_3 addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _btn_3.tag = 102;
        
        
        _btn_4= [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4*3,0,SCREEN_WIDTH/4,45)];
        [_btn_4 setTitle:@"未巡查" forState:UIControlStateNormal];
        _btn_4.titleLabel.font = [UIFont systemFontOfSize:15.0f];

        [_btn_4 addTarget:self action:@selector(topBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        _btn_4.tag = 103;
        
        _v_1 = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/4-line_w)/2,43,line_w,2)];
        [_v_1 setBackgroundColor:HexRGB(0x46CCD9)];
        _v_2 = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/4-line_w)/2+SCREEN_WIDTH/4,43,line_w,2)];
        [_v_2 setBackgroundColor:HexRGB(0x46CCD9)];
        [_v_2 setHidden:YES];
        
        _v_3 = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/4-line_w)/2+SCREEN_WIDTH/2,43,line_w,2)];
        [_v_3 setBackgroundColor:HexRGB(0x46CCD9)];
        [_v_3 setHidden:YES];

        _v_4 = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/4-line_w)/2+SCREEN_WIDTH/4*3,43,line_w,2)];
        [_v_4 setBackgroundColor:HexRGB(0x46CCD9)];
        [_v_4 setHidden:YES];

        [_btn_2 setTitleColor:HexRGB(0x777777) forState:UIControlStateNormal];
        [_btn_3 setTitleColor:HexRGB(0x777777) forState:UIControlStateNormal];
        [_btn_4 setTitleColor:HexRGB(0x777777) forState:UIControlStateNormal];
        
        [_topSelectView addSubview:_btn_1];
        [_topSelectView addSubview:_btn_2];
        [_topSelectView addSubview:_btn_3];
        [_topSelectView addSubview:_btn_4];
        
        [_topSelectView addSubview:_v_1];
        [_topSelectView addSubview:_v_2];
        [_topSelectView addSubview:_v_3];
        [_topSelectView addSubview:_v_4];
    }
    return _topSelectView;
}
#pragma mark - TableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,50)];
//    [view setBackgroundColor:[UIColor whiteColor]];
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(0,20,90,20);
//    label.numberOfLines = 0;
//
//    NSString * str = @"设备组名";
//    if (sections == 2) {
//        if (section == 1) {
//            str = @"所有设备";
//        }
//    }else{
//        if (isTeam) {
//            str = @"设备组名";
//        }else{
//            str = @"所有设备";
//        }
//    }
//
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Semibold" size: 18],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
//    label.attributedText = string;
//    label.textAlignment = NSTextAlignmentLeft;
//    [view addSubview:label];
//
//    return view;
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isTeam) {
        return _groupArr.count;
    }else{
        return _deviceArr.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (isTeam) {
        //设备组
        PPDeviceGroupModel * model = [_groupArr objectAtIndex:indexPath.row];
        PatrolOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolOrderCell"];
        cell.backgroundColor = [UIColor clearColor];
        [cell assignmentWithGroupModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        //所有设备
        PPDeviceListModel * model = [_deviceArr objectAtIndex:indexPath.row];
        
        PatrolDeviceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolDeviceCell"];
        [cell assignmentWithModel:model];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (isTeam) {
        //设备组
        PPCommunityOrderListVC * pcolVC = [[PPCommunityOrderListVC alloc]init];
        pcolVC.work_id = self.work_id;
        PPDeviceGroupModel *groupModel = [_groupArr objectAtIndex:indexPath.row];
        pcolVC.group_id = groupModel.group_id;
        [self.navigationController pushViewController:pcolVC animated:YES];
    }else{
        //所有设备
        PatrolOrderDetailVC * pcolVC = [[PatrolOrderDetailVC alloc]init];
        PPDeviceListModel * model = [_deviceArr objectAtIndex:indexPath.row];
        pcolVC.device_id = model.device_id;
        pcolVC.work_id = self.work_id;
        pcolVC.work_sheet_id = model.work_sheet_id;
        [self.navigationController pushViewController:pcolVC animated:YES];
    }
    
}
-(void)backValue:(NSString *)value{
    NSLog(@"---------%@",value);
    NSDictionary * dic = [PPViewTool dictionaryWithJsonString:value];
    if (dic==nil) {
        [GJMBProgressHUD showError:@"二维码有误"];
        return;
    }
    NSLog(@"---------%@",dic);
    if (dic.allKeys.count == 0 || dic[@"device_id"] == nil) {
        [GJMBProgressHUD showError:@"二维码有误"];
    }else{
        MJWeakSelf
       NSString *device_id = dic[@"device_id"];
        [PatrolHttpRequest checkEquipment:@{@"device_id":dic[@"device_id"],@"work_id":self.work_id} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
            if (resultCode == SucceedCode) {
                NSLog(@"---------%@",data);
                NSDictionary * dataDic = data;
                NSString * exist = [dataDic objectForKey:@"exist"];
                NSString * work_sheet_id = [dataDic objectForKey:@"work_sheet_id"];
                if (exist.integerValue == 0) {
                    [GJMBProgressHUD showError:@"设备工单不存在"];
                    return ;
                }else{
                    
                    if ([UserManager iscaptain].integerValue == 1) {
                        NSString * work_id = [dataDic objectForKey:@"work_id"];
                        
                        PatrolOrderDetailVC *derailVC = [[PatrolOrderDetailVC alloc]init];
                        derailVC.work_id=work_id;
                        derailVC.device_id = device_id;
                        derailVC.work_sheet_id =work_sheet_id;
                        [weakSelf.navigationController pushViewController:derailVC animated:YES];

                    }else if ([UserManager iscaptain].integerValue == 0) {
                        
//                        PPMemberDetailCommitVC *derailVC = [[PPMemberDetailCommitVC alloc]init];
//                        derailVC.work_sheet_id = work_sheet_id;
//                        [weakSelf.navigationController pushViewController:derailVC animated:YES];
                    }
                }
                
                
            }
        }];
    }
    
    
    //    {"device_id":"133","device_number":"SB20190425000133"}
    
    
}

@end
