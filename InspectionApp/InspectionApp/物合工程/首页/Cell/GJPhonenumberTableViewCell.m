
//
//  GJPhonenumberTableViewCell.m
//  物联宝管家
//
//  Created by forMyPeople on 16/7/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJPhonenumberTableViewCell.h"

@implementation GJPhonenumberTableViewCell

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
    self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, W - 100, 25)];
    self.phonenumLable = [[UILabel alloc]initWithFrame:CGRectMake(15, 35, W - 100, 20)];
    self.nameLable.textAlignment = NSTextAlignmentLeft;
    self.phonenumLable.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.nameLable];
    [self addSubview:self.phonenumLable];
}

#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJPhonenumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJPhonenumberTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
@end
