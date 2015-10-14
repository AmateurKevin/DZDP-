//
//  DPHomeHeaderController.m
//  DZDP
//
//  Created by nickchen on 15/10/11.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPHomeHeaderController.h"
#import "DPHomeHeaderCell.h"
#import "DPHomeCategoryModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DPDealMainController.h"
#import "DPCategoryMenuController.h"
static NSString * const reuseIdentifier = @"homeHeaderCell";
static NSUInteger const RowCount = 4;

@interface DPHomeHeaderController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

/** 首页header上的图标模型 */
@property(nonatomic,strong) NSArray *homeCategoryModels;

@end

@implementation DPHomeHeaderController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _homeCategoryModels = [DPHomeCategoryModel HomeCategoryModelFromJsonFile];
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.homeCategoryModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
        DPHomeHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        DPHomeCategoryModel *homeCategoryModel = self.homeCategoryModels[indexPath.item];
        cell.label.text = homeCategoryModel.name;
        [cell.imageView sd_setImageWithURL:homeCategoryModel.iconUrl placeholderImage:[UIImage imageNamed:@"default_loading_icon"]];
        return cell;
        
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        
    DPHomeCategoryModel *model = self.homeCategoryModels[indexPath.item];
    
    DPFindShopsParam *param = [[DPFindShopsParam alloc] init];
    
    if (model.cat_id) {
        param.cat_ids = model.cat_id.description;
    }
    if (model.subcat_id) {
        param.subcat_ids = model.subcat_id.description;
    }
    
    // 全部分类页面
    if ([model.cat_id  isEqual: @(-1)]) {
        
        DPCategoryMenuController *vc = [[DPCategoryMenuController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    // 当前城市与定位城市一致再传入坐标值,否则不传
    if (sameCity) {
        if (LocationCoordinate) {
            param.location = LocationCoordinate;
        }
    }else{
        
        param.location = nil;
    }
    
    DPDealMainController *vc = [[DPDealMainController alloc] init];
    vc.shopsParam = param;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  
        return CGSizeMake(_collectionView.width / RowCount, 75);
    
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    self.pageControl.currentPage =  (int) (scrollView.contentOffset.x/scrollView.bounds.size.width + 0.5) % (self.homeCategoryModels.count);
}


@end
