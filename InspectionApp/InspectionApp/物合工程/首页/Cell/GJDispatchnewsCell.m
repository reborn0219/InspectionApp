//
//  GJDispatchnewsCell.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/9.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJDispatchnewsCell.h"

@implementation GJDispatchnewsCell
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
    self.rightLables = [[UILabel alloc]initWithFrame:CGRectMake(W - 180, 10, 150, 20)];;
    self.rightLables.textColor = gycoloer;
    self.rightLables.textAlignment = NSTextAlignmentRight;
    self.rightLables.font = [UIFont fontWithName:geshi size:14];
    self.leftLables = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 100, 20)];;
    self.leftLables.textColor = gycoloer;
    self.leftLables.font = [UIFont fontWithName:geshi size:14];
    [self addSubview:self.leftLables];
    [self addSubview:self.rightLables];
}
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJDispatchnewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJDispatchnewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}



@end
