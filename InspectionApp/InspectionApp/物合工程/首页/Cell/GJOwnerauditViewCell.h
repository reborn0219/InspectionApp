//
//  GJOwnerauditViewCell.h
//  物联宝管家
//
//  Created by forMyPeople on 16/7/7.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJOwnerauditViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *userNameLable;
@property(nonatomic,strong)UILabel *AddressLable;
@property(nonatomic,strong)UILabel *dataLable;

+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@end
