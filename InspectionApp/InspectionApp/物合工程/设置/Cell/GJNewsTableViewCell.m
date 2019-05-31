//
//  GJNewsTableViewCell.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/15.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJNewsTableViewCell.h"

@implementation GJNewsTableViewCell
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
    self.RightLable = [[UILabel alloc]initWithFrame:CGRectMake(W - 180, 10, 150, 20)];
    self.RightLable .textColor = gycolor;
    self.RightLable .font = [UIFont fontWithName:geshi size:15];
    self.RightLable.textAlignment = NSTextAlignmentRight;
    [self addSubview:lineLable];
    [self addSubview:self.RightLable];
    [self addSubview:self.LeftLable];
}
//#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier{
    GJNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJNewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}



@end
