//
//  PatrolOnlinePlayersCell.m
//  物联宝管家
//
//  Created by yang on 2019/3/19.
//  Copyright © 2019 wuheGJ. All rights reserved.
//

#import "PatrolOnlinePlayersCell.h"
#import "PatroPlayerItem.h"
#import "ColorDefinition.h"
@interface PatrolOnlinePlayersCell()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>

@property(nonatomic,strong)NSArray<PPTaskDetailModelMember_list*> *onlinePlayerArr;
@end

@implementation PatrolOnlinePlayersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.showsVerticalScrollIndicator = FALSE;
    self.collectionView.showsHorizontalScrollIndicator = FALSE;


    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"PatroPlayerItem" bundle:nil] forCellWithReuseIdentifier:@"PatroPlayerItem"];
    
    
}
-(void)assignmentWithArray:(NSArray<PPTaskDetailModelMember_list*> *) member_list{
    _onlinePlayerArr = member_list;
    
    [self.collectionView reloadData];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


#pragma mark - UICollectionViewDataSource
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100,160);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _onlinePlayerArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PPTaskDetailModelMember_list * cellModel = [_onlinePlayerArr objectAtIndex:indexPath.row];
    PatroPlayerItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PatroPlayerItem" forIndexPath:indexPath];
    cell.nameLb.text = cellModel.member_name;
    cell.phoneLb.text = cellModel.memeber_phone;
    [cell.itmeImgV sd_setImageWithURL:[NSURL URLWithString:cellModel.member_avatar] placeholderImage:[UIImage imageNamed:@"member_img_l"]];


    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PPTaskDetailModelMember_list * cellModel = [_onlinePlayerArr objectAtIndex:indexPath.row];
    if (_block) {
        _block(cellModel,nil,indexPath);
    }
}

@end
