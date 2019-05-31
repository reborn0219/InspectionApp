//
//  GJPhonenumberTableViewCell.h
//  物联宝管家
//
//  Created by forMyPeople on 16/7/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJPhonenumberTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *nameLable;
@property(nonatomic,strong)UILabel *phonenumLable;
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@end
