//
//  OrderBottomView.h
//  物联宝管家
//
//  Created by yang on 2019/3/20.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderBottomView : UIView
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (nonatomic,copy)AlertBlock block;
@end
