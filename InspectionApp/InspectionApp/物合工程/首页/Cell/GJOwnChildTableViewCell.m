
//
//  GJOwnChildTableViewCell.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/16.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJOwnChildTableViewCell.h"

@implementation GJOwnChildTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = gycoloers;
        [self createdUI];
    }
    return self;
}
-(void)createdUI
{
    self.Lables = [[UILabel alloc]initWithFrame:CGRectMake(0, 15,W/3 - 20, 20)];
    self.Lables.textAlignment = NSTextAlignmentCenter;
    self.Lables.textColor = gycolor;
    self.Lables.font = [UIFont fontWithName:geshi size:17];
    UILabel *downLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 49.5, W/3, 0.5)];
    downLable.backgroundColor = viewbackcolor;
    [self addSubview:downLable];
    [self addSubview:self.Lables];
}
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJOwnChildTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJOwnChildTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


@end
