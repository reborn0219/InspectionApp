//
//  ShowImageVC.h
//  物联宝管家
//
//  Created by guokang on 2019/4/24.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowImageVC : UIViewController
@property (nonatomic,copy) AlertBlock block;

- (void)setImageWithImageArray:(NSMutableArray *)imageArr withIndex:(int)index;
@end

NS_ASSUME_NONNULL_END
