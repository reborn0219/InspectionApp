//
//  GJWageFirstImageTableViewCell.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/28.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJWageFirstImageTableViewCell.h"

@implementation GJWageFirstImageTableViewCell

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
    //    单序号
    self.numberLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, 150,20 )];
    self.numberLable.font = [UIFont fontWithName:geshi size:12];
    self.numberLable.textColor = gycoloer;
    //    时间lable
    self.dataLable = [[UILabel alloc]initWithFrame:CGRectMake(W/2, 5, W/2 - 10, 20)];
    self.dataLable.font = [UIFont fontWithName:geshi size:12];
    self.dataLable.textColor = gycoloer;
    self.dataLable.textAlignment = NSTextAlignmentRight;
    //    上线
    self.uplineLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 30.5, W - 10, 0.5)];
    self.uplineLable.backgroundColor = gycoloers;
    //    样式图片
    self.SecondImagename = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 16, 16)];
    self.SecondImagename.image = [UIImage imageWithName:@"mlgj-2x34s"];
    //工单样式
    self.WageTyperLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 45, 70, 20)];
    self.WageTyperLable.font = [UIFont fontWithName:geshi size:12];
    self.WageTyperLable.font = ziti;
    self.WageTyperLable.textColor = gycoloer;
    //内容
    self.bodytextLable = [[UILabel alloc]initWithFrame:CGRectMake(80, 45, W - 110, 20)];
    self.bodytextLable.font = [UIFont fontWithName:geshi size:12];
    self.bodytextLable.textAlignment = NSTextAlignmentLeft;
    self.bodytextLable.font = ziti;
    self.bodytextLable.textColor = gycoloer;
    //    下线
    self.downLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 80.5, W - 10, 0.5)];
    self.downLable.backgroundColor = gycoloers;
    
    // 右侧尖号按钮
    self.rightImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sssss"]];
    self.rightImageView.frame = CGRectMake(W - 30, 45, 20, 20);
    UIView *aview = [[UIView alloc]initWithFrame:CGRectMake(0, 130, W, 8)];
    aview.backgroundColor = viewbackcolor;
    //急图片
    self.urgentimageView = [[UIImageView alloc]initWithFrame:CGRectMake(W - 80, 15, 30, 30)];
    [self addSubview:aview];
    [self addSubview:self.FirstImagename];
    [self addSubview:self.SerialLable];
    [self addSubview:self.numberLable];
    [self addSubview:self.dataLable];
    [self addSubview:self.SecondImagename];
    [self addSubview:self.uplineLable];
    [self addSubview:self.downLable];
    [self addSubview:self.urgentimageView];
    [self addSubview:self.bodytextLable];
    [self addSubview:self.WageTyperLable];
    [self addSubview:self.rightImageView];
}
#pragma mark 返回高度的方法
+(CGFloat)height
{
    return 138;
}
//#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier{
    GJWageFirstImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJWageFirstImageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


@end
