//
//  GJComplaintTableViewCell.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/25.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJComplaintTableViewCell.h"

@implementation GJComplaintTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor whiteColor];
        [self createdCell];
    }
    return self;
}

-(void)createdCell
{
    UIView *upView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W, 8)];
    upView.backgroundColor = viewbackcolor;
    UIView *cellView = [[UIView alloc]initWithFrame:CGRectMake(0, 8, W, 80)];
    cellView.backgroundColor = [UIColor whiteColor];
    UILabel *upline = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, W, 0.5)];
    upline.backgroundColor = gycoloers;
    UIImageView *aimageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    aimageView.image = [UIImage imageNamed:@"mlgjss"];
    self.timeLables = [[UILabel alloc]initWithFrame:CGRectMake(35 , 10, W/2 - 35, 20)];
    self.timeLables.textAlignment = NSTextAlignmentLeft;
    self.timeLables.textColor = gycolor;
    self.timeLables.font = [UIFont fontWithName:geshi size:15];
    
    self.rightLable = [[UILabel alloc]initWithFrame:CGRectMake(W/2, 10, W/2 - 10, 20)];
    self.rightLable.textAlignment = NSTextAlignmentRight;
    self.rightLable.textColor = gycolor;
    self.rightLable.font = [UIFont fontWithName:geshi size:15];
    
    UILabel *centerLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 39.5, W - 10, 0.5)];
    centerLable.backgroundColor = gycoloers;
    self.contentLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, W - 50, 20)];
    self.contentLable.textAlignment = NSTextAlignmentLeft;
    self.contentLable.textColor = gycoloer;
    self.contentLable.font = [UIFont fontWithName:geshi size:14];
    
    UIImageView *rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(W - 40, 50, 20, 20)];
    rightImageView.image = [UIImage imageNamed:@"sssss"];
    UILabel *downlineLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 79.5, W, 0.5)];
    downlineLable.backgroundColor = gycoloers;
    
    [cellView addSubview:upline];
    [cellView addSubview:aimageView];
    [cellView addSubview:self.timeLables];
    [cellView addSubview:centerLable];
    [cellView addSubview:rightImageView];
    [cellView addSubview:downlineLable];
    [cellView addSubview:self.contentLable];
    [cellView addSubview:self.rightLable];
    [self addSubview:cellView];
    [self addSubview:upView];
}


#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJComplaintTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJComplaintTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
