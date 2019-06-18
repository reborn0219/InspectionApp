//
//  PSWOTextViewCell.m
//  InspectionApp
//
//  Created by guokang on 2019/6/5.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWOTextViewCell.h"

@implementation PSWOTextViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _backV.layer.cornerRadius = 5;
    _backV.layer.shadowColor = SHADOW_COLOR.CGColor;
    _backV.layer.shadowOffset = CGSizeMake(0,0);
    _backV.layer.shadowOpacity = 0.2;
    _backV.layer.shadowRadius = 2;
    _markTV.delegate = self;
    _moneyTF.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (_block) {
        _block(nil,nil,nil);
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
   
}
@end
