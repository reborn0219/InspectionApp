//
//  PSHomePageViewController.m
//  物联宝管家
//
//  Created by guokang on 2019/5/25.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PSHomePageViewController.h"
#import "HomePageCollectionCell.h"
//#import "GJMyViewController.h"
#import "PSMyViewController.h"
#import "GJAllWageViewController.h"
#import "PatrolUrgentTasksVC.h"
#import "PatrolMatterSubmitVC.h"
#import "PatrolTaskListVC.h"
#import "PtrolMemberTaskListVC.h"
#import "PatrolPatrolTaskListVC.h"
#import "PatrolMemberTaskVC.h"
#import "PSWorkOrderViewController.h"
#import "HomeRequest.h"
#import "SecurityWorkOrderVC.h"
#import "HomeModel.h"
@interface PSHomePageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UILabel *identityLab;
@property (weak, nonatomic) IBOutlet UILabel *companyLab;
@property (weak, nonatomic) IBOutlet UILabel *checkedNoLab;
@property (weak, nonatomic) IBOutlet UILabel *uncheckNoLab;
@property (weak, nonatomic) IBOutlet UIImageView *backImageV;
@property (weak, nonatomic) IBOutlet UILabel *unCheckLab;
@property (weak, nonatomic) IBOutlet UILabel *checkedLab;
@property (nonatomic, strong)UICollectionView  *collectionView;
@property (nonatomic, strong)NSArray  *nameArr;
@property (nonatomic, strong)NSArray  *imageArr;
@property (nonatomic,strong) HomeModel *controllerModel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;

@end

@implementation PSHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    if ([UserManager iscaptain].integerValue == 1) {
        _identityLab.text = @"巡逻队长";
        self.nameArr = @[@"安保工单",@"安保巡逻管理",@"紧急任务",@"警务调度",@"在线报事"];
        self.imageArr = @[@"安保工单",@"安保巡逻管理",@"紧急任务",@"警务调度",@"在线报事"];
    }else{
        _identityLab.text = @"巡逻队员";
        self.nameArr = @[@"安保工单",@"安保巡逻",@"紧急任务",@"警务调度",@"在线报事"];
        self.imageArr = @[@"安保工单",@"安保巡逻",@"紧急任务",@"警务调度",@"在线报事"];
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    [self requestData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
-(void)requestData{
    MJWeakSelf
    [HomeRequest companyinfo:^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        if (resultCode == SucceedCode) {
            NSLog(@"%@",data);
            NSDictionary * dic = data;
            weakSelf.controllerModel = [HomeModel yy_modelWithJSON:dic];
            [weakSelf assignmentWithModel];
        }
    }];
    
}
-(void)assignmentWithModel
{
    _checkedNoLab.text = _controllerModel.finished_num;
    _uncheckNoLab.text = _controllerModel.unfinished_num;
    _companyLab.text = _controllerModel.company_name;
    
}
- (void)createUI{
    UIImage *showImage = [[UIImage alloc]init];
    self.navigationController.navigationBar.shadowImage = showImage;
    UIButton *leftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [leftButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [leftButton setTitle:@"物合安保" forState:(UIControlStateNormal)];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    UIButton *rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [rightButton setImage:[UIImage imageNamed:@"个人中心"] forState:(UIControlStateNormal)];
    UIBarButtonItem *rightBarBut = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    [rightButton addTarget:self action:@selector(personalCentreAction) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationItem.rightBarButtonItem = rightBarBut;
    self.backViewHeight.constant = NavBar_H;
    [self.backImageV.layer insertSublayer:[PPViewTool setGradualChangingColor:self.backImageV withFrame:CGRectMake(0, 0, KScreenWigth - 24, 155) withCornerRadius:8.0f] above:0];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NavBar_H+self.backImageV.frame.size.height, KScreenWigth,KScreenHeight - NavBar_H-self.backImageV.frame.size.height ) collectionViewLayout: flowLayout];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomePageCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:@"HomePageCollectionCell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
}
- (void)personalCentreAction
{
//    GJmyViewController *myVC = [[GJmyViewController alloc]init];
//    [self.navigationController pushViewController:myVC animated:YES];
    PSMyViewController *myVC = [[PSMyViewController alloc]init];
    [self.navigationController pushViewController:myVC animated:YES];
}
#pragma mark - UICollectionViewDataSource
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 21;
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((KScreenWigth - 21*2- 12*3)/4.0,(KScreenWigth - 21*2- 12*3)/4.0);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(22, 21, 0, 21);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        //安保工单
        SecurityWorkOrderVC *workOrderVC = [[SecurityWorkOrderVC alloc]init];
//        GJAllWageViewController *messageVC = [[GJAllWageViewController alloc] init];
//        messageVC.isAnBao = YES;
           workOrderVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:workOrderVC animated:YES];
    }else if (indexPath.row == 1){
        //安保巡逻/安保巡逻管理
        if ([UserManager iscaptain].integerValue == 1) {

            PatrolTaskListVC * pptlVC = [[PatrolTaskListVC alloc]init];
               pptlVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:pptlVC animated:YES];

        }else if ([UserManager iscaptain].integerValue == 0){
            PtrolMemberTaskListVC * pmolVC = [[PtrolMemberTaskListVC alloc]init];
                pmolVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:pmolVC animated:YES];
        }
//        if ([UserManager iscaptain].integerValue == 1) {
//            
//            PatrolPatrolTaskListVC * pptlVC = [[PatrolPatrolTaskListVC alloc]init];
//            [self.navigationController pushViewController:pptlVC animated:YES];
//            
//        }else if ([UserManager iscaptain].integerValue == 0){
//            PatrolMemberTaskVC * pmtVC = [[PatrolMemberTaskVC alloc]init];
//            [self.navigationController pushViewController:pmtVC animated:YES];
//        }
    }else if (indexPath.row == 2){
        //紧急任务
        PatrolUrgentTasksVC * putVC = [[PatrolUrgentTasksVC alloc]init];
           putVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:putVC animated:YES];
    }else if (indexPath.row == 3){
        //警务调度
        
    }else if (indexPath.row == 4){
        //在线报事
        PatrolMatterSubmitVC * pmsVC = [[PatrolMatterSubmitVC alloc]init];
            pmsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:pmsVC animated:YES];
    }
 
}
    
#pragma mark ------collection代理方法--------
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.nameArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageCollectionCell" forIndexPath:indexPath];
    cell.nameLab.text = self.nameArr[indexPath.row];
    cell.imageV.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imageArr[indexPath.row]]];
    return cell;
}


@end
