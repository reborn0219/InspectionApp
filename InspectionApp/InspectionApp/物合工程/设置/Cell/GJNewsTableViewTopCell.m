//
//  GJNewsTableViewTopCell.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/23.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJNewsTableViewTopCell.h"

@implementation GJNewsTableViewTopCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createLable];
    }
    return self;
}

-(void)createLable
{
    self.LeftLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 10,200, 20)];
    self.LeftLable.textColor = gycolor;
    self.LeftLable.font = [UIFont fontWithName:geshi size:15];
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 39, W - 30, 1)];
    lineLable.backgroundColor = gycoloers;
    self.HeadportraitView = [[UIImageView alloc]initWithFrame:CGRectMake(W - 50, 5, 30, 30)];
    self.HeadportraitView.layer.masksToBounds = YES;
    self.HeadportraitView.layer.cornerRadius = self.HeadportraitView.bounds.size.width*0.5;
    [self addSubview:self.HeadportraitView];
    [self addSubview:lineLable];
    [self addSubview:self.LeftLable];
}
//#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier{
    GJNewsTableViewTopCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJNewsTableViewTopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
