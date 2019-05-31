//
//  GJExecutedFishTableViewCell.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/19.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJExecutedFishTableViewCell.h"

@implementation GJExecutedFishTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createdUI];
    }
    return self;
}

+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJExecutedFishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJExecutedFishTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
-(void)createdUI
{
    _leftLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, W/2 - 10,20)];
    _leftLable.textColor = gycoloer;
    _leftLable.font = [UIFont fontWithName:geshi size:13];
    _leftLable.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_leftLable];
    _rightLable = [[UILabel alloc]initWithFrame:CGRectMake(W/2, 10, W/2 - 40,20)];
    _rightLable.textColor = gycoloer;
    _rightLable.font = [UIFont fontWithName:geshi size:13];
    _rightLable.textAlignment = NSTextAlignmentRight;
    [self addSubview:_rightLable];
    UILabel *downLineLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 39.5, W - 10, 0.5)];
    downLineLable.backgroundColor = gycoloers;
    [self addSubview:downLineLable];
}


@end
