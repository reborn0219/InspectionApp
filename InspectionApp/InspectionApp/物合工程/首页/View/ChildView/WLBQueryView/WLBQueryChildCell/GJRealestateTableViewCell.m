//
//  GJRealestateTableViewCell.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/11.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJRealestateTableViewCell.h"

@implementation GJRealestateTableViewCell

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
    self.rightLables = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, W-90, 20)];;
    self.rightLables.textColor = gycolor;
    self.rightLables.font = [UIFont fontWithName:geshi size:14];
    self.leftLables = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 70, 20)];;
    self.leftLables.textColor = gycolor;
    self.leftLables.font = [UIFont fontWithName:geshi size:14];
    UILabel *linelable = [[UILabel alloc]initWithFrame:CGRectMake(15, 39, W-30, 1)];
    linelable.backgroundColor = gycoloers;
    [self addSubview:linelable];
    [self addSubview:self.leftLables];
    [self addSubview:self.rightLables];
}
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJRealestateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJRealestateTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
