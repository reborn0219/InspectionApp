//
//  GJCusInView.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/11.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol determineButtonDelegate <NSObject>

-(void)determineDidClicked;

@end

@interface GJCusInView : UIView
@property(nonatomic,strong)UITextField *textFiled;
@property(nonatomic,strong)id<determineButtonDelegate>delegates;
@end
