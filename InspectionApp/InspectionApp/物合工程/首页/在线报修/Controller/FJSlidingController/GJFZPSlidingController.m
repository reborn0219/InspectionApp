//
//  GJFZPSlidingController.m
//  物联宝管家
//
//  Created by forMyPeople on 16/6/30.
//  Copyright © 2016年 付智鹏. All rights reserved.
//

#import "GJFZPSlidingController.h"
#import "GJSegmentTapView.h"
@interface GJFZPSlidingController ()<SegmentTapViewDelegate,UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (nonatomic, strong) UIPageViewController *pageController;
@property (nonatomic, strong) GJSegmentTapView *segmentTapView;
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong) NSMutableArray *segmentTitles;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger willIndex;
@end

@implementation GJFZPSlidingController
-(NSMutableArray *)viewControllers{
    if (!_viewControllers) {
        _viewControllers = [NSMutableArray array];
    }
    return _viewControllers;
}
-(NSMutableArray *)segmentTitles{
    if (!_segmentTitles) {
        _segmentTitles = [NSMutableArray array];
    }
    return _segmentTitles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeCommunityID) name:@"changeCommunityID" object:nil];
    [self instance];
}
-(void)changeCommunityID
{
    self.currentIndex = 0;
}
-(void)instance{
    self.currentIndex = 0;
    
    //segmentTapView
    
//    iphoneX
    if (IS_iPhoneX) {
    self.segmentTapView = [[GJSegmentTapView alloc] initWithFrame:CGRectMake(0, 88, CGRectGetWidth(self.view.frame), 40)];
    }else{
        self.segmentTapView = [[GJSegmentTapView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 40)];

        
    }
    
    self.segmentTapView.delegate = self;
    [self.view addSubview:self.segmentTapView];
    
    //pageController
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
//    iphoneX
    if (IS_iPhoneX) {
    self.pageController.view.frame = CGRectMake(0, 88+40, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 88-40);
    }else{
        self.pageController.view.frame = CGRectMake(0, 104, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 104);

        
    }
    self.pageController.dataSource = self;
    self.pageController.delegate   = self;
    [self.view addSubview:self.pageController.view];
}

-(void)reloadData{
    [self.viewControllers removeAllObjects];
    [self.segmentTitles removeAllObjects];
    NSInteger num = 0;
    if ([self.datasouce respondsToSelector:@selector(numberOfPageInFZPSlidingController:)]) {
        num = [self.datasouce numberOfPageInFZPSlidingController:self];
    }
    for (NSInteger i = 0 ; i < num; i++) {
        if ([self.datasouce respondsToSelector:@selector(GJFZPSlidingController:controllerAtIndex:)]) {
            UIViewController *vc = [self.datasouce GJFZPSlidingController:self controllerAtIndex:i];
            [self.viewControllers addObject:vc];
            
        }
    }
    for (NSInteger i = 0 ; i < num; i++) {
        if ([self.datasouce respondsToSelector:@selector(GJFZPSlidingController:titleAtIndex:)]) {
            NSString *title = [self.datasouce GJFZPSlidingController:self titleAtIndex:i];
            [self.segmentTitles addObject:title];
        }
    }
    
    //setAttribute GJSegmentTapView
    self.segmentTapView.dataArray = self.segmentTitles;
    if ([self.datasouce respondsToSelector:@selector(titleFontInFZPSlidingController:)]) {
        self.segmentTapView.titleFont = [self.datasouce titleFontInFZPSlidingController:self];
    }
    if ([self.datasouce respondsToSelector:@selector(titleNomalColorInFZPSlidingController:)]) {
        self.segmentTapView.textNomalColor = [self.datasouce titleNomalColorInFZPSlidingController:self];
    }
    if ([self.datasouce respondsToSelector:@selector(titleSelectedColorInFZPSlidingController:)]) {
        self.segmentTapView.textSelectedColor = [self.datasouce titleSelectedColorInFZPSlidingController:self];
    }
    if ([self.datasouce respondsToSelector:@selector(lineColorInFZPSlidingController:)]) {
        self.segmentTapView.lineColor = [self.datasouce lineColorInFZPSlidingController:self];
    }
    
    //setAttribute pageController
    [self.pageController setViewControllers:@[self.viewControllers[0]] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
}

-(NSInteger)indexOfViewController:(UIViewController *)viewController{
    return [self.viewControllers indexOfObject:viewController];
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [self indexOfViewController:viewController];
    if (index == NSNotFound || index == 0) {
        return nil;
    }
    index --;
    
    return self.viewControllers[index];
}
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [self indexOfViewController:viewController];
    if (index == NSNotFound || index == self.viewControllers.count - 1) {
        return nil;
    }
    index++;
    
    return self.viewControllers[index];
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    NSInteger index = [self indexOfViewController:pendingViewControllers[0]];
    self.willIndex = index;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if(completed){
        NSInteger index = [self indexOfViewController:previousViewControllers[0]];
        NSInteger nextIndex = 0;
        if (index > self.willIndex) {
            nextIndex = index - 1;
        }else if (index < self.willIndex){
            nextIndex = index + 1;
        }
        [self.segmentTapView selectIndex:nextIndex + 1];
        //        [self callBackWithIndex:nextIndex];
    }
}

-(void)selectedIndex:(NSInteger)index{
    __weak GJFZPSlidingController *weakSelf = self;
    if (self.currentIndex == 0) {
        [self.pageController setViewControllers:@[self.viewControllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            [weakSelf callBackWithIndex:index];
        }];
    }else if (self.currentIndex < index){
        [self.pageController setViewControllers:@[self.viewControllers[index]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            [weakSelf callBackWithIndex:index];
        }];
    }else{
        [self.pageController setViewControllers:@[self.viewControllers[index]] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
            [weakSelf callBackWithIndex:index];
        }];
    }
    
}
-(void)callBackWithIndex:(NSInteger)index{
    self.currentIndex = index;
    if ([self.delegate respondsToSelector:@selector(GJFZPSlidingController:controllerAtIndex:)]) {
        [self.delegate GJFZPSlidingController:self selectedController:self.viewControllers[index]];
    }
    if ([self.delegate respondsToSelector:@selector(GJFZPSlidingController:selectedTitle:)]) {
        [self.delegate GJFZPSlidingController:self selectedTitle:self.segmentTitles[index]];
    }
    if ([self.delegate respondsToSelector:@selector(GJFZPSlidingController:selectedIndex:)]) {
        [self.delegate GJFZPSlidingController:self selectedIndex:index];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
