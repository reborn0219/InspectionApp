//
//  SecurityWorkOrderVC.m
//  InspectionApp
//
//  Created by yang on 2019/6/4.
//  Copyright © 2019 yang. All rights reserved.
//

#import "SecurityWorkOrderVC.h"
#import "PSWorkOrderViewController.h"
#import "PSWorkOrderListVC.h"

@interface SecurityWorkOrderVC ()
{
    PSWorkOrderListVC *workOrderListVC;
    PSWorkOrderViewController * listenVC;
}
@end

@implementation SecurityWorkOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showNaBar:8];
    
    CGRect rect = CGRectMake(0,NavBar_H,SCREEN_WIDTH, SCREEN_HEIGHT-NavBar_H);

    workOrderListVC  = [[PSWorkOrderListVC alloc]init];
    listenVC = [[PSWorkOrderViewController alloc]init];
    [workOrderListVC view].frame = rect;
    [listenVC view].frame = rect;
    [self.navigationController setNavigationBarHidden:YES];

    [self addChildViewController:workOrderListVC];
    [self addChildViewController:listenVC];
    [self.view addSubview:[listenVC view]];

    // Do any additional setup after loading the view.
}
-(void)segementDidSelected:(NSInteger)type
{
   
    
    if (type == 10) {
      
        [self transitionFromViewController:workOrderListVC toViewController:listenVC duration:.3 options:UIViewAnimationOptionTransitionCrossDissolve  animations:nil completion:^(BOOL finished) {
            if (finished) {
//                [workOrderListVC removeFromParentViewController];
//                [self.view addSubview:[listenVC view]];
            }else{
                
            }
        }];
        
    }else{
        [self transitionFromViewController:listenVC toViewController:workOrderListVC duration:.3 options:UIViewAnimationOptionTransitionCrossDissolve  animations:nil completion:^(BOOL finished) {
            if (finished) {
//                [listenVC removeFromParentViewController];
//                [self.view addSubview:[workOrderListVC view]];
            }else{
                
            }
        }];
        
      

    }
}



@end
