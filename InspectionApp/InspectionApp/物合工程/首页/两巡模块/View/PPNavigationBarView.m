//
//  PPNavigationBarView.m
//  物联宝管家
//
//  Created by yang on 2019/3/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PPNavigationBarView.h"
@interface PPNavigationBarView()

@property (weak, nonatomic) IBOutlet UIButton *segmentLeftBtn;
@property (weak, nonatomic) IBOutlet UIButton *segmentRightBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIView *segmentView;
@property (weak, nonatomic) IBOutlet UIButton *scanBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIButton *markOverBtn;
@end


@implementation PPNavigationBarView
-(void)awakeFromNib{
    [super awakeFromNib];
    [_scanBtn setHidden:YES];
    [_markOverBtn setHidden:YES];
}
- (IBAction)segmentBtnAction:(id)sender {
    UIButton * btn = sender;
    
    if (btn.tag==10) {
        [_segmentRightBtn setTitleColor:HexRGB(0x1ACAA1) forState:UIControlStateNormal];
        [_segmentRightBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle_right_unselected"] forState:UIControlStateNormal];
        
        [_segmentLeftBtn setTitleColor:HexRGB(0xFFFFFF) forState:UIControlStateNormal];
        [_segmentLeftBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle_left_selected"] forState:UIControlStateNormal];

    }else{
        
        [_segmentLeftBtn setTitleColor:HexRGB(0x1ACAA1) forState:UIControlStateNormal];
        [_segmentLeftBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle_left_unselected"] forState:UIControlStateNormal];
        [_segmentRightBtn setTitleColor:HexRGB(0xFFFFFF) forState:UIControlStateNormal];
        [_segmentRightBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle_right_selected"] forState:UIControlStateNormal];
    }
    
    if (_block) {
        _block(btn.tag);
    }
}


- (IBAction)backAction:(id)sender {
    
    if (_block){
        _block(1);
    }
    
}
- (IBAction)cycleBtnAction:(id)sender {
    if (_block){
        _block(2);
    }
}
- (IBAction)markOverAction:(id)sender {
    
    if (_block){
        _block(200);
    }
}
-(void)setItemTitle:(NSString *)title withType:(NSInteger)type{
    if (title) {
        _titleLb.text = title;
    }
    
    if (type==0) {
        
        self.backgroundColor = [UIColor clearColor];
        _titleLb.textColor = [UIColor whiteColor];
        [self.rightBtn setHidden:YES];
        [self.segmentView setHidden:YES];
        [self.backBtn setImage:[UIImage imageNamed:@"图标-返回_白"] forState:UIControlStateNormal];
        
        
    }else if (type==1) {
        
        self.backgroundColor = [UIColor clearColor];
        _titleLb.textColor = [UIColor whiteColor];
        [self.rightBtn setHidden:NO];
        [self.segmentView setHidden:YES];
        [self.backBtn setImage:[UIImage imageNamed:@"图标-返回_白"] forState:UIControlStateNormal];
        
        
    }else if (type==2){
        [self.rightBtn setHidden:YES];
        [self.segmentView setHidden:YES];
        [self.backBtn setImage:[UIImage imageNamed:@"图标-返回"] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor whiteColor];
        _titleLb.textColor = HexRGB(0x333333);

    }else if(type == 3){
        [self.rightBtn setHidden:YES];
        [self.segmentView setHidden:YES];
        [self.backBtn setImage:[UIImage imageNamed:@"图标-返回"] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor clearColor];
        _titleLb.textColor = HexRGB(0x333333);

    }else if(type == 4){
        [self.segmentView setHidden:YES];
        self.backgroundColor = [UIColor clearColor];
        _titleLb.textColor = [UIColor whiteColor];
        [self.rightBtn setHidden:YES];
        [self.backBtn setImage:[UIImage imageNamed:@"图标-返回_白"] forState:UIControlStateNormal];
        
    }else if (type==5){
        [self.segmentView setHidden:YES];
        [self.rightBtn setHidden:NO];
        [self.scanBtn setHidden:YES];
        [self.backBtn setImage:[UIImage imageNamed:@"图标-返回"] forState:UIControlStateNormal];
        [self.rightBtn setImage:[UIImage imageNamed:@"图标-二维码"] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor whiteColor];
        _titleLb.textColor = HexRGB(0x333333);
        
    }else if (type==6){
        
        [self.segmentView setHidden:NO];
        [self.rightBtn setHidden:NO];
        [self.scanBtn setHidden:YES];
        [self.backBtn setImage:[UIImage imageNamed:@"图标-返回"] forState:UIControlStateNormal];
        [self.rightBtn setImage:[UIImage imageNamed:@"图标-二维码"] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor whiteColor];
        _titleLb.textColor = HexRGB(0x333333);
        
    }else if (type == 7){
        [self.segmentView setHidden:NO];
        [self.rightBtn setHidden:YES];
        [self.scanBtn setHidden:YES];
        [self.backBtn setImage:[UIImage imageNamed:@"图标-返回"] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor whiteColor];
        _titleLb.textColor = HexRGB(0x333333);
    }else if (type == 8){
        [self.segmentView setHidden:NO];
        [self.rightBtn setHidden:YES];
        [self.scanBtn setHidden:YES];
        [self.segmentLeftBtn setTitle:@"语音播报" forState:(UIControlStateNormal)];
        [self.segmentRightBtn setTitle:@"工单列表" forState:(UIControlStateNormal)];
        [self.backBtn setImage:[UIImage imageNamed:@"图标-返回"] forState:UIControlStateNormal];
        [self.rightBtn setImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor whiteColor];
        _titleLb.textColor = HexRGB(0x333333);
    }else if (type == 9){
//        [self.rightBtn setHidden:NO];
//        self.rightBtn.titleLabel.text = @"标记无效";
//        [self.rightBtn setTintColor:HexRGB(0x20A1DB) ];
////        [self.rightBtn setTitleColor:HexRGB(0x20A1DB) forState:(UIControlStateNormal)];
////        self.rightBtn.titleLabel.textColor = HexRGB(0x20A1DB);
//        [self.segmentView setHidden:YES];
//        [self.backBtn setImage:[UIImage imageNamed:@"图标-返回"] forState:UIControlStateNormal];
//        self.backgroundColor = [UIColor whiteColor];
        
    }else if(type== 200){
        [self.rightBtn setHidden:YES];
        [self.segmentView setHidden:YES];
        [self.backBtn setImage:[UIImage imageNamed:@"图标-返回"] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor whiteColor];
        [_markOverBtn setHidden:NO];
        _titleLb.textColor = HexRGB(0x333333);
    }else if(type== 201){
        [self.rightBtn setHidden:YES];
        [self.segmentView setHidden:YES];
        [self.backBtn setImage:[UIImage imageNamed:@"图标-返回"] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor whiteColor];
        [_markOverBtn setHidden:NO];
        [_markOverBtn setTitle:@"提交" forState:(UIControlStateNormal)];
        _titleLb.textColor = HexRGB(0x333333);
    }
}
-(void)setItemTitle:(NSString *)title{
    _titleLb.text = title;
}
@end
