//
//  GJFJSlidingController.h
//  GJFJSlidingController
//
//  Created by fujin on 15/12/17.
//  Copyright © 2015年 fujin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FJSlidingControllerDataSource;
@protocol FJSlidingControllerDelegate;

@interface GJFJSlidingController : UIViewController
@property (nonatomic, assign)id<FJSlidingControllerDataSource> datasouce;
@property (nonatomic, assign)id<FJSlidingControllerDelegate> delegate;
-(void)reloadData;
@end

@protocol FJSlidingControllerDataSource <NSObject>
@required
// pageNumber
- (NSInteger)numberOfPageInFJSlidingController:(GJFJSlidingController *)fjSlidingController;
// index -> UIViewController
- (UIViewController *)fjSlidingController:(GJFJSlidingController *)fjSlidingController controllerAtIndex:(NSInteger)index;
// index -> Title
- (NSString *)fjSlidingController:(GJFJSlidingController *)fjSlidingController titleAtIndex:(NSInteger)index;

@optional
// textNomalColor
- (UIColor *)titleNomalColorInFJSlidingController:(GJFJSlidingController *)fjSlidingController;
// textSelectedColor
- (UIColor *)titleSelectedColorInFJSlidingController:(GJFJSlidingController *)fjSlidingController;
// lineColor
- (UIColor *)lineColorInFJSlidingController:(GJFJSlidingController *)fjSlidingController;
// titleFont
- (CGFloat)titleFontInFJSlidingController:(GJFJSlidingController *)fjSlidingController;
@end

@protocol FJSlidingControllerDelegate <NSObject>
@optional
// selctedIndex
- (void)fjSlidingController:(GJFJSlidingController *)fjSlidingController selectedIndex:(NSInteger)index;
// selectedController
- (void)fjSlidingController:(GJFJSlidingController *)fjSlidingController selectedController:(UIViewController *)controller;
// selectedTitle
- (void)fjSlidingController:(GJFJSlidingController *)fjSlidingController selectedTitle:(NSString *)title;
@end
