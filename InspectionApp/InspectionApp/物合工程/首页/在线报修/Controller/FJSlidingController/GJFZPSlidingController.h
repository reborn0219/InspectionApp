//
//  GJFZPSlidingController.h
//  物联宝管家
//
//  Created by forMyPeople on 16/6/30.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FZPSlidingControllerDataSource;
@protocol FZPSlidingControllerDelegate;

@interface GJFZPSlidingController : UIViewController
@property (nonatomic, assign)id<FZPSlidingControllerDataSource> datasouce;
@property (nonatomic, assign)id<FZPSlidingControllerDelegate> delegate;
-(void)reloadData;
@end

@protocol FZPSlidingControllerDataSource <NSObject>
@required
// pageNumber
- (NSInteger)numberOfPageInFZPSlidingController:(GJFZPSlidingController *)GJFZPSlidingController;
// index -> UIViewController
- (UIViewController *)GJFZPSlidingController:(GJFZPSlidingController *)GJFZPSlidingController controllerAtIndex:(NSInteger)index;
// index -> Title
- (NSString *)GJFZPSlidingController:(GJFZPSlidingController *)GJFZPSlidingController titleAtIndex:(NSInteger)index;

@optional
// textNomalColor
- (UIColor *)titleNomalColorInFZPSlidingController:(GJFZPSlidingController *)GJFZPSlidingController;
// textSelectedColor
- (UIColor *)titleSelectedColorInFZPSlidingController:(GJFZPSlidingController *)GJFZPSlidingController;
// lineColor
- (UIColor *)lineColorInFZPSlidingController:(GJFZPSlidingController *)GJFZPSlidingController;
// titleFont
- (CGFloat)titleFontInFZPSlidingController:(GJFZPSlidingController *)GJFZPSlidingController;
@end

@protocol FZPSlidingControllerDelegate <NSObject>
@optional
// selctedIndex
- (void)GJFZPSlidingController:(GJFZPSlidingController *)GJFZPSlidingController selectedIndex:(NSInteger)index;
// selectedController
- (void)GJFZPSlidingController:(GJFZPSlidingController *)GJFZPSlidingController selectedController:(UIViewController *)controller;
// selectedTitle
- (void)GJFZPSlidingController:(GJFZPSlidingController *)GJFZPSlidingController selectedTitle:(NSString *)title;
@end
