//
//  GJWageThirdTableViewCell.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/3.
//  Copyright © 2016年 付智鹏. All rights reserved.
// 图片

#import "GJWageThirdTableViewCell.h"
#import "GJFZPPulldownMenuView.h"
@interface GJWageThirdTableViewCell()

@end

@implementation GJWageThirdTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setLayoutViews];
    }
    return self;
}
-(void)setLayoutViews
{
    UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 0.5)];
    alable.backgroundColor = gycoloers;
    UILabel *blable = [[UILabel alloc]initWithFrame:CGRectMake(0, 129.5, W, 0.5)];
    blable.backgroundColor = gycoloers;
    [self addSubview:alable];
    [self addSubview:blable];
//    //表头小图片
//    self.FirstImagename = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 16, 16)];
//    self.FirstImagename.image = [UIImage imageNamed:@"mlgjss"];
   self.RedWagebutton = [[UIButton alloc]initWithFrame:CGRectMake(23, 4, 8, 8)];
    self.RedWagebutton.layer.cornerRadius = 4.0;
    self.RedWagebutton.backgroundColor = [UIColor redColor];
    //    单序号
    self.numberLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, 150,20 )];
    self.numberLable.font = [UIFont fontWithName:geshi size:12];
    self.numberLable.textColor = gycoloer;
    self.WageagainButton = [[UIButton alloc]initWithFrame:CGRectMake(self.width - 100, 5, 90, 20)];
    [self.WageagainButton setTitle:@"重新提交" forState:UIControlStateNormal];
    [self.WageagainButton setBackgroundColor:gycoloer];
    [self.WageagainButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.WageagainButton.hidden = YES;
    //    时间lable
    self.dataLable = [[UILabel alloc]initWithFrame:CGRectMake(W/2, 5, W/2 - 15, 20)];
    self.dataLable.font = [UIFont fontWithName:geshi size:12];
    self.dataLable.textColor = gycoloer;
    self.dataLable.textAlignment = NSTextAlignmentRight;
    //    上线
    self.uplineLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 30.5, W - 10, 0.5)];
    self.uplineLable.backgroundColor = gycoloers;
    //    样式图片
    self.SecondImagename = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 16, 16)];
    self.SecondImagename.image = [UIImage imageNamed:@"mlgj-2x36"];

    self.pictureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, 2.5, 0 ,0)];
    //    下线
    self.downLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 80.5, W- 10, 0.5)];
    self.downLable.backgroundColor = gycoloers;

    //   急图片
    self.urgentimageView = [[UIImageView alloc]initWithFrame:CGRectMake(W - 80, 15, 30, 30)];
//    self.urgentimageView.image = [UIImage imageNamed:@"mlgj-2x38s"];
    //   右侧尖号按钮
    self.rightImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sssss"]];
    self.rightImageView.frame = CGRectMake(W - 30, 45, 20, 20);
    UIView *aview = [[UIView alloc]initWithFrame:CGRectMake(0, 130, W, 8)];
    aview.backgroundColor = viewbackcolor;
    [self addSubview:aview];
    [self addSubview:self.WageagainButton];
    [self addSubview:self.FirstImagename];
    [self addSubview:self.SerialLable];
    [self addSubview:self.numberLable];
    [self addSubview:self.dataLable];
    [self addSubview:self.SecondImagename];
    [self addSubview:self.uplineLable];
    [self addSubview:self.downLable];
    [self addSubview:self.urgentimageView];
    [self addSubview:self.pictureImageView];
    [self addSubview:self.rightImageView];
    [self addSubview:self.RedWagebutton];
}

+(CGFloat)height
{
    return 138;
}
//#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier{
    GJWageThirdTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GJWageThirdTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    else{
        for (UIView *ve in cell.contentView.subviews) {
            [ve removeFromSuperview];
        }
        
    }
    return cell;
}

@end
