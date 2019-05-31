//
//  PPMemberTeamListVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/27.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPMemberTeamListVC.h"
#import "PatrolMemberOrder_N.h"
#import "PatrolOrderCell.h"
#import "PPmemberScanHeaderView.h"
#import "PatrolDeviceCell.h"
#import "PPMemberDetailCommitVC.h"

@interface PPMemberTeamListVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    CGFloat _oldY;
    BOOL _isUp;
    NSInteger _type;
    CGFloat phView_h;
}
@property (nonatomic,strong)PPmemberScanHeaderView * phView;
@property (nonatomic,strong)UIView * backView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *groupArr;
@property(nonatomic,strong)NSMutableArray *deviceArr;
@property(nonatomic, copy)NSString *work_sheet_status;
@end

@implementation PPMemberTeamListVC


#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    _type = 0;
  
    _deviceArr = [NSMutableArray array];
    _groupArr = [NSMutableArray array];
    phView_h = 130;
}

-(void)viewWillAppear:(BOOL)animated{
    MJWeakSelf
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:6];
    [self setBarTitle:@""];
  
    [weakSelf requestData:_type];
   
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self hiddenNaBar];
}
-(void)creatUI{
    
   MJWeakSelf
    [self.view addSubview:self.backView];
    
    [_backView mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NavBar_H);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    [self.view addSubview:self.phView];
    self.work_sheet_status = @"0";
    [_phView assignmentWithModel:self.controllerModel];
    _phView.eventBlock = ^(id  _Nullable data, UIView * _Nullable view, NSInteger index) {
        weakSelf.work_sheet_status = data;
        [weakSelf requestData:1];
    };
    [_phView hiddenBottomView:YES];
    
    [_phView mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NavBar_H);
        make.height.equalTo(@90);
    }];
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.view.mas_bottom).offset(-150);
        make.height.equalTo(@(KScreenHeight-NavBar_H-90));
    }];
    
}

-(void)segementDidSelected:(NSInteger)type{
    if (type==10) {
        _type = 0;
        
        [_phView mas_updateConstraints:^(GJMASConstraintMaker *make) {
            make.height.equalTo(@90);
        }];
        [_phView hiddenBottomView:YES];
        [_tableView mas_updateConstraints:^(GJMASConstraintMaker *make) {
            make.height.equalTo(@(KScreenHeight-NavBar_H-90));
        }];
        [self requestData:0];
    }else{
        _type = 1;
        [self requestData:1];
        [_phView hiddenBottomView:NO];

        [_phView mas_updateConstraints:^(GJMASConstraintMaker *make) {
            make.height.equalTo(@(phView_h));
        }];
        [_tableView mas_updateConstraints:^(GJMASConstraintMaker *make) {
            make.height.equalTo(@(KScreenHeight-NavBar_H-phView_h));
        }];
    }
        _tableView.transform = CGAffineTransformMakeTranslation(0,0);
        _isUp = NO;
        _backView.alpha = 0;

}
-(void)requestData:(NSInteger)type{
    
    MJWeakSelf
    if (type==0) {
        //设备组列表
        [PatrolHttpRequest memberinspectdevicelist:@{@"work_id":self.work_id,@"community_id":self.community_id} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
            
            if (resultCode == SucceedCode) {
                
                NSDictionary * obj = data;
                [_groupArr removeAllObjects];
                [_groupArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:[PPDeviceGroupModel class] json:[obj objectForKey:@"device_group_list"]]];
                [weakSelf.tableView reloadData];
                
                NSMutableArray * annotationArr = [NSMutableArray array];
                for (PPDeviceGroupModel * communityModel in _groupArr) {
                    PatrolAnnotationModel *pointAnnotation = [[PatrolAnnotationModel alloc] init];
                    pointAnnotation.coordinate = CLLocationCoordinate2DMake(communityModel.latitude.doubleValue,communityModel.longitude.doubleValue);
                    pointAnnotation.annotation_status = @"14";
                    pointAnnotation.annotation_name =  [NSString stringWithFormat:@"%@\r已巡设备%@/%@    %@个异常设备",communityModel.group_name,communityModel.inspected_number,communityModel.device_number,communityModel.abnormal_number];
                   
                    [annotationArr addObject:pointAnnotation];
                }
                
                [weakSelf addPatrolAnnotations:annotationArr];
            }
            
        }];
    }else{
        //所有设备的列表
        [PatrolHttpRequest memberalldevice:@{@"work_id":self.work_id,@"community_id":self.community_id,@"work_sheet_status":self.work_sheet_status} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
            
            if (resultCode == SucceedCode) {
                
                NSDictionary * obj = data;
              
                [_deviceArr removeAllObjects];
                [_deviceArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:[PPDeviceListModel class] json:[obj objectForKey:@"device_list"]]];
                [weakSelf.tableView reloadData];
                
                NSMutableArray * annotationArr = [NSMutableArray array];
                for (PPDeviceListModel * communityModel in _deviceArr) {
                    PatrolAnnotationModel *pointAnnotation = [[PatrolAnnotationModel alloc] init];
                    pointAnnotation.coordinate = CLLocationCoordinate2DMake(communityModel.latitude.doubleValue,communityModel.longitude.doubleValue);
                    NSString *stuteStr = @"";
                    pointAnnotation.annotation_status = @"";
                    if (communityModel.work_sheet_status.integerValue==1) {
                        pointAnnotation.annotation_status = @"2";
                    }else if (communityModel.work_sheet_status.integerValue==2) {
                        pointAnnotation.annotation_status = @"3";
                    }else if (communityModel.work_sheet_status.integerValue==3) {
                        pointAnnotation.annotation_status = @"1";
                    }
                    pointAnnotation.annotation_name =  [NSString stringWithFormat:@"%@\r%@/%@",communityModel.device_name,communityModel.inspected_count,communityModel.inspect_count];;
                    [annotationArr addObject:pointAnnotation];
                }

                [weakSelf addPatrolAnnotations:annotationArr];
            }
            
        }];
    }
  
    
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
        [_tableView registerNib:[UINib nibWithNibName:@"PatrolOrderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PatrolOrderCell"];

    }
    return _tableView;
}
#pragma mark - TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_type==0) {
        return _groupArr.count;
    }else{
        return _deviceArr.count;

    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_type==0) {
        PPDeviceGroupModel * model = [_groupArr objectAtIndex:indexPath.row];
        PatrolOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolOrderCell"];
        cell.backgroundColor = [UIColor clearColor];
        [cell assignmentWithGroupModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        PPDeviceListModel * model = [_deviceArr objectAtIndex:indexPath.row];

        PatrolDeviceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolDeviceCell"];
        [cell assignmentWithModel:model];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_type== 0) {
        //设备组列表
        PatrolMemberOrder_N * pmonVC = [[PatrolMemberOrder_N alloc]init];
        pmonVC.work_id = self.work_id;
        PPDeviceGroupModel * model = [_groupArr objectAtIndex:indexPath.row];
        pmonVC.controllerModel = model;
        pmonVC.group_id = model.group_id;
        [self.navigationController pushViewController:pmonVC animated:YES];
        
    }else{
        
        //所有设备列表
        PPMemberDetailCommitVC * pdcVC = [[PPMemberDetailCommitVC alloc]init];
        PPDeviceListModel *deviceModel = [_deviceArr objectAtIndex:indexPath.row];
        pdcVC.work_sheet_id = deviceModel.work_sheet_id;
        pdcVC.work_sheet_status = deviceModel.work_sheet_status;

        [self.navigationController pushViewController:pdcVC animated:YES];
        
    }
    
    
}

-(void)scrollAnimationUp{
    
    [UIView animateWithDuration:0.5 animations:^{
        _backView.alpha = 1;
        if (_type==0) {
            
            _tableView.transform = CGAffineTransformMakeTranslation(0,-(KScreenHeight-NavBar_H-90)+150);
        }else{
            
            _tableView.transform = CGAffineTransformMakeTranslation(0,-(KScreenHeight-NavBar_H-phView_h)+150);
        }
        
        
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

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([scrollView isEqual: self.tableView]) {
        if (self.tableView.contentOffset.y > _oldY) {
            // 上滑
            if (!_isUp) {
                [self scrollAnimationUp];
            }
            
            
        }else{
            
            CGFloat contentOffsetY = scrollView.contentOffset.y;
            if (contentOffsetY<=-40) {
                // 下滑
                [self scrollAnimationDown];
            }
            
        }
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _oldY = self.tableView.contentOffset.y;
}

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

