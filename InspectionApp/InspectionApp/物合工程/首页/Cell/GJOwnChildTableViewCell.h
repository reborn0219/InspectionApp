//
//  GJOwnChildTableViewCell.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/16.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJOwnChildTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *Lables;
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@end
