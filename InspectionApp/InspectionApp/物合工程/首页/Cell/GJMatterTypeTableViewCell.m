//
//  GJMatterTypeTableViewCell.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/9.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJMatterTypeTableViewCell.h"

@implementation GJMatterTypeTableViewCell

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
    self.leftLables = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, W - 100, 20)];;
    self.leftLables.textColor = gycolor;
    self.leftLables.font = [UIFont fontWithName:geshi size:14];
    self.aimageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    UILabel *linelable = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, W - 15, 0.5)];
    linelable.backgroundColor = gycoloers;
    [self addSubview:self.aimageView];
    [self addSubview:linelable];
    [self addSubview:self.leftLables];
}
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJMatterTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJMatterTypeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


@end
