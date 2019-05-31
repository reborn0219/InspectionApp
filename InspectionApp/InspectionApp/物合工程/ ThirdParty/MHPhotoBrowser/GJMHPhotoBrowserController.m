//
//  GJMHPhotoBrowserController.h
//  图片浏览器
//
//  Created by LMH on 16/3/10.
//  Copyright © 2016年 LMH. All rights reserved.
//

#import "GJMHPhotoBrowserController.h"
#import "GJSVProgressHUD.h"

@interface GJMHPhotoBrowserController ()<MHPhotosBrowseDelegate>

@end

@implementation GJMHPhotoBrowserController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    _photosBrowser = [[GJMHPhotosBrowserView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _photosBrowser.displayTopPageNumber = self.displayTopPage;
    _photosBrowser.displayDeleteBtn= self.displayDeleteBtn;
    _photosBrowser.currentImgIndex = self.currentImgIndex;
    [_photosBrowser reloadPhotoBrowseWithPhotoArray:self.imgArray];
    [_photosBrowser setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    _photosBrowser.delegate = self;
    [self.view addSubview:_photosBrowser];
}

- (void)photosBrowse:(GJMHPhotosBrowserView *)photosBrowse didClickDeleteBtnAtIndex:(NSInteger)index
{
    self.selectindex(index);
    if (index < self.imgArray.count) {
        [self.imgArray removeObjectAtIndex:index];
        if (self.imgArray.count) {
            [_photosBrowser reloadPhotoBrowseWithPhotoArray:self.imgArray];
        }
        else {
            [self singleTapDetected];
        }
    }
}

- (void)setDisplayTopPage:(BOOL)displayTopPage
{
    _displayTopPage = displayTopPage;
}
- (void)setDisplayDeleteBtn:(BOOL)displayDeleteBtn
{
    _displayDeleteBtn = displayDeleteBtn;
}

- (void)viewDidAppear:(BOOL)animated{
    if (self.imgArray.count == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)singleTapDetected
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"PhotoBrowserViewController--dealloc");
#endif
    _photosBrowser = nil;
}
@end
