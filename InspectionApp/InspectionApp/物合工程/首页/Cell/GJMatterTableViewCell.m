//
//  GJMatterTableViewCell.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/4/12.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJMatterTableViewCell.h"

@implementation GJMatterTableViewCell

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
    self.leftLables = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 70, 20)];;
    self.leftLables.textColor = gycolor;
    self.leftLables.backgroundColor = [UIColor clearColor];
    self.leftLables.font = [UIFont fontWithName:geshi size:17];
    UILabel *linelable = [[UILabel alloc]initWithFrame:CGRectMake(15, 39.5, W - 15, 0.5)];
    linelable.backgroundColor = gycoloers;
    self.rightLables = [[UILabel alloc]initWithFrame:CGRectMake(80, 10, W - 110, 20)];;
    self.rightLables.textColor = gycolor;
    self.rightLables.textAlignment = NSTextAlignmentRight;
    self.rightLables.font = [UIFont fontWithName:geshi size:14];
    [self addSubview:self.rightLables];
    [self addSubview:linelable];
    [self addSubview:self.leftLables];
}
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJMatterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJMatterTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}



@end
