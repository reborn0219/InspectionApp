//
//  GJConsultationViewCell.h
//  物联宝管家
//
//  Created by forMyPeople on 16/5/25.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJConsultationViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *timeLables;
@property(nonatomic,strong)UILabel *contentLable;
@property(nonatomic,strong)UILabel *rightLable;
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;

@end
