//
//  PPBaseViewController.m
//  物联宝管家
//
//  Created by yang on 2019/3/18.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPBaseViewController.h"
#import "Masonry.h"
#import "ColorDefinition.h"
#import "PPViewTool.h"
#import "QrCodeScanningVC.h"
#import "PPMemberDetailCommitVC.h"
#import "PatrolOrderDetailVC.h"

@interface PPBaseViewController ()<BackValueDelegate>
@end

@implementation PPBaseViewController

#pragma mark - Life Cicle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.topView];
    
    [self.view setBackgroundColor:BASE_CONTROLER_BACK_COLOR];
    [self.view addSubview:self.navBar];
    [_navBar mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
        make.height.equalTo(@(NavBar_H));
    }];
    [_navBar setHidden:YES];
    MJWeakSelf
    _navBar.block = ^(NSInteger index) {
        if (index ==1) {
            [weakSelf popController];
        }else if (index ==10) {
            [weakSelf segementDidSelected:index];
        }else if (index ==11) {
            [weakSelf segementDidSelected:index];
        }else{
            [weakSelf rightBarAction:index];
        }
    };
    [self.navBar bringSubviewToFront:self.view];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    NSLog(@"控制器---：%@",[self class]);
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self.navigationController.navigationBar setHidden:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - lazy loading
- (PPNoDataView *)noDataView
{
    if (!_noDataView) {
        _noDataView = [[[NSBundle mainBundle]loadNibNamed:@"PPNoDataView" owner:self options:nil]lastObject];
        [_noDataView setFrame:CGRectMake(0, 0, KScreenWigth,SCREEN_HEIGHT/2)];
    }
    return _noDataView;
}
-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Width/375.0*146.0)];
        _topView.clipsToBounds = YES;
        UIImageView * imgV = [[UIImageView alloc]initWithFrame:_topView.bounds];
        [imgV setImage:[UIImage imageNamed:@"Rectangle"]];
        
        [_topView addSubview:imgV];
        [_topView setHidden:YES];
    }
    return _topView;
}

-(PPNavigationBarView *)navBar{
    
    
    if (!_navBar) {
        _navBar = [[[NSBundle mainBundle]loadNibNamed:@"PPNavigationBarView" owner:self options:nil] lastObject];
    }
    return _navBar;
}

-(void)hiddenNaBar{
    [_navBar setHidden:YES];
}

-(void)showNaBar:(NSInteger)type{
    if (type == 1 || type==0) {
        [_topView setHidden:NO];
    }else{
        [_topView setHidden:YES];

    }
    [_navBar setItemTitle:@"" withType:type];
    [_navBar setHidden:NO];

}
-(void)setBarTitle:(NSString *)title{
    [_navBar setItemTitle:title];
}
-(void)rightBarAction:(NSInteger)type{
    
    QrCodeScanningVC * QrCodeVc=[[QrCodeScanningVC alloc]init];
    QrCodeVc.delegate = self;
    [self.navigationController pushViewController:QrCodeVc animated:YES];
}
-(void)popController{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)popController:(NSInteger)index
{
    NSArray *controllers = self.navigationController.viewControllers;
    [self.navigationController popToViewController:[controllers objectAtIndex:index] animated:YES];
}
-(void)popControllerReverse:(NSInteger)index{
    NSArray *controllers = self.navigationController.viewControllers;
    [self.navigationController popToViewController:[controllers objectAtIndex:controllers.count-index] animated:YES];
}
-(void)segementDidSelected:(NSInteger)type{
    
}
-(void)backValue:(NSString *)value{
//    NSLog(@"---------%@",value);
//    NSDictionary * dic = [PPViewTool dictionaryWithJsonString:value];
//    if (dic==nil) {
//        [GJMBProgressHUD showError:@"二维码有误"];
//        return;
//    }
//    NSLog(@"---------%@",dic);
//    if (dic.allKeys.count == 0 || dic[@"device_id"] == nil) {
//        [GJMBProgressHUD showError:@"二维码有误"];
//    }else{
//        MJWeakSelf
//        NSString *device_id = dic[@"device_id"];
//        [PatrolHttpRequest checkEquipment:@{@"device_id":dic[@"device_id"]} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
//            if (resultCode == SucceedCode) {
//                NSLog(@"---------%@",data);
//                NSDictionary * dataDic = data;
//                NSString * exist = [dataDic objectForKey:@"exist"];
//                 NSString * work_sheet_id = [dataDic objectForKey:@"work_sheet_id"];
//                if (exist.integerValue == 0) {
//                    [GJMBProgressHUD showError:@"设备工单不存在"];
//                    return ;
//                }else{
//                   
//                    if ([UserManager iscaptain].integerValue == 1) {
//                        NSString * work_id = [dataDic objectForKey:@"work_id"];
//                        
//                        PatrolOrderDetailVC *derailVC = [[PatrolOrderDetailVC alloc]init];
//                        derailVC.work_id=work_id;
//                        derailVC.device_id = device_id;
//                        derailVC.work_sheet_id =work_sheet_id;
//                        [weakSelf.navigationController pushViewController:derailVC animated:YES];
//                        
//                    }else if ([UserManager iscaptain].integerValue == 0) {
//
//                        PPMemberDetailCommitVC *derailVC = [[PPMemberDetailCommitVC alloc]init];
//                        derailVC.work_sheet_id = work_sheet_id;
//                        [weakSelf.navigationController pushViewController:derailVC animated:YES];
//                    }
//                }
//        
//                
//            }
//        }];
//    }

    
//    {"device_id":"133","device_number":"SB20190425000133"}
 
    
}
@end
