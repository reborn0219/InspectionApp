//
//  GJDeliverwaterTableViewCell.h
//  物联宝管家
//
//  Created by forMyPeople on 16/7/13.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJDeliverwaterTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *MoneyLable;
@property(nonatomic,strong)UILabel *TimeLable;
@property(nonatomic,strong)UILabel *YuyueLable;
@property(nonatomic,strong)UILabel *TypeLable;
@property(nonatomic,strong)UIImageView *leftImageView;
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@end
