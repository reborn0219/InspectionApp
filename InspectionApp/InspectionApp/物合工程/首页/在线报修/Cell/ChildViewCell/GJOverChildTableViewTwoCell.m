
//
//  GJOverChildTableViewTwoCell.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/18.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJOverChildTableViewTwoCell.h"

@implementation GJOverChildTableViewTwoCell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJOverChildTableViewTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJOverChildTableViewTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
@end
