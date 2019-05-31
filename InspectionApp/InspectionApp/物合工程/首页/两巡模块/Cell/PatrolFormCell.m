//
//  PatrolFormCell.m
//  物联宝管家
//
//  Created by yang on 2019/3/22.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolFormCell.h"
@interface PatrolFormCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *leftLb;
@property (weak, nonatomic) IBOutlet UILabel *projectLb;
@property (weak, nonatomic) IBOutlet UILabel *contentLb;
@property (weak, nonatomic) IBOutlet UILabel *rightLb;
@property (weak, nonatomic) IBOutlet UITextField *resultTextView;
@property (nonatomic,strong) PPInspectDeviceModelProject_list *cellModel;

@end
@implementation PatrolFormCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _resultTextView.delegate = self;
      _resultTextView.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    _cellModel.project_result = textField.text;
}
-(void)assignmentWithModel:(PPInspectDeviceModelProject_list*)cellModel isSubmit:(BOOL)isSubmit{
    _cellModel = cellModel;

    _leftLb.textColor = HexRGB(0x777777);
    _contentLb.textColor = HexRGB(0x777777);
    _projectLb.textColor = HexRGB(0x777777);
    _leftLb.text = cellModel.project_id;
    _projectLb.text = cellModel.project_name;
    _contentLb.text = cellModel.project_range;
    _rightLb.text = cellModel.project_result;

    
    
    if (isSubmit == YES) {
        _resultTextView.hidden = NO;
        _rightLb.hidden = YES;
    }else{
        _resultTextView.hidden = YES;
        _rightLb.hidden = NO;
        _contentLb.text = cellModel.project_range?:@"-";

    }
    
}
@end
