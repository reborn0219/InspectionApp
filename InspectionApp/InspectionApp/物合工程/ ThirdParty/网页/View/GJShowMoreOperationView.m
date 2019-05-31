//
//  GJShowMoreOperationView.m
//  MeiLin
//
//  Created by 曹学亮 on 16/9/19.
//  Copyright © 2016年 Li Chuanliang. All rights reserved.
//

#import "GJShowMoreOperationView.h"
#import "Masonry.h"
#import "GJCollectionNomalCell.h"
#import "GJCollectionNormalModel.h"
#import "AW_Constants.h"

#define ContentViewHeight    300  //容器视图高度
#define TopViewHeight        30   //顶部View高度
#define CollectionViewHeight 110  //collectionview高度
#define CancleButtonHeight   45   //取消按钮高度

@interface GJShowMoreOperationView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray *topDataArray;          //上面数据源
@property (nonatomic,strong) NSMutableArray *bottomDataArray;       //下面数据源
@property (nonatomic,strong) UIView *contentView;                   //容器视图
@property (nonatomic,strong) UIView *topView;                       //顶部视图
@property (nonatomic,strong) UIView *middleView;                    //底部视图
@property (nonatomic,strong) UICollectionView *topCollectionView;   //上部collectionView
@property (nonatomic,strong) UICollectionView *bottomCollectionView;//下部collectionView
@property (nonatomic,strong) UILabel *middleLabel;                  //提示Label
@property (nonatomic,strong) UIControl *bgView;                     //黑色背景
@property (nonatomic,strong) CAShapeLayer *middleLayer;             //中间分隔线
@property (nonatomic,strong) UIButton *cancleButton;                //取消按钮
@property (nonnull,copy)     NSString *URLString;                   //网页链接
@end

@implementation GJShowMoreOperationView
#pragma mark - Init Menthod
- (instancetype)initWithString:(NSString*)title DoneBlock:(void(^)(NSString *selectIterm))block{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.doneBlock = block;
        self.URLString = title;
        [self addSubViews];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        [self addSubViews];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)addSubViews{
    [self addSubview:self.bgView];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.middleView];
    [self.topView addSubview:self.middleLabel];
    [self.middleLabel mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.topView);
    }];
    
    [self.middleView addSubview:self.topCollectionView];
    [self.middleView addSubview:self.bottomCollectionView];
    [self.middleView.layer addSublayer:self.middleLayer];
    
    [self.contentView addSubview:self.cancleButton];
    [self.cancleButton mas_makeConstraints:^(GJMASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.middleView.mas_bottom);
    }];
    
    self.middleLabel.text = [NSString stringWithFormat:@"网页由%@提供",self.URLString];
}

#pragma mark - Event Response
- (void)dismissWithCompletionBlock:(void (^)(void))completionBlock{
    CGPoint endCenter = self.contentView.center;
    endCenter.y = ContentViewHeight/2 + SCREEN_HEIGHT;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgView.alpha = 0.0;
        self.contentView.center = endCenter;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showMenuView{
    [kKeyWindow addSubview:self];
    CGPoint endCenter = self.contentView.center;
    endCenter.y = (SCREEN_HEIGHT - ContentViewHeight) + ContentViewHeight/2;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgView.alpha = 0.3;
        self.contentView.center = endCenter;
    } completion:nil];
}

#pragma mark - UICollectionView M
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
     return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.topCollectionView) {
        return self.topDataArray.count;
    }else{
        return self.bottomDataArray.count;
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MJWeakSelf
    GJCollectionNormalModel *normalModel;
    if (collectionView == self.topCollectionView) {
        normalModel = self.topDataArray[indexPath.item];
    }else{
        normalModel = self.bottomDataArray[indexPath.item];
    }

    GJCollectionNomalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionNomalCell" forIndexPath:indexPath];
    cell.normalModel = normalModel;
    cell.didSelectedItermBlock = ^(GJCollectionNormalModel *currentModel){
        if (weakSelf.doneBlock) {
            weakSelf.doneBlock(currentModel.titleName);
        }
        [weakSelf dismissWithCompletionBlock:NULL];
    };
    return cell;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - Setter && Getter
- (NSMutableArray *)topDataArray{
    if (!_topDataArray) {
        _topDataArray = [[NSMutableArray alloc]init];
        NSArray *tmpArray = @[
                              @{
                                @"imageName" :  @"Action_Share_60x60_",
                                @"titleName" :  @"发送给朋友"
                               },
                              
                              @{
                                  @"imageName" :  @"AS_safari_60x60_",
                                  @"titleName" :  @"在Safair中打开"
                                  },
                              ];
        [tmpArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dict = obj;
            [_topDataArray addObject:[GJCollectionNormalModel initWithDictionary:dict]];
        }];
    }
    return _topDataArray;
}

- (NSMutableArray *)bottomDataArray{
    if (!_bottomDataArray) {
        _bottomDataArray = [[NSMutableArray alloc]init];
        NSArray *tmpArray = @[
                              @{
                                  @"imageName" :  @"Action_Refresh_60x60_",
                                  @"titleName" :  @"刷新"
                                  },
                              
                              @{
                                  @"imageName" :  @"Action_Expose_60x60_",
                                  @"titleName" :  @"投诉"
                                  },

                              ];
        [tmpArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSDictionary *dict = obj;
            [_bottomDataArray addObject:[GJCollectionNormalModel initWithDictionary:dict]];
        }];
    }
    return _bottomDataArray;
}

- (UIView*)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:Rect(0, kSCREEN_HEIGHT - ContentViewHeight, kSCREEN_WIDTH, ContentViewHeight)];
        _contentView.backgroundColor = HexRGB(0xF0F0F0);
      
    }
    return _contentView;
}

- (UIView*)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:Rect(0, 0,SCREEN_WIDTH,TopViewHeight)];
        _topView.backgroundColor = [UIColor clearColor];
    }
    return _topView;
}

- (UIView *)middleView{
    if (!_middleView) {
        _middleView = [[UIView alloc]initWithFrame:Rect(0, TopViewHeight, SCREEN_WIDTH, CollectionViewHeight * 2)];
        _middleView.backgroundColor = [UIColor clearColor];
    }
    return _middleView;
}

- (UICollectionView*)topCollectionView{
    if (!_topCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/4,CollectionViewHeight - 10);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);;
        _topCollectionView = [[UICollectionView alloc]initWithFrame:Rect(0,0, SCREEN_WIDTH, CollectionViewHeight) collectionViewLayout:layout];
        [_topCollectionView registerClass:[GJCollectionNomalCell class] forCellWithReuseIdentifier:@"CollectionNomalCell"];
        _topCollectionView.backgroundColor = [UIColor clearColor];
        _topCollectionView.userInteractionEnabled = YES;
        _topCollectionView.showsHorizontalScrollIndicator = NO;
        _topCollectionView.dataSource = self;
        _topCollectionView.delegate = self;
    }
    return _topCollectionView;
}

- (UICollectionView*)bottomCollectionView{
    if (!_bottomCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH/4,CollectionViewHeight - 10);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        _bottomCollectionView = [[UICollectionView alloc]initWithFrame:Rect(0, CollectionViewHeight, SCREEN_WIDTH, CollectionViewHeight) collectionViewLayout:layout];
        [_bottomCollectionView registerClass:[GJCollectionNomalCell class] forCellWithReuseIdentifier:@"CollectionNomalCell"];
        _bottomCollectionView.backgroundColor = [UIColor clearColor];
        _bottomCollectionView.userInteractionEnabled = YES;
        _bottomCollectionView.showsHorizontalScrollIndicator = NO;
        _bottomCollectionView.dataSource = self;
        _bottomCollectionView.delegate = self;
    }
    return _bottomCollectionView;
}

- (UIButton*)cancleButton{
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _cancleButton.titleLabel.font =[UIFont systemFontOfSize:16];
     
        [_cancleButton addTarget:self action:@selector(dismissWithCompletionBlock:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

- (UILabel*)middleLabel{
    if (!_middleLabel) {
        _middleLabel = [UILabel new];
        _middleLabel.textColor = RGBTEXTINFO;
        _middleLabel.font = [UIFont systemFontOfSize:12];
        _middleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _middleLabel;
}

- (UIControl*)bgView{
    if (!_bgView) {
        _bgView = [[UIControl alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0;
        [_bgView addTarget:self action:@selector(dismissWithCompletionBlock:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bgView;
}

-(CAShapeLayer*)middleLayer{
    if (!_middleLayer) {
        _middleLayer = [[CAShapeLayer alloc]init];
        _middleLayer.frame = Rect(10,CollectionViewHeight,SCREEN_WIDTH - 20, CGFloatFromPixel(1));
        _middleLayer.backgroundColor = HexRGB(0xc6c6c6).CGColor;
    }
    return _middleLayer;
}

@end
