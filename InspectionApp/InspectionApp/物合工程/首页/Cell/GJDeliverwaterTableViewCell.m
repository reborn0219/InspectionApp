//
//  GJDeliverwaterTableViewCell.m
//  物联宝管家
//
//  Created by forMyPeople on 16/7/13.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJDeliverwaterTableViewCell.h"

@implementation GJDeliverwaterTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor whiteColor];
        [self CreatedUI];
    }
    return self;
}

-(void)CreatedUI
{
    UILabel *lefLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 50, 20)];
    lefLable.text = @"送水";
    lefLable.textColor = gycolor;
    lefLable.font = [UIFont fontWithName:geshi size:15];
    lefLable.textAlignment = NSTextAlignmentLeft;
    self.TypeLable = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, W - 70, 20)];
    self.TypeLable.textAlignment = NSTextAlignmentLeft;
    self.TypeLable.textColor = gycolor;
    self.TypeLable.font = [UIFont fontWithName:geshi size:15];
    
    self.YuyueLable = [[UILabel alloc]initWithFrame:CGRectMake(100,5, W - 110,20)];
    self.YuyueLable.textColor = NAVCOlOUR;
    self.YuyueLable.textAlignment = NSTextAlignmentRight;
    
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 29.5, W - 10, 0.5)];
    lineLable.backgroundColor = gycoloers;
    
    self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 40,  50, 50)];
    
    UILabel *monetLable = [[UILabel alloc]initWithFrame:CGRectMake(65, 45, 15, 20)];
    monetLable.textColor = gycoloer;
    
    monetLable.text = @"￥";
    monetLable.font = [UIFont fontWithName:geshi size:15];

    self.MoneyLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(monetLable.frame), 45, W - 100, 20)];
    self.MoneyLable.textColor =NAVCOlOUR;
    
    self.TimeLable = [[UILabel alloc]initWithFrame:CGRectMake(65, 70, W - 100, 20)];
    self.TimeLable.textColor = gycoloer;
    self.TimeLable.font = [UIFont fontWithName:geshi size:13];
    
    UIImageView *rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W - 40, 55, 20, 20)];
    rightImageView.image = [UIImage imageNamed:@"sssss"];
    UILabel *lineLables = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,W, 0.5)];
    lineLable.backgroundColor = gycoloers;
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, W, 8)];
    footView.backgroundColor = viewbackcolor;
    [footView addSubview:lineLables];
    [self addSubview:footView];
    [self addSubview:rightImageView];
    [self addSubview:lineLable];
    [self addSubview:monetLable];
    [self addSubview:lefLable];
    [self addSubview:self.TimeLable];
    [self addSubview:_MoneyLable];
    [self addSubview:self.leftImageView];
    [self addSubview:self.TypeLable];
    [self addSubview:_YuyueLable];
}

#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJDeliverwaterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJDeliverwaterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
@end
