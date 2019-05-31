//
//  GJParkingViewCell.m
//  物联宝管家
//
//  Created by forMyPeople on 16/7/8.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJParkingViewCell.h"

@implementation GJParkingViewCell

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
    self.leftLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, W/4*3, 20)];
    self.leftLable.textColor = gycolor;
    self.leftLable.textAlignment = NSTextAlignmentLeft;
    self.leftLable.font = [UIFont fontWithName:geshi size:12];
    
    self.rightLable = [[UILabel alloc]initWithFrame:CGRectMake(W/4*3 + 10, 10, W/4 - 15, 20)];
    self.rightLable.textColor = gycolor;
    self.rightLable.textAlignment = NSTextAlignmentRight;
    self.rightLable.font = [UIFont fontWithName:geshi size:12];
    [self addSubview:self.leftLable];
    [self addSubview:self.rightLable];
}
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJParkingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJParkingViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
