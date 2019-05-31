//
//  GJMHPhotoBrowserController.h
//  图片浏览器
//
//  Created by LMH on 16/3/10.
//  Copyright © 2016年 LMH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJMHPhotoModel.h"
#import "GJMHPhotosBrowserView.h"

typedef void (^SelectImageBlock)(NSInteger);

@protocol SelectImageFromArrayDelegate <NSObject>

-(void)SelectImageDidClicked:(NSMutableArray *)imageArray;

@end

@interface GJMHPhotoBrowserController : UIViewController
@property(nonatomic,copy)SelectImageBlock selectindex;
@property (nonatomic,strong)NSMutableArray *imgArray;
@property (nonatomic,assign)int currentImgIndex;
///是否显示顶部页码(显示顶部,则底部隐藏)
@property (nonatomic,assign) BOOL displayTopPage;
@property (nonatomic,strong)GJMHPhotosBrowserView *photosBrowser;


///是否显示删除按钮(默认不显示)
@property (nonatomic,assign) BOOL displayDeleteBtn;

///单击退出浏览
- (void)singleTapDetected;
@property(nonatomic,assign)id<SelectImageFromArrayDelegate>selectImageDelegates;
@end
