//
//  GJVisHistoryCell.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/10.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJVisHistoryCell.h"

@implementation GJVisHistoryCell
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
    self.topimageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 18, 18)];
    self.leftLables = [[UILabel alloc]initWithFrame:CGRectMake(35, 10, 100, 20)];;
    self.leftLables.textColor = gycolor;
    self.leftLables.font = [UIFont fontWithName:geshi size:12];
    self.rightLables = [[UILabel alloc]initWithFrame:CGRectMake(130, 10, 120, 20)];;
    self.rightLables.textColor = gycoloer;
    self.rightLables.textAlignment = NSTextAlignmentRight;
    self.rightLables.font = [UIFont fontWithName:geshi size:12];
    UILabel *alable = [[UILabel alloc]initWithFrame:CGRectMake(15, 39.5, W - 30, 0.5)];
    alable.backgroundColor = gycoloers;
    [self addSubview:alable];
    [self addSubview:self.topimageView];
    [self addSubview:self.leftLables];
    [self addSubview:self.rightLables];
}
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJVisHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJVisHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

@end
