//
//  GJPositioningTableViewCell.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/4/6.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJPositioningTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *leftLables;
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@end
