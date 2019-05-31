//
//  GJVisitorView.h
//  物联宝管家
//
//  Created by 付智鹏 on 16/3/9.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WLBCodeReaderViewDelegate <NSObject>
- (void)readerScanResult:(NSString *)result;
-(void)WriteWechatStr:(NSString *)writestr;
-(void)pushLoginvc;
@end
@interface GJVisitorView : UIView
@property (nonatomic, weak) id<WLBCodeReaderViewDelegate> delegate;
@property (nonatomic,copy)UIImageView * readLineView;
@property (nonatomic,assign)BOOL is_Anmotion;
@property (nonatomic,assign)BOOL is_AnmotionFinished;
@property(nonatomic,strong)UIView *fillinView;
@property(nonatomic,strong)UIButton *FillinButton;
@property(nonatomic,strong)UIWindow *mainWindow;
@property(nonatomic,strong)UIButton *coverButton;

@property(strong,nonatomic)UIButton *btn;

//开启关闭扫描
- (void)start;
- (void)stop;
- (void)loopDrawLine;//初始化扫描线

@end
