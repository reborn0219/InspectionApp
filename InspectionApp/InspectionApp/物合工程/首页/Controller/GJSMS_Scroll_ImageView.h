//
//  GJSMS_Scroll_ImageView.h
//  GJSMS_Scroll_ImageView
//
//  Created by dllo on 15/10/16.
//  Copyright (c) 2015年 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol TitleDelegate <NSObject>
//
//- (CGRect)FrameLabel;
//
//@end

@interface GJSMS_Scroll_ImageView : UIView
//@property (nonatomic, assign) id <TitleDelegate> delegate;

@property (nonatomic, retain) NSMutableArray *titleArr;

#warning 方法参数详解
#pragma mark - 本地图片轮播方法
- (instancetype)initWithSMS_ImagePath1:(NSString *)path1
                            ImagePath2:(NSString *)path2
                            ImageCount:(NSInteger)count
                          IntervalTime:(CGFloat)time
                                 Frame:(CGRect)frame
                           PageControl:(BOOL)pageControl
                            PageNumber:(BOOL)pageNumber;
//参数1: ImagePath1 本地图片名数字前面字符串
//参数2: ImagePath2 本地图片名后缀
//参数3: Image 图片个数
//参数4: IntervalTime 轮播时间间隔 (time >= 0.2)
//参数5: Frame 视图位置尺寸
//参数6: PageControl 是否需要页码控制器
//参数7: 另一种页码表示
//注:1. time >= 0.2 ,
//   2. 本地图片判别数字类型需 00 ~ 99内
//   3. 如果无SD请把.M头文件处把 "1" 修改成0,如有强迫症请在该文件177行代码处再改一次;

#pragma mark - 网络图片轮播
- (instancetype)initWithSMS_ImageURLArr:(NSMutableArray *)URLArr
                           IntervalTime:(CGFloat)time
                                  Frame:(CGRect)frame
                            PageControl:(BOOL)pageControl
                             Pagenumber:(BOOL)pageNumber
                             TitleFrame:(CGRect)frame;

//参数1: ImageURLArr 网络图片字符串数组
//参数2: IntervalTime 轮播时间间隔 (time >= 0.2)
//参数3: Frame 视图位置尺寸
//参数4: PageControl 是否需要页码控制器
//参数5: 另一种页码标识
//参数6

//注: 1. time >= 0.2
//    2. 需与SD~~配合使用

//- (void)TitleArr:(NSMutableArray *)titleArr TitleFrame:(CGRect)titleframe;




@end
