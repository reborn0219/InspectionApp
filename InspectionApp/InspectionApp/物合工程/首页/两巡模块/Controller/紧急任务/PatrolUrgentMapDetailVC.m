//
//  PatrolUrgentMapDetailVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/26.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolUrgentMapDetailVC.h"
#import "PPUrgentBottomView.h"
#import "PatrolUrgentOptionDetailVC.h"


@interface PatrolUrgentMapDetailVC ()
@property(nonatomic,strong)PPUrgentBottomView * bottomView;
@property(nonatomic,strong)UIView * optionView;
@property(nonatomic,strong)UIButton * optionBtn;
@property(nonatomic,strong)UIButton * loctionBtn;

//@property(nonatomic,strong)PatrolUrgentBottomView * bottomView;


@end

@implementation PatrolUrgentMapDetailVC


#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:3];
    [self.bottomView assignmentWithModel:self.detailModel];
    
    PatrolAnnotationModel *pointAnnotation = [[PatrolAnnotationModel alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(_detailModel.latitude.doubleValue,_detailModel.longitude.doubleValue);
    pointAnnotation.annotation_status = @"2";
    pointAnnotation.annotation_name = _detailModel.task_name;
//    [annotationArr addObject:pointAnnotation];
    self.mapView.zoomLevel = 16;
    self.mapView.showsUserLocation = YES;

    [self addPatrolAnnotations:@[pointAnnotation]];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self.navigationController.navigationBar setHidden:NO];
    [self hiddenNaBar];
}

#pragma mark - CommonMethod
-(void)locationAction{
    //定位
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
}
-(void)optionAction{
    //去执行
    MJWeakSelf
    [PatrolHttpRequest execute:@{@"task_no":_detailModel.task_no,@"urgent_status":_detailModel.task_status} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        
        if (resultCode == SucceedCode) {
            
            PatrolUrgentOptionDetailVC * puodVC = [[PatrolUrgentOptionDetailVC alloc]init];
            puodVC.controllerModel = _detailModel;
            [weakSelf.navigationController pushViewController:puodVC animated:YES];
        }
    }];
 
    
}



#pragma mark - SetUpUI
- (void)setUpUI{
    MJWeakSelf
    [self.view addSubview:self.bottomView];
    _bottomView.block = ^(NSInteger index) {
        if (index ==0) {
            [weakSelf moveUp];
        }else{
            [weakSelf moveDown];
        }
    };
    [self.view addSubview:self.loctionBtn];
    [self.view addSubview:self.optionView];
    [_optionView addSubview:self.optionBtn];
    
//    [self.mapView setFrame:CGRectMake(0,0, KScreenWigth,KScreenHeight -100)];

}
#pragma mark - LazyLoad
-(UIButton *)loctionBtn{
    if (!_loctionBtn) {
        _loctionBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-63,SCREEN_HEIGHT-220,48,48)];
        [_loctionBtn setImage:[UIImage imageNamed:@"location_icon"] forState:UIControlStateNormal];
        [_loctionBtn addTarget:self action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loctionBtn;
}
-(PPUrgentBottomView *)bottomView{
    if (!_bottomView) {
        
        _bottomView = [[[NSBundle mainBundle]loadNibNamed:@"PPUrgentBottomView" owner:self options:nil] lastObject];
        [_bottomView setFrame:CGRectMake(0,SCREEN_HEIGHT - 160, SCREEN_WIDTH,160)];
    }
    return _bottomView;
}
-(UIView *)optionView{
    if (!_optionView) {
        
        _optionView = [[UIView alloc]init];
        [_optionView setFrame:CGRectMake(0,SCREEN_HEIGHT - 70,SCREEN_WIDTH,70)];
        [_optionView setBackgroundColor:[UIColor whiteColor]];

    }
    return _optionView;
}
-(UIButton *)optionBtn{
    if (!_optionBtn) {
        _optionBtn = [[UIButton alloc]initWithFrame:CGRectMake(15,15,SCREEN_WIDTH-60,40)];
        [_optionBtn addTarget:self action:@selector(optionAction) forControlEvents:UIControlEventTouchUpInside];
        [_optionBtn.layer insertSublayer:[PPViewTool setGradualChangingColor:_optionBtn withFrame:CGRectMake(0, 0, KScreenWigth-30,40) withCornerRadius:20] atIndex:0];
        [_optionBtn setTitle:@"开始执行任务" forState:UIControlStateNormal];
        
    }
    return _optionBtn;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
/*
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
 }
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
 }*/

-(void)moveUp{
    
    [UIView animateWithDuration:0.3 animations:^{
//        _bottomView.topView.transform = CGAffineTransformMakeTranslation(0,-120);
        [_bottomView setFrame:CGRectMake(0,KScreenHeight - 280, KScreenWigth,280)];
        [_loctionBtn setFrame:CGRectMake(SCREEN_WIDTH-63,SCREEN_HEIGHT-340,48,48)];

    }];
}
-(void)moveDown{
    [UIView animateWithDuration:0.3 animations:^{
//        _bottomView.topView.transform = CGAffineTransformMakeTranslation(0,0);
        [_bottomView setFrame:CGRectMake(0,KScreenHeight - 160, KScreenWigth,160)];
        [_loctionBtn setFrame:CGRectMake(SCREEN_WIDTH-63,SCREEN_HEIGHT-220,48,48)];

    }];
}

@end
