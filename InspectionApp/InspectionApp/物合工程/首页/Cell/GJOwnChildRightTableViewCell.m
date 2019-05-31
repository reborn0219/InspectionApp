
//
//  GJOwnChildRightTableViewCell.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/16.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJOwnChildRightTableViewCell.h"
@implementation GJOwnChildRightTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor whiteColor];
        [self createdUI];
    }
    return self;
}

-(void)createdUI
{
    self.topimageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 40, 40)];
    self.leftLables = [[UILabel alloc]initWithFrame:CGRectMake(60, 5, 100, 20)];;
    self.leftLables.textColor = gycolor;
    self.leftLables.font = [UIFont fontWithName:geshi size:12];
    self.rightImageview = [[UIImageView alloc]initWithFrame:CGRectMake(60, 28, 15, 15)];
    self.rightImageview.backgroundColor = [UIColor clearColor];
    self.realImageView = [[UIImageView alloc]initWithFrame:CGRectMake(80, 30, 15, 15)];
    self.RealLable = [[UILabel alloc]initWithFrame:CGRectMake(100, 28, 100, 15)];
    self.RealLable.textAlignment = NSTextAlignmentLeft;
    self.RealLable.textColor = gycolor;
    self.RealLable.font = [UIFont fontWithName:geshi size:12];
    
    UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(5, 49.5, self.size.width - 10, 0.5)];
    UIImageView *arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W/3*2 - 15, 15, 20, 20)];
    arrowImageView.image = [UIImage imageNamed:@"sssss"];
    arrowImageView.backgroundColor = [UIColor clearColor];
    alable.backgroundColor = gycoloers;
    [self addSubview:alable];
    [self addSubview:arrowImageView];
    [self addSubview:self.topimageView];
    [self addSubview:self.leftLables];
    [self addSubview:self.rightImageview];
    [self addSubview:self.realImageView];
    [self addSubview:self.RealLable];
}
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJOwnChildRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJOwnChildRightTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}




@end
