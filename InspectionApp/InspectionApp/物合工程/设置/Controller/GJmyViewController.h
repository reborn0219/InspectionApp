//
//  GJmyViewController.h
//  FZvovo
//
//  Created by 付智鹏 on 16/2/19.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJMyView.h"

@protocol MyCellDidClickedDelegate <NSObject>

-(void)MycellDidClicked;

@end

@interface GJmyViewController : UITableViewController
@property(nonatomic,retain)NSArray *nameArray;
@property(nonatomic,retain)NSArray *imageViewArray;
@property(nonatomic,strong)GJMyView *myview;
@property(nonatomic,assign)id<MyCellDidClickedDelegate>myCelldelegates;
@end
