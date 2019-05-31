//
//  GJContractTableViewCell.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/11.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJContractTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *rightLables;
@property(nonatomic,strong)UILabel *leftLables;
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@end
