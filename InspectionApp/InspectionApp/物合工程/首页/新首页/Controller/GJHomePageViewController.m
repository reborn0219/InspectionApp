//
//  GJHomePageViewController.m
//  物联宝管家
//
//  Created by guokang on 2019/5/24.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "GJHomePageViewController.h"
#import "HomePageCollectionCell.h"
#import "GJmyViewController.h"

@interface GJHomePageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backViewHeight;
@end

@implementation GJHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    self.isCaptain = [UserManager iscaptain];
    if (self.isCaptain) {
        self.nameArr = @[@"在线维修",@"工程巡检管理",@"在线报事",@"警务调度"];
        self.imageArr = @[@"在线维修",@"工程巡检管理",@"在线报事",@"警务调度"];
    }else{
        self.nameArr = @[@"在线维修",@"工程巡检",@"在线报事",@"警务调度"];
        self.imageArr = @[@"在线维修",@"工程巡检",@"在线报事",@"警务调度"];
    }


}
- (void)createUI{

    UIImage *showImage = [[UIImage alloc]init];
    self.navigationController.navigationBar.shadowImage = showImage;
    
    UIButton *leftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [leftButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [leftButton setTitle:@"物合工程" forState:(UIControlStateNormal)];
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
    GJmyViewController *myVC = [[GJmyViewController alloc]init];
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
        
    }else if (indexPath.row == 1){
        
    }else if (indexPath.row == 2){
        
    }else if (indexPath.row == 3){
        
    }else if (indexPath.row == 4){
        
    }else if (indexPath.row == 5){
        
    }
}
#pragma mark ------collection代理方法--------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.nameArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageCollectionCell" forIndexPath:indexPath];
    cell.nameLab.text = self.nameArr[indexPath.row];
    cell.imageV.image =[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.imageArr[indexPath.row]]];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
