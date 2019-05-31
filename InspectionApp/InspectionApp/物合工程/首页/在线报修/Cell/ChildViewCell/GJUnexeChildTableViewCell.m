//
//  GJUnexeChildTableViewCell.m
//  物联宝管家
//
//  Created by forMyPeople on 16/5/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJUnexeChildTableViewCell.h"

@implementation GJUnexeChildTableViewCell
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self createLable];
//    }
//    return self;
//}
//
//-(void)createLable
//{
//    self.VoicetimeLables = [[UILabel alloc]initWithFrame:CGRectMake(110, 60, 100, 50)];
//    self.VoicetimeLables.backgroundColor = [UIColor clearColor];
//    self.VoicetimeLables.textColor = FZColor(110, 185, 43);
//    self.VoicetimeLables.font = [UIFont fontWithName:geshi size:15];
//    [self addSubview:self.VoicetimeLables];
//}
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier
{
    GJUnexeChildTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[GJUnexeChildTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    else{
        for (UIView *ve in cell.contentView.subviews) {
            [ve removeFromSuperview];
        }
        
    }
    return cell;

}

@end
