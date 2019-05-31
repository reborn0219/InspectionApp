//
//  PatrolMembersCell.m
//  物联宝管家
//
//  Created by yang on 2019/3/21.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolMembersCell.h"
#import "PPViewTool.h"

@interface PatrolMembersCell()
@property (weak, nonatomic) IBOutlet UIImageView *memberImgV;
@property (weak, nonatomic) IBOutlet UIView *teamHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *memberNameLb;
@property (weak, nonatomic) IBOutlet UILabel *memberContentLb;
@property (weak, nonatomic) IBOutlet UIView *stateView;
@property (weak, nonatomic) IBOutlet UILabel *menberPhoneLb;
@property (nonatomic,strong)PPGroupInfoModelMember_list * cellModel;

@end

@implementation PatrolMembersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _memberImgV.clipsToBounds = YES;
    _memberImgV.layer.cornerRadius = 32;
    _stateView.layer.cornerRadius = 5;
    UIBezierPath *fieldPath = [UIBezierPath bezierPathWithRoundedRect:_teamHeaderView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8 ,8)];
    CAShapeLayer *fieldLayer = [[CAShapeLayer alloc] init];
    fieldLayer.frame = _teamHeaderView.bounds;
    fieldLayer.path = fieldPath.CGPath;
    
    [_teamHeaderView.layer insertSublayer:[PPViewTool setGradualChangingColor:_teamHeaderView] atIndex:0];

    _teamHeaderView.layer.mask = fieldLayer;

    
}
-(void)assignmentWithModel:(PPGroupInfoModelMember_list *)model{
    _cellModel = model;
    _menberPhoneLb.text = model.member_phone;
    _memberNameLb.text = model.member_name;
    _memberContentLb.text = model.id_card;
    [_memberImgV sd_setImageWithURL:[NSURL URLWithString:model.member_avatar] placeholderImage:[UIImage imageNamed:@"menber_img"]];
    
}
-(void)setTeamOwner:(BOOL)isOwner{
    [_teamHeaderView setHidden:!isOwner];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
- (IBAction)callAction:(id)sender {
    
    NSLog(@"%@",_menberPhoneLb.text);
}

@end
