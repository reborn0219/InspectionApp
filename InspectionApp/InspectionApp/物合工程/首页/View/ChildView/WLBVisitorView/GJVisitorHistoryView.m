//
//  GJVisitorHistoryView.m
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/10.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJVisitorHistoryView.h"

@implementation GJVisitorHistoryView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//        self.mj_header = [GJMJRefreshNormalHeader headerWithRefreshingBlock:^{
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                // 结束刷新
//                [self.mj_header endRefreshing];
//            });
//        }];
//        // 马上进入刷新状态
//        [self.mj_header beginRefreshing];
    }
    self.separatorStyle = UITableViewCellSeparatorStyleNone;

    return self;
}
@end
