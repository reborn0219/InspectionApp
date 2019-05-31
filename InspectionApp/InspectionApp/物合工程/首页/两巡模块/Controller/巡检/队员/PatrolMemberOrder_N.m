//
//  PatrolMemberOrder_N.m
//  物联宝管家
//
//  Created by yang on 2019/3/26.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolMemberOrder_N.h"
#import "PPmemberScanHeaderView.h"
#import "PatrolDeviceCell.h"
#import "PPMemberDetailCommitVC.h"
#import "PPDeviceListModel.h"
#import "LSCircularProgressView.h"
@interface PatrolMemberOrder_N ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    CGFloat _oldY;
    BOOL _isUp;
}
@property (nonatomic,strong)PPmemberScanHeaderView * phView;
@property (nonatomic,strong)UIView * backView;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *deviceArr;
@property(nonatomic, copy)NSString *work_sheet_status;
@property (nonatomic, strong)PPDeviceListModel *deviceModel;
@property (nonatomic,strong) LSCircularProgressView *gradientArcChart;

@end

@implementation PatrolMemberOrder_N


#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mapView setHidden:YES];
    _deviceArr = [NSMutableArray array];

    [self creatUI];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:5];
    [self setBarTitle:@"设备组信息"];
    self.work_sheet_status = @"0";
    [self requestData];
    [_phView assignmentWithGroupModel:_controllerModel];
    
     [_gradientArcChart setProgress:_controllerModel.device_number Inspection:_controllerModel.inspected_number Abnormal:_controllerModel.abnormal_number];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self hiddenNaBar];
}
-(void)creatUI{
    MJWeakSelf
    [self.view addSubview:self.phView];
  
    _phView.eventBlock = ^(id  _Nullable data, UIView * _Nullable view, NSInteger index) {
        weakSelf.work_sheet_status = data;
        [weakSelf  requestData];
    };
    
     _gradientArcChart = [[LSCircularProgressView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-90,30,90,90)];
    [_phView addSubview:_gradientArcChart];
    
    [_phView isTeam];
    [_phView mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NavBar_H);
        make.height.equalTo(@150);
    }];
    
    [self.view addSubview:self.backView];
    [_backView mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(_phView.mas_bottom).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.phView.mas_bottom).offset(0);
        make.height.equalTo(@(KScreenHeight-NavBar_H-150));
    }];
    
    self.tableView.mj_header = [PPMJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
}
#pragma mark - lazy loading
-(PPmemberScanHeaderView *)phView{
    if (!_phView) {
        _phView = [[[NSBundle mainBundle]loadNibNamed:@"PPmemberScanHeaderView" owner:self options:nil] lastObject];
    }
    return _phView;
}
-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.alpha = 0;
    }
    return _backView;
}
-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(15,181+NavBar_H,KScreenWigth-30,KScreenHeight-182-NavBar_H-48) style:UITableViewStylePlain];
        _tableView.backgroundColor  =[UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight=44;
        _tableView.rowHeight=UITableViewAutomaticDimension;
        [_tableView registerNib:[UINib nibWithNibName:@"PatrolDeviceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PatrolDeviceCell"];
      
    }
    return _tableView;
}
- (void)requestData
{
    MJWeakSelf
    [PatrolHttpRequest membergroupdevicelist:@{@"work_id":weakSelf.work_id,@"group_id":weakSelf.group_id,@"work_sheet_status":self.work_sheet_status}:^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            NSDictionary *obj = data;
            [_deviceArr removeAllObjects];
            [_deviceArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:[PPDeviceListModel class] json:[obj objectForKey:@"device_list"]]];
            [weakSelf.tableView reloadData];
        }
        [weakSelf.tableView.mj_header endRefreshing];

    }];
}
#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _deviceArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PatrolDeviceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolDeviceCell"];
    cell.backgroundColor = [UIColor clearColor];
    PPDeviceListModel *deviceModel = [_deviceArr objectAtIndex:indexPath.row];
    [cell assignmentWithModel:deviceModel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PPMemberDetailCommitVC * pdcVC = [[PPMemberDetailCommitVC alloc]init];
    PPDeviceListModel *deviceModel = [_deviceArr objectAtIndex:indexPath.row];
    pdcVC.work_sheet_id = deviceModel.work_sheet_id;
    pdcVC.work_sheet_status = deviceModel.work_sheet_status;
    [self.navigationController pushViewController:pdcVC animated:YES];
    
}

-(void)scrollAnimationUp{

    [UIView animateWithDuration:0.5 animations:^{
        _backView.alpha = 1;
        _tableView.transform = CGAffineTransformMakeTranslation(0,-(KScreenHeight-NavBar_H-150)+150);
    } completion:^(BOOL finished) {
        _isUp = YES;
       
    }];

}
-(void)scrollAnimationDown{
    _isUp = NO;
    [UIView animateWithDuration:0.5 animations:^{
        _backView.alpha = 0;
        _tableView.transform = CGAffineTransformMakeTranslation(0,0);
    }];
}
//
//
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    if ([scrollView isEqual: self.tableView]) {
//        if (self.tableView.contentOffset.y > _oldY) {
//            // 上滑
//            if (!_isUp) {
//                [self scrollAnimationUp];
//            }
//            
//            
//        }else{
//            
//            CGFloat contentOffsetY = scrollView.contentOffset.y;
//            if (contentOffsetY<=-40) {
//                // 下滑
//                [self scrollAnimationDown];
//            }
//            
//        }
//    }
//}
//
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    _oldY = self.tableView.contentOffset.y;
//}

#pragma mark - FetchData
- (void)fetchData{
    
}


#pragma mark - CommonMethod





#pragma mark - SetUpUI
- (void)setUpUI{
    
}

#pragma mark - LazyLoad



#pragma mark - UITableViewDelegate,UITableViewDataSource
/*
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
 }*/
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
//
//                        PatrolOrderDetailVC *derailVC = [[PatrolOrderDetailVC alloc]init];
//                        derailVC.work_id=work_id;
//                        derailVC.device_id = device_id;
//                        derailVC.work_sheet_id =work_sheet_id;
//                        [weakSelf.navigationController pushViewController:derailVC animated:YES];
                        
                    }else if ([UserManager iscaptain].integerValue == 0) {
                        
                        PPMemberDetailCommitVC *derailVC = [[PPMemberDetailCommitVC alloc]init];
                        derailVC.work_sheet_id = work_sheet_id;
                        [weakSelf.navigationController pushViewController:derailVC animated:YES];
                    }
                }
                
                
            }
        }];
    }
    
    
    //    {"device_id":"133","device_number":"SB20190425000133"}
    
    
}
@end
