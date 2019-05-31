//
//  PatrolMemberOrderVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/25.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolMemberOrderVC.h"
#import "PPMemberHeaderView.h"
#import "Masonry.h"
#import "PatrolOrderCell.h"
#import "PPMemberTeamListVC.h"
#import "PPLocationMapVC.h"

@interface PatrolMemberOrderVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    CGFloat _oldY;
    BOOL _isUp;
}
@property (nonatomic,strong)PPMemberHeaderView * phView;
@property (nonatomic,strong)UIView * backView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)PPTaskDetailModel * detailModel;
@end

@implementation PatrolMemberOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatUI];
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"showguide"]){
        PPUserGuideVC * pugVC = [[PPUserGuideVC alloc]init];
        [pugVC showInVC:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:2];
    [self setBarTitle:@"社区列表"];
    [self requestDataWithWork_id:self.work_id];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self hiddenNaBar];
}
#pragma mark =======  巡检任务社区列表 ========
-(void)requestDataWithWork_id:(NSString *)work_id{
    MJWeakSelf
    self.tableView.tableHeaderView = nil;
    [PatrolHttpRequest memberinspecttaskdetaila:@{@"work_id":work_id} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {

            NSDictionary * obj = data;
            _detailModel = [PPTaskDetailModel yy_modelWithJSON:obj];
            weakSelf.phView.type = 1;
            [weakSelf.phView assignmentWithModel:_detailModel withType:1];
            [weakSelf.tableView reloadData];
            
            NSMutableArray * annotationArr = [NSMutableArray array];
            for (PPTaskDetailModelCommunity_list * communityModel in _detailModel.community_list) {
                PatrolAnnotationModel *pointAnnotation = [[PatrolAnnotationModel alloc] init];
                pointAnnotation.coordinate = CLLocationCoordinate2DMake(communityModel.latitude.doubleValue,communityModel.longitude.doubleValue);
                pointAnnotation.annotation_status = _detailModel.task_status;
                pointAnnotation.annotation_name = [NSString stringWithFormat:@"%@\r设备数:（%@）",communityModel.community_name,communityModel.device_number];


//                pointAnnotation.annotation_name = communityModel.community_name;
                [annotationArr addObject:pointAnnotation];
            }
            
            [weakSelf addPatrolAnnotations:annotationArr];
        }
        
    }];
    
}

-(void)creatUI{
    
  
    [self.view addSubview:self.backView];
    [_backView mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NavBar_H);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
    [self.view addSubview:self.phView];
    [_phView mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(NavBar_H);
        make.height.equalTo(@103);
    }];
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.view.mas_bottom).offset(-170);
        make.height.equalTo(@(KScreenHeight-NavBar_H-103));
    }];
}
#pragma mark - lazy loading
-(PPMemberHeaderView *)phView{
    if (!_phView) {
        _phView = [[[NSBundle mainBundle]loadNibNamed:@"PPMemberHeaderView" owner:self options:nil] lastObject];
        
    }
    return _phView;
}
-(UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = self.view.backgroundColor;
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
        [_tableView registerNib:[UINib nibWithNibName:@"PatrolOrderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"PatrolOrderCell"];
        
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
    PatrolOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PatrolOrderCell"];
    cell.isPositionHidden = YES;
    [cell assignmentWithModel:cellModel];
    MJWeakSelf
    cell.block = ^(id  _Nullable data, UIView * _Nullable view, NSIndexPath * _Nullable index) {
        PPTaskDetailModelCommunity_list * communityModel = data;
        
        PatrolAnnotationModel *pointAnnotation = [[PatrolAnnotationModel alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(communityModel.latitude.doubleValue,communityModel.longitude.doubleValue);
        pointAnnotation.annotation_status = _detailModel.task_status;
        pointAnnotation.annotation_name = communityModel.community_name;
//        pointAnnotation.annotation_name = [NSString stringWithFormat:@"%@\r设备数：（%@）",communityModel.community_name,communityModel.device_number];

        PPLocationMapVC * mapVC = [[PPLocationMapVC alloc]init];
        mapVC.annotionModel = pointAnnotation;
        [weakSelf.navigationController pushViewController:mapVC animated:YES];
       
        //        PatrolTaskMapVC * mapVC = [[PatrolTaskMapVC alloc]init];
        //        NSMutableArray * annotations = [NSMutableArray array];
        //        [mapVC addPatrolAnnotations:annotations];
        //        [weakSelf.navigationController pushViewController:mapVC animated:YES];
    };
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
 
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PPMemberTeamListVC * pmonVC = [[PPMemberTeamListVC alloc]init];
    PPTaskDetailModelCommunity_list *indexModel = [_detailModel.community_list  objectAtIndex:indexPath.row];
    pmonVC.controllerModel = indexModel;
    pmonVC.community_id = indexModel.community_id;
    pmonVC.work_id = self.work_id;
    [self.navigationController pushViewController:pmonVC animated:YES];
    
}

-(void)scrollAnimationUp{
    
    [UIView animateWithDuration:0.5 animations:^{
        _backView.alpha = 1;
        _tableView.transform = CGAffineTransformMakeTranslation(0,-(KScreenHeight-NavBar_H-103)+170);
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
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

@end
