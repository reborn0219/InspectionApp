//
//  GJMatterTableViewCell.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/4/12.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJMatterTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *leftLables;
@property(nonatomic,strong)UILabel *rightLables;
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@end
