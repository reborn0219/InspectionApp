//
//  GJParkingViewCell.h
//  物联宝管家
//
//  Created by forMyPeople on 16/7/8.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJParkingViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *leftLable;
@property(nonatomic,strong)UILabel *rightLable;
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@end
