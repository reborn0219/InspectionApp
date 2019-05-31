//
//  GJUnexeChildTableViewCell.h
//  物联宝管家
//
//  Created by forMyPeople on 16/5/14.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJUnexeChildTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *VoicetimeLables;
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@end
