//
//  GJOverChildTableViewThreeCell.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/18.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJOverChildTableViewThreeCell.h"

@implementation GJOverChildTableViewThreeCell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJOverChildTableViewThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJOverChildTableViewThreeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
@end
