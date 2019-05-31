//
//  GJPositioningTableViewCell.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/4/6.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJPositioningTableViewCell.h"

@implementation GJPositioningTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor whiteColor];
        [self createdUI];
    }
    return self;
}

-(void)createdUI
{
    self.leftLables = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, W - 30, 20)];
    self.leftLables.backgroundColor = [UIColor clearColor];
    self.leftLables.font = [UIFont fontWithName:geshi size:15];
    self.leftLables.textColor = gycolor;
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 39, W - 15, 0.5)];
    lineLable.backgroundColor = gycoloers;
    [self addSubview:self.leftLables];
    [self addSubview:lineLable];
}
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJPositioningTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJPositioningTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
