//
//  GJMyCell.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/8.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJMyUnderCell : UITableViewCell
@property(nonatomic,strong)UIImageView *nameImagename;
@property(nonatomic,strong)UILabel *nameLable;
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@end
