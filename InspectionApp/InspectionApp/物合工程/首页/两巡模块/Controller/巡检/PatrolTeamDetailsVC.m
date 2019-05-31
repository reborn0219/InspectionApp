//
//  PatrolTeamDetailsVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/20.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolTeamDetailsVC.h"
#import "PatrolMembersDetailVC.h"
#import "PPTeamHeaderView.h"

@interface PatrolTeamDetailsVC ()
@property(nonatomic,strong)PPTeamHeaderView * headerView;
@end

@implementation PatrolTeamDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headerView];
    
    MJWeakSelf
    _headerView.block = ^(id  _Nullable data, UIView * _Nullable view, NSIndexPath * _Nullable index) {
        
        PatrolMembersDetailVC * pmdVC = [[PatrolMembersDetailVC alloc]init];
        [pmdVC requestData:data];
        [weakSelf.navigationController pushViewController:pmdVC animated:YES];
    };
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:2];
    [self setBarTitle:@"小组详情"];
    [_headerView requestData:@{@"team_id":_teamID?:@"",@"car_id":_carID?:@"0"}];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self hiddenNaBar];
}
-(PPTeamHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"PPTeamHeaderView" owner:self options:nil] lastObject];
        [_headerView setFrame:CGRectMake(0,NavBar_H,KScreenWigth, KScreenHeight-NavBar_H)];
    }
    return _headerView;
}
@end

