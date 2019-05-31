//
//  GJOwnerHeadView.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/16.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GJOwnerHeadView;
@protocol OVHeaderViewDelegate <NSObject>
- (void)OVHeaderView:(GJOwnerHeadView *)view didButton:(UIButton *)sender;
@end

@interface GJOwnerHeadView : UITableViewHeaderFooterView
+(GJOwnerHeadView *)OVHeadViewWithTableView:(UITableView *)tableView;
@property (nonatomic, weak) id <OVHeaderViewDelegate>delegates;
@end
