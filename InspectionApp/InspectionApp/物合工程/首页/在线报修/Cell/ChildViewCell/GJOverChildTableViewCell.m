//
//  GJOverChildTableViewCell.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/18.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJOverChildTableViewCell.h"

@implementation GJOverChildTableViewCell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJOverChildTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GJOverChildTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    else{
        for (UIView *ve in cell.contentView.subviews) {
            [ve removeFromSuperview];
        }
        
    }
    return cell;
}
@end
