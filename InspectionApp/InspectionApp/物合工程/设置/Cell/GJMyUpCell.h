//
//  GJMyUpCell.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/23.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJMyUpCell : UITableViewCell
@property(nonatomic,strong)UIImageView *userImageView;
//@property(nonatomic,strong)UILabel *userNameLable;
@property(nonatomic,strong)UIImageView *iconImageView;
//@property(nonatomic,strong)UILabel *companyLable;
@property(nonatomic,strong)UILabel *nicknameLable;
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@end
