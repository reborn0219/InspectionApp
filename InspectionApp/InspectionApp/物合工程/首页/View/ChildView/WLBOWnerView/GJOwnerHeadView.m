//
//  GJOwnerHeadView.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/16.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJOwnerHeadView.h"


@interface GJOwnerHeadView()

@property(nonatomic, strong) UILabel * namelabel;
@property(nonatomic, strong) UILabel * labelNumber;
@property(nonatomic, strong) UIButton * abutton;
@property(nonatomic, strong) UIImageView *leftImageView;
@property(nonatomic, strong) UIImageView *rightimageView;
@end

@implementation GJOwnerHeadView

+ (GJOwnerHeadView *)OVHeadViewWithTableView:(UITableView *)tableView
{
    static NSString * OVHeaderViewID = @"JFHeaderView";
    GJOwnerHeadView * headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:OVHeaderViewID];
    if (headView == nil) {
        headView = [[GJOwnerHeadView alloc]initWithReuseIdentifier:OVHeaderViewID];
        headView.contentView.backgroundColor = [UIColor whiteColor];
    }
    return headView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIView * _line = [[UIView alloc] initWithFrame:CGRectMake(0, 43, [UIScreen mainScreen].bounds.size.width, 1)];
        _line.backgroundColor = gycoloers;
        [self.contentView addSubview:_line];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.leftImageView.frame = CGRectMake(10, 10, 20, 20);
    self.rightimage.frame = CGRectMake(self.size.width - 20, 10, 15, 20);
    self.namelabel.frame = CGRectMake(40, 10, 100, 20);
    self.namelabel.text = @"101";
    self.abutton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.abutton.backgroundColor = [UIColor clearColor];
    self.labelNumber.frame = CGRectMake(self.size.width - 70, 10, 40, 20);
    self.labelNumber.text = @"(3)";
}
- (UILabel *)namelabel{
    if (!_namelabel) {
        _namelabel = [[UILabel alloc]init];
        _namelabel.font = [UIFont systemFontOfSize:14.0];
        _namelabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_namelabel];
    }
    return _namelabel;
}

- (UILabel *)labelNumber{
    if (!_labelNumber) {
        _labelNumber = [[UILabel alloc]init];
        _labelNumber.font = [UIFont systemFontOfSize:15.0];
        _labelNumber.textAlignment = NSTextAlignmentRight;
        _labelNumber.textColor = gycolor;
        [self.contentView addSubview:_labelNumber];
    }
    return _labelNumber;
}

- (UIButton *)abutton{
    if (!_abutton) {
        _abutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_abutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _abutton.selected = NO;
        [self.contentView addSubview:_abutton];
    }
    return _abutton;
}

- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = [UIImage imageNamed:@"xc_2x01"];
        [self.contentView addSubview:_leftImageView];
    }
    return _leftImageView;
}
- (UIImageView *)rightimage{
    if (!_rightimageView) {
        _rightimageView = [[UIImageView alloc] init];
        _rightimageView.image = [UIImage imageNamed:@"yz_2x20"];
        [self.contentView addSubview:_rightimageView];
    }
    return _rightimageView;
}
//头部点击事件
-(void)buttonClick:(UIButton *)sender
{
    if ([self.delegates respondsToSelector:@selector(OVHeaderView:didButton:)]) {
        [self.delegates OVHeaderView:self didButton:sender];
    }
}
/**
 *   设置图片箭头旋转
 */
-(void)setArrowImageViewWithIfUnfold:(BOOL)unfold
{
    double degree;
    if(unfold){
        degree = M_PI;
    } else {
        degree = 0;
    }
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.rightimage.layer.transform = CATransform3DMakeRotation(degree, 0, 0, 1);
    } completion:NULL];
}
@end
