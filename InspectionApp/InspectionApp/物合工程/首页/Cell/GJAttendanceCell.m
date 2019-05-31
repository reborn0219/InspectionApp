//
//  GJAttendanceCell.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/10.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJAttendanceCell.h"

@implementation GJAttendanceCell

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
    self.HeadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 30, 30)];
    self.HeadImageView.backgroundColor = [UIColor clearColor];
    [self.HeadImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"avatar"]]]placeholderImage:[UIImage imageNamed:@"100x100"]];
    
    self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(20, 35,KScreenWigth - 40, 20)];
    self.nameLable.backgroundColor = [UIColor clearColor];
    self.nameLable.textColor = gycoloer;
    self.nameLable.font = [UIFont fontWithName:geshi size:15];
    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 59.5,KScreenWigth - 15, 0.5)];
    lineLable.backgroundColor = gycoloers;
    [self addSubview:lineLable];
    [self addSubview:self.nameLable];
    [self addSubview:self.HeadImageView];
}
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJAttendanceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJAttendanceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}



@end
