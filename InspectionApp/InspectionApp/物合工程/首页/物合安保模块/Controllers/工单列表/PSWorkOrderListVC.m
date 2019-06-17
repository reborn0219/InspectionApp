//
//  PSWorkOrderListVC.m
//  InspectionApp
//
//  Created by guokang on 2019/5/31.
//  Copyright © 2019 yang. All rights reserved.
//

#import "PSWorkOrderListVC.h"
#import "XXPageTabView.h"
#import "PSBasicWorkOrderVC.h"

@interface PSWorkOrderListVC ()<XXPageTabViewDelegate>
@property (nonatomic, strong)  PSBasicWorkOrderVC *selectedVC;
@property (nonatomic, strong) XXPageTabView *pageTabView;
@end

@implementation PSWorkOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = HexRGB(0xFEFEFE);
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self pageTabViewDidEndChange];
}
-(void)createUI
{
    [self.navigationController setNavigationBarHidden:YES];

    PSBasicWorkOrderVC *oneVC = [[PSBasicWorkOrderVC alloc]init];
    self.selectedVC = oneVC;
      PSBasicWorkOrderVC *twoVC = [[PSBasicWorkOrderVC alloc]init];
      PSBasicWorkOrderVC *threeVC = [[PSBasicWorkOrderVC alloc]init];
      PSBasicWorkOrderVC *fourVC = [[PSBasicWorkOrderVC alloc]init];
    PSBasicWorkOrderVC *fiveVC = [[PSBasicWorkOrderVC alloc]init];
    [self addChildViewController:oneVC];
    [self  addChildViewController:twoVC];
    [self addChildViewController:threeVC];
    [self  addChildViewController:fourVC];
    [self  addChildViewController:fiveVC];
    self.pageTabView = [[XXPageTabView alloc] initWithChildControllers:self.childViewControllers childTitles:@[@"未处理",@"待处理",@"处理中",@"已处理",@"已完成"]];
    self.pageTabView.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height-NavBar_H);
    self.pageTabView.delegate = self;
    
    self.pageTabView.titleStyle = XXPageTabTitleStyleDefault;
    self.pageTabView.indicatorStyle = XXPageTabIndicatorStyleStretch;
    self.pageTabView.indicatorWidth = 20;
    
    self.pageTabView.unSelectedColor = HexRGB(0x777777);
    self.pageTabView.selectedColor =HexRGB(0x46CCD9);
    [self.view addSubview:self.pageTabView];
    
}
- (void)pageTabViewDidEndChange {
    NSLog(@"#####%d", (int)self.pageTabView.selectedTabIndex);
    _selectedVC = [self.childViewControllers objectAtIndex:self.pageTabView.selectedTabIndex];
    _selectedVC.orderType = self.pageTabView.selectedTabIndex;
    [self.selectedVC requestDataWithOrderType:self.pageTabView.selectedTabIndex];
}
#pragma mark - Event response
- (void)scrollToLast:(id)sender {
    [self.pageTabView setSelectedTabIndexWithAnimation:self.pageTabView.selectedTabIndex-1];
}

- (void)scrollToNext:(id)sender {
    [self.pageTabView setSelectedTabIndexWithAnimation:self.pageTabView.selectedTabIndex+1];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
