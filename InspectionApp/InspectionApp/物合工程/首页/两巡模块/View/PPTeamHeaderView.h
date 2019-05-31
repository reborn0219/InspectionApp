//
//  PPTeamHeaderView.h
//  物联宝管家
//
//  Created by yang on 2019/3/20.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPTeamHeaderView : UIView
@property(nonatomic,copy)CellEventBlock block;

-(void)requestData:(NSDictionary *)infoDic;
@end
