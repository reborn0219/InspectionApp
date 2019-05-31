//
//  PPNavigationBarView.h
//  物联宝管家
//
//  Created by yang on 2019/3/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlockDefinition.h"
@interface PPNavigationBarView : UIView
@property (nonatomic,copy)AlertBlock block;
-(void)setItemTitle:(NSString *)title withType:(NSInteger)type;
-(void)setItemTitle:(NSString *)title;
@end
