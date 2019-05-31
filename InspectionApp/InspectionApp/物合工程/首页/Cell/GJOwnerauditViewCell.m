//
//  GJOwnerauditViewCell.m
//  物联宝管家
//
//  Created by forMyPeople on 16/7/7.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJOwnerauditViewCell.h"

@implementation GJOwnerauditViewCell

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
    _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    _headImageView.layer.cornerRadius = 30;
    
    _userNameLable = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, 100, 30)];
    _userNameLable.textAlignment = NSTextAlignmentLeft;
    _userNameLable.font = [UIFont fontWithName:geshi size:15];
    
    _AddressLable = [[UILabel alloc]initWithFrame:CGRectMake(80,40, 200, 30)];
    _AddressLable.textAlignment = NSTextAlignmentLeft;
    _AddressLable.font = [UIFont fontWithName:geshi size:15];
    
    
    _dataLable = [[UILabel alloc]initWithFrame:CGRectMake(160, 10, W - 200, 30)];
    _dataLable.textAlignment = NSTextAlignmentRight;
    _dataLable.font = [UIFont fontWithName:geshi size:12];
    
    
    UILabel *shenheLable = [[UILabel alloc]initWithFrame:CGRectMake(W - 140, 40, 100, 30)];
    shenheLable.textAlignment = NSTextAlignmentRight;
    shenheLable.font = [UIFont fontWithName:geshi size:15];
    shenheLable.textColor =NAVCOlOUR;
    shenheLable.text = @"未审核";
    [self addSubview:_headImageView];
    [self addSubview:_userNameLable];
    [self addSubview:_AddressLable];
    [self addSubview:_dataLable];
    [self addSubview:shenheLable];
}




#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJOwnerauditViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJOwnerauditViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
