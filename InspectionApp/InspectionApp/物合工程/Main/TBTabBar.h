//
//  TBTabBar.h
//  OneBAuction
//
//  Created by 刘帅 on 2019/4/6.
//  Copyright © 2019 刘帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBTabBar : UITabBar

//@property(nonatomic,strong)UIButton *publishBtn;

@property (nonatomic,copy) void(^didClickPublishBtn)();

@end
