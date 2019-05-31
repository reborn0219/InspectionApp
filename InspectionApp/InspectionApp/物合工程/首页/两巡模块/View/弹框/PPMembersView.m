//
//  PPMembersView.m
//  物联宝管家
//
//  Created by yang on 2019/3/20.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPMembersView.h"
#import "PPViewTool.h"

@interface PPMembersView()

@end

@implementation PPMembersView

-(void)awakeFromNib{
    [super awakeFromNib];
    _stateView.layer.cornerRadius = 4;
    _stateView.layer.borderWidth =0.5;
    _stateView.layer.borderColor = HexRGB(0xFFFFFF).CGColor;
    [_headerView.layer insertSublayer:[PPViewTool setGradualChangingColor:_headerView] atIndex:0];
    _headerImgV.clipsToBounds = YES;
    _headerImgV.layer.cornerRadius = 30;
    
    _rightView.layer.cornerRadius = 28;
    _rightView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _rightView.layer.shadowOffset = CGSizeMake(0,0);
    _rightView.layer.shadowOpacity = 0.2;
    _rightView.layer.shadowRadius = 2;
    
    _leftView.layer.cornerRadius = 28;
    _leftView.layer.shadowColor = SHADOW_COLOR.CGColor;
    _leftView.layer.shadowOffset = CGSizeMake(0,0);
    _leftView.layer.shadowOpacity = 0.2;
    _leftView.layer.shadowRadius = 2;

}
- (IBAction)voiceCallAction:(id)sender {
    NSLog(@"%@",[UserManager nick_name]);
//    [[GJDemoCallManager sharedManager] makeCallWithUsername:@"lius" type:EMCallTypeVoice];
    if (self.block) {
        self.block(1);
    }
    
}
- (IBAction)videoCallAction:(id)sender {
    if (self.block) {
        self.block(2);
    }
//    [[GJDemoCallManager sharedManager] makeCallWithUsername:@"lius" type:EMCallTypeVideo];
}
- (IBAction)phoneAction:(id)sender {
    if (self.block) {
        self.block(3);
    }
}

@end
