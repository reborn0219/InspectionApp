//
//  PageOneViewController.m
//  物联宝管家
//
//  Created by yang on 2019/3/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PageOneViewController.h"
#import "PatrolTaskCell.h"
#import "PatrolOrderCell.h"
#import "PatrolUrgentTasksCell.h"
#import "PatrolUrgentMapDetailVC.h"
#import "PatrolUrgentOptionDetailVC.h"

@interface PageOneViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *currentPage;
    NSString *pageSize;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *task_listArr;
@property(nonatomic, assign)int PatrolType;
@end

@implementation PageOneViewController
#pragma mark - life cycle -----
- (void)viewDidLoad {
    [super viewDidLoad];
    currentPage = @"1";
    pageSize = @"20";
    
    [self.view addSubview:self.tableView];
    MJWeakSelf
    self.tableView.mj_header = [PPMJRefreshHeader headerWithRefreshingBlock:^{
        currentPage = @"1";
        [weakSelf pullRefresh];
    }];
//    self.tableView.mj_footer = [GJMJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        currentPage = [NSString stringWithFormat:@"%ld",(long)currentPage.integerValue+1];
//        [weakSelf pullRefresh];
//    }];
    self.view.backgroundColor = [UIColor clearColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)pullRefresh{
    MJWeakSelf
    NSString *orderType = [NSString stringWithFormat:@"%ld",(long)_orderType];
    NSString *orderCycle = [NSString stringWithFormat:@"%ld",(long)_orderCycle];
    self.tableView.tableHeaderView = [UIView new];
    if (_pageType == PageOneTypeXunJian) {
        ///巡检队长
        _PatrolType = 1;
        [PatrolHttpRequest inspecttasklist:@{@"task_status":orderType,@"task_cycle":orderCycle,@"currentPage":currentPage,@"pageSize":pageSize} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {

            
            if (resultCode == SucceedCode) {
                NSDictionary * obj = data;
                NSArray * task_list = [obj objectForKey:@"task_list"];
                NSArray * modelArr = [NSArray yy_modelArrayWithClass:[TaskListModel class] json:task_list];
                if (currentPage.integerValue==1) {
                    [self.task_listArr removeAllObjects];
                }
                [self.task_listArr addObjectsFromArray:modelArr];
                [self.tableView reloadData];
                if (self.task_listArr.count == 0) {
                    weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
                }
            }else{
                if (currentPage.integerValue>=1) {
                    currentPage = [NSString stringWithFormat:@"%ld",(long)currentPage.integerValue-1];
                }

              weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
            }
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];
        }];
        
    }else if(_pageType == PageOneTypeXunJianMember) {
        ///巡检队员
        _PatrolType = 1;

        [PatrolHttpRequest memberinspectiontasklist:@{@"task_status":orderType,@"task_cycle":orderCycle,@"currentPage":currentPage,@"pageSize":pageSize} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {

            
            if (resultCode == SucceedCode) {
                NSDictionary * obj = data;
                NSArray * task_list = [obj objectForKey:@"task_list"];
                NSArray * modelArr = [NSArray yy_modelArrayWithClass:[TaskListModel class] json:task_list];
                
                if (currentPage.integerValue==1) {
                    [self.task_listArr removeAllObjects];
                }
                [self.task_listArr addObjectsFromArray:modelArr];
                [self.tableView reloadData];
                if (self.task_listArr.count == 0) {
                  [weakSelf.tableView.tableHeaderView setHidden:NO];
                   weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
                }
            }else{
                if (currentPage.integerValue>=1) {
                    currentPage = [NSString stringWithFormat:@"%ld",(long)currentPage.integerValue-1];
                }
                weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
            }
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];

        }];
        
    }else if(_pageType == PageOneTypeXunCha) {
        ///巡查队长
        _PatrolType = 2;
        [PatrolHttpRequest patroltasklist:@{@"task_status":orderType,@"task_cycle":orderCycle,@"currentPage":currentPage,@"pageSize":pageSize} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
            
            if (resultCode == SucceedCode) {
                NSDictionary * obj = data;
                NSArray * task_list = [obj objectForKey:@"task_list"];
                NSArray * modelArr = [NSArray yy_modelArrayWithClass:[TaskListModel class] json:task_list];
                if (currentPage.integerValue==1) {
                    [self.task_listArr removeAllObjects];
                }
                [self.task_listArr addObjectsFromArray:modelArr];
                [self.tableView reloadData];
                if (self.task_listArr.count == 0) {
                    weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
                }
            }else{
                if (currentPage.integerValue>=1) {
                    currentPage = [NSString stringWithFormat:@"%ld",(long)currentPage.integerValue-1];
                }
                weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
            }
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];

        }];
        
    }else if(_pageType == PageOneTypeXunChaMember) {
        ///巡查队员
        _PatrolType = 2;
        if (_orderType!=0) {
            orderType = [NSString stringWithFormat:@"%ld",(long)_orderType+2];
        }
        
        [PatrolHttpRequest patrolmembertasklist:@{@"task_status":orderType,@"task_cycle":orderCycle,@"currentPage":currentPage,@"pageSize":pageSize} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
            
            if (resultCode == SucceedCode) {
                
                NSDictionary * obj = data;
                NSArray * task_list = [obj objectForKey:@"task_list"];
                NSArray * modelArr = [NSArray yy_modelArrayWithClass:[TaskListModel class] json:task_list];
                if (currentPage.integerValue==1) {
                    [self.task_listArr removeAllObjects];
                }
                [self.task_listArr addObjectsFromArray:modelArr];
                [self.tableView reloadData];
                if (self.task_listArr.count == 0) {
                    weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
                }
                
            }else{
                if (currentPage.integerValue>=1) {
                    currentPage = [NSString stringWithFormat:@"%ld",(long)currentPage.integerValue-1];
                }
                weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
            }
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];


        }];
    }else if(_pageType == PageOneTypeJiJi) {
        ///紧急任务
        _type = 1;
        [PatrolHttpRequest urgenttasklist:@{@"task_status":orderType,@"currentPage":currentPage,@"pageSize":pageSize} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
            
            if (resultCode == SucceedCode) {
                NSDictionary * obj = data;
                NSArray * task_list = [obj objectForKey:@"task_list"];
                NSArray * modelArr = [NSArray yy_modelArrayWithClass:[TaskListModel class] json:task_list];
                if (currentPage.integerValue==1) {
                    [self.task_listArr removeAllObjects];
                }
                [self.task_listArr addObjectsFromArray:modelArr];
                [self.tableView reloadData];
                if (self.task_listArr.count == 0) {
                    weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
                }
            }else{
                if (currentPage.integerValue>=1) {
                    currentPage = [NSString stringWithFormat:@"%ld",(long)currentPage.integerValue-1];
                }
                weakSelf.tableView.tableHeaderView = weakSelf.noDataView;
            }
            [weakSelf.tableView.mj_header endRefreshing];
            [weakSelf.tableView.mj_footer endRefreshing];

        }];
        
    }
}
-(void)requestData:(OrderType)type  cycle:(OrderCycle)cycle{
    
    _orderType = type;
    _orderCycle = cycle;
    currentPage = @"1";
    pageSize=@"20";

    [self pullRefresh];
    
}

-(void)requestData:(OrderType)type{
    _orderType = type;
    currentPage = @"1";
    pageSize=@"20";

    [self pullRefresh];
}
#pragma mark -lazy loading ----
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
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(15,0,self.view.bounds.size.width-30, self.view.bounds.size.height-NavBar_H-30) style:UITableViewStylePlain];
        _tableView.backgroundColor  =[UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight=UITableViewAutomaticDimension;
        [_tableView registerNib:[UINib nibWithNibName:@"PatrolTaskCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PatrolTaskCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"PatrolUrgentTasksCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PatrolUrgentTasksCell"];

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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskListModel * model = [_task_listArr objectAtIndex:indexPath.row];

    if (_type == 1) {
        
        PatrolUrgentTasksCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolUrgentTasksCell"];
        [cell assignmentWithModel:model];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        
        PatrolTaskCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolTaskCell"];
        cell.pageType = self.pageType;
        [cell assignmentWithModel:model withType:_PatrolType];
        cell.tasklock = ^(TaskListModel *model) {
            if (_viewBlock) {
                _viewBlock(model,nil,-1);
            }
            
        };
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TaskListModel * model = [_task_listArr objectAtIndex:indexPath.row];
    
    if (_pageType == PageOneTypeJiJi) {
        if (model.task_status.integerValue == 1) {
            
            PatrolUrgentMapDetailVC * pumVC = [[PatrolUrgentMapDetailVC alloc]init];
            pumVC.detailModel = model;
            [self.navigationController pushViewController:pumVC animated:YES];
            
        }else {
            
            PatrolUrgentOptionDetailVC * pumVC = [[PatrolUrgentOptionDetailVC alloc]init];
            pumVC.controllerModel = model;
            [self.navigationController pushViewController:pumVC animated:YES];
        }
    }
    if (_viewBlock) {
        _viewBlock(model,nil,indexPath.row);
    }
    
}
@end
