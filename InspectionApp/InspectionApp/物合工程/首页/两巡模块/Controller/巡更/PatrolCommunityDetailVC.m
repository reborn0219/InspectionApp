//
//  PatrolCommunityDetailVC.m
//  物联宝管家
//
//  Created by yang on 2019/3/23.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolCommunityDetailVC.h"
#import "PPOrderDetailView.h"
#import "PPOrdersDetailsModel.h"
#import "ShowImageVC.h"
#import "GJZXVideo.h"
#import "GJVideoPlayViewController.h"

@interface PatrolCommunityDetailVC()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)PPOrderDetailView * ppOrderDetailView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic, strong)PPOrdersDetailsModel *ordersDetailsModel;
@property (nonatomic, strong)NSMutableArray  *tempArr;
@property (nonatomic, strong)ShowImageVC  *showImageVC;

@end
@implementation PatrolCommunityDetailVC


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    self.tempArr = [NSMutableArray array];
    [self requestData];
}
-(void)creatDetailView:(id)obj{
    
    for (int i = 0; i <_tempArr.count; i++) {
        PPOrderDetailView *temp = [[[NSBundle mainBundle]loadNibNamed:@"PPOrderDetailView" owner:self options:nil] lastObject];
        
        temp.block = ^(id  _Nullable data, UIView * _Nullable view, NSInteger index) {
                PPOrdersDetailsModel *model = data;
            if (index == 1000) {
                            PPSubmitOrdersVedio_list *videoModel =  model.video_list.firstObject;
                            if (videoModel && videoModel.thumb_url.length && videoModel.video_url.length) {
                                GJZXVideo *video = [[GJZXVideo alloc] init];
                                video.playUrl = videoModel.video_url;
                                GJVideoPlayViewController *vc = [[GJVideoPlayViewController alloc] init];
                                vc.video = video;
                                vc.hidesBottomBarWhenPushed = YES;
                                [self.navigationController pushViewController:vc animated:YES];
                            }
            }else{
                self.showImageVC = [[ShowImageVC alloc]init];
                NSMutableArray *imageArr = [NSMutableArray array];
           
                for (PPSubmitOrdersPicture_list *picture in model.picture_list) {
                    
                    [imageArr addObject:picture.pic_url];
                }
                [self.showImageVC setImageWithImageArray:imageArr withIndex:index];
                [self presentViewController:self.showImageVC animated:YES completion:nil];
                
            }

        };
  
        [temp setFrame:CGRectMake(i*KScreenWigth, 0, KScreenWigth, KScreenHeight-NavBar_H)];
        [temp assignmentWithModel:_tempArr[i]];
        temp.userInteractionEnabled = YES;
        [self.scrollView addSubview:temp];
        _pageControl.numberOfPages = _tempArr.count;
    }
    _scrollView.contentSize = CGSizeMake(KScreenWigth *_tempArr.count, 0);
   [_scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*_tempIndex,0)];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}
- (void)requestData
{
    [PatrolHttpRequest patrolworkdetail:@{@"work_id":self.work_id,@"community_id":self.community_id} :^(id  _Nullable data, ResultCode resultCode, NSError * _Nullable Error) {
        NSDictionary *obj = data;
        NSLog(@"obj========%@",obj);
        if (resultCode == SucceedCode) {
            [_tempArr addObjectsFromArray:[NSArray yy_modelArrayWithClass:[PPOrdersDetailsModel class] json:[obj objectForKey:@"work_sheet_list"]]];
             [self creatDetailView:_tempArr];
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setHidden:YES];
    self.tabBarController.hidesBottomBarWhenPushed = YES;
    [self showNaBar:2];
    [self setBarTitle:@"巡查详情"];

}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.tabBarController.hidesBottomBarWhenPushed = NO;
    [self hiddenNaBar];
}

#pragma mark - lazy loading
-(UIScrollView * )scrollView{
    
    if (!_scrollView){
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0,NavBar_H, KScreenWigth, KScreenHeight-NavBar_H)];
        _scrollView.contentSize = CGSizeMake(KScreenWigth * 2, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
    }
    return _scrollView;
    
}
-(PPOrderDetailView *)ppOrderDetailView{
    if (!_ppOrderDetailView) {
        
        _ppOrderDetailView = [[[NSBundle mainBundle]loadNibNamed:@"PPOrderDetailView" owner:self options:nil] lastObject];
        [_ppOrderDetailView setFrame:CGRectMake(0, 0, KScreenWigth, KScreenHeight-NavBar_H)];
        
    }
    return _ppOrderDetailView;
}
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 40, [UIScreen mainScreen].bounds.size.width, 40)];
         _pageControl.currentPageIndicatorTintColor = HexRGB(0x51BAF4);
         _pageControl.pageIndicatorTintColor = HexRGB(0xDDDDDD);
        
    }
    return _pageControl;
}
- (void)assginWithModel:(PPOrdersDetailsModel *)model
{
    
}
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    int page = sender.contentOffset.x /SCREEN_WIDTH;
    _pageControl.currentPage = page;
    
}
@end
