//
//  GJNewsTableViewSexCell.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/24.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJNewsTableViewSexCell : UITableViewCell
{
    NSString *nowSex;
}
@property(nonatomic,strong)UILabel *LeftLable;
@property(nonatomic,strong)UIButton *MaleButton;
@property(nonatomic,strong)UIButton *FemaleButton;
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@end
