//
//  GJQueryView.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/9.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol QueryButtonDidClickDelegate <NSObject>

-(void)buttonDidClicked:(UIButton *)sender;

@end

@interface GJQueryView : UIView
@property(nonatomic,assign)id<QueryButtonDidClickDelegate>delegates;
@end
