//
//  GJNewsTableViewTopCell.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/23.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJNewsTableViewTopCell : UITableViewCell
@property(nonatomic,strong)UILabel *LeftLable;
@property(nonatomic,strong)UIImageView *HeadportraitView;
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@end
