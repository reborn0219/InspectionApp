//
//  GJChargeTableViewCell.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/11.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJChargeTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *topImageView;
@property(nonatomic,strong)UILabel *contentliftLable;
@property(nonatomic,strong)UILabel *stateLable;
@property(nonatomic,strong)UILabel *dataLable;
@property(nonatomic,strong)UILabel *lineLable;
@property(nonatomic,strong)UILabel *contentLable;
@property(nonatomic,strong)UIImageView *rightImage;
@property(nonatomic,strong)UILabel *upLable;
@property(nonatomic,strong)UILabel *downLable;
#pragma mark 创建cell
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@end
