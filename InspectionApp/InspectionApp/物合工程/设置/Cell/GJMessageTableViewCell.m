//
//  GJMessageTableViewCell.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJMessageTableViewCell.h"

@implementation GJMessageTableViewCell

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
    self.topimageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 46, 46)];
    self.topTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(60, 8, W - 145, 20)];
    self.topTitleLable.textColor = gycolor;
    self.topTitleLable.font = [UIFont fontWithName:geshi size:15];
    self.contentLables = [[UILabel alloc]initWithFrame:CGRectMake(60, 33, W - 70,20)];
    self.contentLables.textColor = gycoloer;
    self.contentLables.font = [UIFont fontWithName:geshi size:13];
    self.rightLables = [[UILabel alloc]initWithFrame:CGRectMake(W - 85 , 5, 80 , 20)];;
    self.rightLables.textColor = gycoloer;
    self.rightLables.textAlignment = NSTextAlignmentLeft;
    self.rightLables.font = [UIFont fontWithName:geshi size:13];
    UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(10, 59, W - 20, 1)];
    alable.backgroundColor = gycoloers;
    [self addSubview:alable];
    [self addSubview:self.topTitleLable];
    [self addSubview:self.topimageView];
    [self addSubview:self.contentLables];
    [self addSubview:self.rightLables];
}
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJMessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


@end
