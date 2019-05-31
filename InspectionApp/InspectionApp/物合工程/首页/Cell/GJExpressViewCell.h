//
//  GJExpressViewCell.h
//  物联宝管家
//
//  Created by forMyPeople on 16/7/12.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJExpressViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *MoneyLable;
@property(nonatomic,strong)UILabel *TimeLable;
@property(nonatomic,strong)UILabel *YuyueLable;
@property(nonatomic,strong)UIImageView *leftImageView;
@property(nonatomic,strong)UILabel *TypeLable;
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@end
