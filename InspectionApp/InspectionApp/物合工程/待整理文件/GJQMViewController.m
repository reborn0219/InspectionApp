//
//  GJQMViewController.m
//  物联宝管家
//
//  Created by ovov on 2017/3/24.
//  Copyright © 2017年 付智鹏. All rights reserved.
//

#import "GJQMViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PrefixHeader.pch"
#import "GJQueRenViewController.h"
#import "MLSecurityConfirmSignatureVC.h"
@interface GJQMViewController (){
    CATransform3D transForm;
}

@end

@implementation GJQMViewController
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [UIApplication sharedApplication].statusBarHidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=viewbackcolor;
    transForm=CATransform3DMakeRotation(M_PI/2, 0, 0, 1.0);
    self.view.layer.transform=transForm;
    
    UIView *naV=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 44)];
    naV.backgroundColor=NAVCOlOUR;
    [self.view addSubview:naV];

    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame=CGRectMake(5, 6, 32, 32);
    [leftBtn setImage:[UIImage imageNamed:@"back1"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(ccc) forControlEvents:UIControlEventTouchUpInside];
    [naV addSubview:leftBtn];
    
    UILabel *leftLab=[[UILabel alloc]initWithFrame:CGRectMake(42, 6, 150, 32)];
    leftLab.text=@"签名 (请使用正楷)";
    leftLab.textAlignment=NSTextAlignmentLeft;
    leftLab.textColor=[UIColor whiteColor];
    leftLab.font=[UIFont systemFontOfSize:17];
    [naV addSubview:leftLab];
    
    UILabel *middleLab=[[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-100, 6, 200, 32)];
    middleLab.textColor=[UIColor whiteColor];
    middleLab.text=@"请将手机递给业主";
    middleLab.textAlignment=NSTextAlignmentCenter;
    middleLab.font=[UIFont systemFontOfSize:16];
    [naV addSubview:middleLab];
    
    
    UIView *diView=[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT-40, WIDTH, 40)];
    diView.backgroundColor=NAVCOlOUR;
    [self.view addSubview:diView];
    
    
    UILabel *diLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 6, 360, 32)];
    diLab.textColor=[UIColor whiteColor];
    diLab.textAlignment=NSTextAlignmentLeft;
    diLab.font=[UIFont systemFontOfSize:14];
    diLab.text=@"本人与维修师傅已达成协议，同意维修并承担相应费用。";
    if (_isAnbao) {
        diLab.text=@"本人与安保人员已达成协议，同意安保并承担相应费用。";
    }
    [diView addSubview:diLab];
    
    UIButton *TiBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    TiBtn.frame=CGRectMake(WIDTH-20-70, 3, 70, 34);
    TiBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [TiBtn addTarget:self action:@selector(tiJIao) forControlEvents:UIControlEventTouchUpInside];
    [TiBtn setTitle:@"提  交" forState:UIControlStateNormal];
    [TiBtn setBackgroundColor:RGB(224, 181, 57)];
    TiBtn.layer.cornerRadius=5;
    TiBtn.layer.masksToBounds=YES;
    [diView addSubview:TiBtn];
    
    
    UIButton *clearBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame=CGRectMake(WIDTH-20-70-15-70, 3, 70, 34);
    clearBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [clearBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [clearBtn addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchUpInside];
    [clearBtn setTitle:@"擦除重签" forState:UIControlStateNormal];
    [clearBtn setBackgroundColor:viewbackcolor];
    clearBtn.layer.cornerRadius=5;
    clearBtn.layer.masksToBounds=YES;
    [diView addSubview:clearBtn];
    
    self.GJsignatureView = [[GJsignatureView alloc] initWithFrame:CGRectMake(10,44+10, WIDTH-20, HEIGHT-54-40-10)];
    self.GJsignatureView.backgroundColor = [UIColor whiteColor];
    self.GJsignatureView.delegate =self;
    
    [self.view addSubview:self.GJsignatureView];

}
-(void)tiJIao
{
    [self.GJsignatureView sure];


}
#pragma mark - 得到图片
-(void)getSignatureImg:(UIImage*)image
{
    NSLog(@"%@",image);
    if (image.size.width>0) {
        
        if (_isAnbao) {
            MLSecurityConfirmSignatureVC *qr=[[MLSecurityConfirmSignatureVC alloc]init];
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isAnbao_autograph"] isEqualToString:@"F"]) {
                qr.repair_id=_repair_id;
                
            }else{
                
                qr.WGDic=_WGDic;
            }
            qr.NameImg=image;
            
            [self.navigationController pushViewController:qr animated:YES];
        }else{
            GJQueRenViewController *qr=[[GJQueRenViewController alloc]init];
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"is_autograph"] isEqualToString:@"F"]) {
                qr.repair_id=_repair_id;
            }else{
                qr.WGDic=_WGDic;
            }
            qr.NameImg=image;
            
            [self.navigationController pushViewController:qr animated:YES];
        }
    }else{
        [GJSVProgressHUD showErrorWithStatus:@"请签名"];
    }
//    UIImageView *ima=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
//    [ima setImage:image];
//    [self.view addSubview:ima];
}

- (void)clear:(UIButton *)sender
{
    NSLog(@"重签");
    [self.GJsignatureView clear];
    for(UIView *view in saveView.subviews)
    {
        [view removeFromSuperview];
    }
}


-(void)ccc
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
