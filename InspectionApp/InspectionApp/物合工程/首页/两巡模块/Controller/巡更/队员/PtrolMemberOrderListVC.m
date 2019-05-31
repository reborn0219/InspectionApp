//
//  PtrolMemberOrderListVC.M
//  物联宝管家
//
//  Created by yang on 2019/3/26.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PtrolMemberOrderListVC.h"
#import "PtrolMemberHeaderView.h"
#import "PatrolDeviceCell.h"
#import "PtroMemberDetailCommitVC.h"
#import "PPComunityOrderCell.h"

@interface PtrolMemberOrderListVC ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    CGFloat _oldY;
    BOOL _isUp;
}
@property (nonatomic,strong)PtrolMemberHeaderView * phView;
@property (nonatomic,strong)UIView * backView;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) PPTaskDetailModel *detailModel;
@property (nonatomic,copy) NSString *work_sheet_status;

@end

@implementation PtrolMemberOrderListVC


#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    _work_sheet_status = @"0";
    [self creatUI];
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"showguide"]){
        PPUserGuideVC * pugVC = [[PPUserGuideVC alloc]init];
        [pugVC showInVC:self];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:2];
    [self setBarTitle:@"巡查社区"];
    [self requestData];
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
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.view.mas_bottom).offset(-150);
        make.height.equalTo(@(KScreenHeight-NavBar_H-150));
    }];
    
    [self.view addSubview:self.phView];
    _phView.block = ^(id  _Nullable data, UIView * _Nullable view, NSInteger index) {
     
        if (index == 5) {
            //未巡查
            weakSelf.work_sheet_status = @"6";
        }else if(index == 6){
            //已巡查
          weakSelf.work_sheet_status = @"5";
        }else{
            //全部
            weakSelf.work_sheet_status = @"0";
        }
//        weakSelf.work_sheet_status = [NSString stringWithFormat:@"%d",(int)index];
        [weakSelf requestData];
    };
    
    [_phView mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NavBar_H);
        make.height.equalTo(@150);
    }];
    
}
#pragma mark =======  巡检任务社区列表 ========
-(void)requestData{
    MJWeakSelf
    [PatrolHttpRequest patrolworklist:@{@"work_id":_work_id,@"work_sheet_status":_work_sheet_status,@"currentPage":@"1",@"pageSize":@"20"} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            
            NSDictionary * obj = data;
            _detailModel = [PPTaskDetailModel yy_modelWithJSON:obj];
            [weakSelf.phView assignmentWithModel:_detailModel];
            
            [weakSelf.tableView reloadData];
            
            NSMutableArray * annotationArr = [NSMutableArray array];
            for (PPTaskDetailModelCommunity_list * communityModel in _detailModel.community_list) {
                PatrolAnnotationModel *pointAnnotation = [[PatrolAnnotationModel alloc] init];
                pointAnnotation.coordinate = CLLocationCoordinate2DMake(communityModel.latitude.doubleValue,communityModel.longitude.doubleValue);
                pointAnnotation.annotation_status = communityModel.work_sheet_status;
                pointAnnotation.annotation_name = communityModel.community_name;
                [annotationArr addObject:pointAnnotation];
            }
            
            [weakSelf addPatrolAnnotations:annotationArr];
        }
        
    }];
    
}

#pragma mark - lazy loading
-(PtrolMemberHeaderView *)phView{
    if (!_phView) {
        _phView = [[[NSBundle mainBundle]loadNibNamed:@"PtrolMemberHeaderView" owner:self options:nil] lastObject];
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
        [_tableView registerNib:[UINib nibWithNibName:@"PPComunityOrderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PPComunityOrderCell"];
        
    }
    return _tableView;
}
#pragma mark - TableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _detailModel.community_list.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PPTaskDetailModelCommunity_list * cellModel = [_detailModel.community_list objectAtIndex:indexPath.row];
    PPComunityOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PPComunityOrderCell"];
    [cell assignmentWithModel:cellModel];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PtroMemberDetailCommitVC * pdcVC = [[PtroMemberDetailCommitVC alloc]init];
    PPTaskDetailModelCommunity_list *communityModel = [_detailModel.community_list objectAtIndex:indexPath.row];
    pdcVC.work_sheet_id = communityModel.work_sheet_id;
    pdcVC.work_sheet_status = communityModel.work_sheet_status;
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
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _oldY = self.tableView.contentOffset.y;
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



@end
