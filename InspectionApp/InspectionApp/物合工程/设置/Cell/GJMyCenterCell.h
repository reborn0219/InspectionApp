//
//  GJMyCenterCell.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/23.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol myCenterCellDelegates <NSObject>

-(void)MycenterCellDidClicked:(NSInteger)tags;

@end

@interface GJMyCenterCell : UITableViewCell
@property(nonatomic,strong)UIButton *LeftcellButton;
@property(nonatomic,strong)UIButton *CentercellButton;
@property(nonatomic,strong)UIButton *RightcellButton;
@property(nonatomic,strong)UILabel *Leftlable;
@property(nonatomic,strong)UILabel *Centerlable;
@property(nonatomic,strong)UILabel *Rightlable;
+(instancetype)createCellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier;
@property(nonatomic,assign)id<myCenterCellDelegates>centerCellDelegates;
@end
