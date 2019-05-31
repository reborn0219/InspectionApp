//
//  PatrolMembersDetailVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/20.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolMembersDetailVC.h"
#import "PPMembersView.h"
#import "Masonry.h"
#import "RongWebVC.h"
@interface PatrolMembersDetailVC ()
@property(nonatomic,strong)PPMembersView * headerView;
@property(nonatomic,strong)PPGroupInfoModelMember_list *memberModel;

@end

@implementation PatrolMembersDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headerView];
    
    [self.navBar removeFromSuperview];
    [self.view addSubview:self.navBar];
    [self.navBar mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(0);
        make.height.equalTo(@(NavBar_H));
    }];

   
    MJWeakSelf
    _headerView.block = ^(NSInteger index) {
//        RongWebVC * vc = [[RongWebVC alloc]init];
//        [weakSelf.navigationController pushViewController:vc animated:YES];
        if (index == 3) {
            [weakSelf PhoneNumber];
        }else{
            [PatrolHttpRequest isBusy:@{@"id":weakSelf.memberModel.member_id} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
                
                if (resultCode==SucceedCode) {
                    NSString *isBusy = data;
                    if (isBusy.intValue==0) {
                        
                        int result = [[UserManager menber_id] compare:weakSelf.memberModel.member_id options:NSCaseInsensitiveSearch | NSNumericSearch];
                        NSString *roomNo;
                        if (result) {
                            roomNo = [NSString stringWithFormat:@"%@-%@",[UserManager menber_id],weakSelf.memberModel.member_id];
                        }else{
                            roomNo = [NSString stringWithFormat:@"%@-%@",weakSelf.memberModel.member_id,[UserManager menber_id]];
                        }
                        [PatrolHttpRequest applyCall:@{@"room":roomNo} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
                            if (resultCode==SucceedCode) {
                                
                                
                                VideoChatViewController * chatVC = [[VideoChatViewController alloc]init];
                                chatVC.roomNo = roomNo;
                                [weakSelf presentViewController:chatVC animated:YES completion:nil];
                                
                            }
                        }];
                    }else{
                        NSLog(@"对方正在通话中...");
                    }
                    
                    
                }else{
                    
                }
                
                
            }];
        }
   
//        if(index==1){
////            [[GJDemoCallManager sharedManager] makeCallWithUsername:weakSelf.memberModel.member_id type:EMCallTypeVoice];
//
//            VideoChatViewController * chatVC = [[VideoChatViewController alloc]init];
//            [weakSelf presentViewController:chatVC animated:YES completion:nil];
//        }else if(index ==2){
////            [[GJDemoCallManager sharedManager] makeCallWithUsername:weakSelf.memberModel.member_id type:EMCallTypeVideo];
//            VideoChatViewController * chatVC = [[VideoChatViewController alloc]init];
//            [weakSelf presentViewController:chatVC animated:YES completion:nil];
//        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:4];
    [self setBarTitle:@"队员详情"];
    [_headerView.headerImgV sd_setImageWithURL:[NSURL URLWithString:_memberModel.member_avatar] placeholderImage:[UIImage imageNamed:@"menber_img"]];

    [_headerView.nameLb setText:_memberModel.member_name?:@""];
    _headerView.phoneLb.text = _memberModel.member_phone?:@"";
    _headerView.departmentLb.text = _memberModel.department_name?:@"";
    _headerView.cardLb.text = _memberModel.id_card?:@"";
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self hiddenNaBar];
   
    
}
-(void)requestData:(PPGroupInfoModelMember_list *)memberModel{
    
    _memberModel = memberModel;
   
    
}

-(PPMembersView *)headerView{
    if (!_headerView) {
        _headerView = [[[NSBundle mainBundle]loadNibNamed:@"PPMembersView" owner:self options:nil] lastObject];
        [_headerView setFrame:CGRectMake(0,0,KScreenWigth, KScreenHeight)];
    }
    return _headerView;
}
//拨打电话功能
-(void)PhoneNumber
{
    //朱滴20180915版权信息改为美戴瑜洋
//    if ([dict[@"tel"] isEqual:@"400-8756-399"]) {
//        [dict setObject:@"400-6836-524" forKey:@"tel"];
//    }
//    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:_memberModel.member_phone delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫",nil];
//    [alertview show];
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"tel://",_memberModel.member_phone]]];
}
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0) {
//        [alertView removeFromSuperview];
//    }else
//    {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"tel://",_memberModel.member_phone]]];
//    }
//}

@end
