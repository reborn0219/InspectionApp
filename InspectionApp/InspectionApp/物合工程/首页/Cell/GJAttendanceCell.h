//
//  GJAttendanceCell.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/10.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJAttendanceCell : UITableViewCell
@property(nonatomic,strong)UILabel *nameLable;
@property(nonatomic,strong)UIImageView *HeadImageView;
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@end
