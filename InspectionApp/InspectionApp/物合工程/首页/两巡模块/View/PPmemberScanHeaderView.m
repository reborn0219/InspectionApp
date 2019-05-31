//
//  PPmemberScanHeaderView.m
//  物联宝管家
//
//  Created by yang on 2019/3/26.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPmemberScanHeaderView.h"
@interface PPmemberScanHeaderView()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottom_view_H;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UIView *v_4;
@property (weak, nonatomic) IBOutlet UIView *v_3;
@property (weak, nonatomic) IBOutlet UIView *v_1;
@property (weak, nonatomic) IBOutlet UIView *v_2;
@property (weak, nonatomic) IBOutlet UIButton *btn_1;
@property (weak, nonatomic) IBOutlet UIButton *btn_2;
@property (weak, nonatomic) IBOutlet UIButton *btn_3;
@property (weak, nonatomic) IBOutlet UIButton *btn_4;
@property (weak, nonatomic) IBOutlet UILabel *adressLb;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *unNormalLabel;
@property (weak, nonatomic) IBOutlet UILabel *inspectDeviceLabel;


@end

@implementation PPmemberScanHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    _bottom_view_H.constant = 80;
    [_adressLb setHidden:YES];
    [_timeLb setHidden:YES];

    [_v_2 setHidden:YES];
    [_v_3 setHidden:YES];
    [_v_4 setHidden:YES];
    [_v_1 setHidden:NO];
    self.layer.shadowColor = SHADOW_COLOR.CGColor;
    self.layer.shadowOffset = CGSizeMake(0,0);
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowRadius = 2;
}
- (void)assignmentWithModel:(PPTaskDetailModelCommunity_list *)model
{
    _nameLabel.text = model.community_name;
    _inspectDeviceLabel.text =  [NSString stringWithFormat:@"%@个已巡检设备",model.inspected_number];
    _unNormalLabel.hidden = YES;
}
- (void)assignmentWithGroupModel:(PPDeviceGroupModel *)model
{
    _nameLabel.text = model.group_name;
    _adressLb.text = model.group_no;
      _inspectDeviceLabel.text =  [NSString stringWithFormat:@"已巡组内设备%@/%@",model.inspected_number,model.device_number];
    _unNormalLabel.text = [NSString stringWithFormat:@"%@个异常设备",model.abnormal_number];
    _timeLb.hidden = YES;
}
-(void)isTeam{
    [_timeLb setHidden:NO];
    [_adressLb setHidden:NO];
    _bottom_view_H.constant = 110;
}
-(void)hiddenBottomView:(BOOL)hidden{
    [_bottomView setHidden:hidden];
}
- (IBAction)topBtnAction:(id)sender {
    
    UIButton * btn = (UIButton *)sender;
    
    [_btn_1 setTitleColor:HexRGB(0x777777) forState:UIControlStateNormal];
    [_btn_2 setTitleColor:HexRGB(0x777777) forState:UIControlStateNormal];
    [_btn_3 setTitleColor:HexRGB(0x777777) forState:UIControlStateNormal];
    [_btn_4 setTitleColor:HexRGB(0x777777) forState:UIControlStateNormal];

    [_v_2 setHidden:YES];
    [_v_3 setHidden:YES];
    [_v_4 setHidden:YES];
    [_v_1 setHidden:YES];
    
    if (btn.tag == 100) {
        //全部
        [_v_1 setHidden:NO];
        [_btn_1 setTitleColor:HexRGB(0x46CCD9) forState:UIControlStateNormal];
        if (_eventBlock) {
            _eventBlock(@"0",nil,btn.tag);
        }
     
    }else if (btn.tag == 101) {
        //正常
        [_v_2 setHidden:NO];
        [_btn_2 setTitleColor:HexRGB(0x46CCD9) forState:UIControlStateNormal];
        if (_eventBlock) {
            _eventBlock(@"2",nil,btn.tag);
        }
    }else if (btn.tag == 102) {
        //异常
        [_v_3 setHidden:NO];
        [_btn_3 setTitleColor:HexRGB(0x46CCD9) forState:UIControlStateNormal];
        if (_eventBlock) {
            _eventBlock(@"3",nil,btn.tag);
        }
    }else if (btn.tag == 103) {
        //未巡检
        [_v_4 setHidden:NO];
        [_btn_4 setTitleColor:HexRGB(0x46CCD9) forState:UIControlStateNormal];
        if (_eventBlock) {
            _eventBlock(@"1",nil,btn.tag);
        }
    }
}

@end
