//
//  GJVonsultationChildQuestTableViewCell.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/25.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJVonsultationChildQuestTableViewCell.h"

@implementation GJVonsultationChildQuestTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJVonsultationChildQuestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell) {
        cell = [[GJVonsultationChildQuestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell; 
}

@end
