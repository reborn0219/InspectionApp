//
//  GJMatterTypeTableViewCell.h
//  物联宝管家
//
//  Created by forMyPeople on 16/5/9.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJMatterTypeTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *leftLables;
@property(nonatomic,strong)UIImageView *aimageView;
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@end
