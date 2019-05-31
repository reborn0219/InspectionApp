//
//  GJMatterTableViewCellFour.m
//  物联宝管家
//
//  Created by forMyPeople on 16/6/13.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJMatterTableViewCellFour.h"

@implementation GJMatterTableViewCellFour

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor whiteColor];
        [self setAccessoryType:UITableViewCellAccessoryNone];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJMatterTableViewCellFour *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GJMatterTableViewCellFour alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    else{
        for (UIView *ve in cell.contentView.subviews) {
            [ve removeFromSuperview];
        }
        
    }
    return cell;

}


@end
