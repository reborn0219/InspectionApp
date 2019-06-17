//
//  BottomBarView.m
//  InspectionApp
//
//  Created by yang on 2019/6/13.
//  Copyright © 2019 yang. All rights reserved.
//

#import "BottomBarView.h"
@interface BottomBarView()
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *grabBtn;

@end
@implementation BottomBarView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
    }
    return self;
}

- (void)assginmentWithType:(WorkOrderType)type
{
     self.grabBtn.hidden = YES;
     self.leftBtn.hidden = YES;
     self.rightBtn.hidden = YES;
        switch (type) {
            case  WorkOrderUnhandle:
            {
                if ([UserManager iscaptain].integerValue == 1) {
                self.leftBtn.hidden = NO;
                self.rightBtn.hidden = NO;
                [self.rightBtn setTitle:@"分配工单" forState:(UIControlStateNormal)];
                [self.leftBtn setTitle:@"标记无效" forState:(UIControlStateNormal)];
                }else{
                    self.leftBtn.hidden = YES;
                    self.rightBtn.hidden = YES;
                    self.grabBtn.hidden = NO;
                }
            }
                break;
             case WorkOrderWaitingToHandle:
            {
                self.leftBtn.hidden = NO;
                self.rightBtn.hidden = NO;
                if ([UserManager iscaptain].integerValue == 1) {
                    [self.rightBtn setTitle:@"工单转移" forState:(UIControlStateNormal)];
                    [self.leftBtn setTitle:@"标记无效" forState:(UIControlStateNormal)];
                }else{
                    [self.rightBtn setTitle:@"处理工单" forState:(UIControlStateNormal)];
                    [self.leftBtn setTitle:@"标记无效" forState:(UIControlStateNormal)];
                }
            }
                break;
                case WorkOrderHandling:
            {
                self.leftBtn.hidden = NO;
                self.rightBtn.hidden = NO;
                [self.rightBtn setTitle:@"工单转移" forState:(UIControlStateNormal)];
                [self.leftBtn setTitle:@"标记无效" forState:(UIControlStateNormal)];
            }

            default:
                break;
        }
   
}
- (IBAction)buttonAction:(id)sender {
    UIButton *btn = sender;
    if (self.block) {
//        if (btn.tag) {
//            self.block(nil, WorkOrderAlertConfirm);
//        }else{
//            self.block(nil, WorkOrderAlertClose);
//        }
        if ([btn.titleLabel.text isEqualToString:@"工单转移"]) {
          self.block(nil, WorkOrderAlertTranform);
        }else if ([btn.titleLabel.text isEqualToString:@"分配工单"]){
            
             self.block(nil, WorkOrderAlertDistribute);
        }else if ([btn.titleLabel.text isEqualToString:@"标记无效"]){
            
            self.block(nil, WorkOrderAlertMarkInvalid);
        }else if ([btn.titleLabel.text isEqualToString:@"抢单"]){
            
            self.block(nil, WorkOrderAlertGrab);
        }else if ([btn.titleLabel.text isEqualToString:@"标记完成"]){
            
            self.block(nil, WorkOrderAlertMarkFinished);
        }else if ([btn.titleLabel.text isEqualToString:@"处理工单"]){
            
            self.block(nil, WorkOrderAlertHandle);
        }
    }
   
}

@end
