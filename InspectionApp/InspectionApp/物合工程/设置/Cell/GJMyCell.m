//
//  GJMyCell.m
//  美邻管家
//
//  Created by 付智鹏 on 16/3/8.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJMyCell.h"

@implementation GJMyCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createLable];
    }
    return self;
}

-(void)createLable
{
    self.selectionStyle = UITableViewCellSelectionStyleGray;
    self.nameImagename = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 20, 20)];
    self.nameLable = [[UILabel alloc]initWithFrame:CGRectMake(60, 10,200, 20)];
    self.nameLable.textColor = gycoloer;
    self.nameLable.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:self.nameImagename];
    [self addSubview:self.nameLable];
}
//#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier{
    GJMyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJMyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
@end
