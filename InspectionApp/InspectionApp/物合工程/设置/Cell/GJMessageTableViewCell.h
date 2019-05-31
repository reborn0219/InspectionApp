//
//  GJMessageTableViewCell.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJMessageTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *topimageView;
@property(nonatomic,strong)UILabel *rightLables;
@property(nonatomic,strong)UILabel *contentLables;
@property(nonatomic,strong)UILabel *topTitleLable;
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@end
