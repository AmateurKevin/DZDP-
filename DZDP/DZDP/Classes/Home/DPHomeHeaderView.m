//
//  DPHomeHeaderView.m
//  DZDP
//
//  Created by nickchen on 15/9/28.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPHomeHeaderView.h"
#import "DPHomeHeaderCell.h"
#import "DPRushPurchaseCellCell.h"
#import "DPHomeCategoryModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DPCountDownTimeView.h"
#import "DPDealAPI.h"
#import <SVProgressHUD.h>
#import "DPDeal.h"
#import <SDWebImage/UIImageView+WebCache.h>

static NSString * const reuseIdentifier = @"collectionCell";
static NSString * const RushreuseIdentifier = @"rush";
static NSUInteger const rowCount = 4;


@interface DPHomeHeaderView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UICollectionView *DPRushPurchaseView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

// 倒计时
@property (weak, nonatomic)  DPCountDownTimeView *countdownView;

/** 首页抢购条团购数组 */
@property(nonatomic,strong) NSArray *rushPurchaseDeals;

@end

@implementation DPHomeHeaderView

+ (instancetype)homeHeaderView{
    return [[[NSBundle mainBundle] loadNibNamed:@"DPHomeHeaderView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setUp];
    
    DPFindDealsParam *param = [[DPFindDealsParam alloc] init];
    param.city_id = @(1800080000);
    param.cat_ids = (@326).description;
    param.page_size = @3;
    [[[DPDealAPI alloc] initWithDealParam:param] getDealsIfsuccess:^(NSArray *deals) {
        
        self.rushPurchaseDeals = deals;
        [self.DPRushPurchaseView reloadData];
        
    } failure:nil];
    
    DPCountDownTimeView *countDownView = [DPCountDownTimeView countDownTimeLabel];
    [self addSubview:countDownView];
    self.countdownView = countDownView;
    self.countdownView.top = self.collectionView.bottom;
    self.countdownView.right = self.right;
    self.countdownView.height = 30;
}

- (void)setUp{
 
    //[UINib nibWithNibName:@"ReportFilterCollectionViewCell"
     //              bundle: [NSBundle mainBundle]];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DPHomeHeaderCell"
                                                    bundle: [NSBundle mainBundle]]  forCellWithReuseIdentifier:reuseIdentifier];
    [self.DPRushPurchaseView  registerNib:[UINib nibWithNibName:@"DPRushPurchaseCellCell"
      
                                                         bundle: [NSBundle mainBundle]] forCellWithReuseIdentifier:RushreuseIdentifier];
  
}

#pragma mark -- collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if ([collectionView isEqual:self.collectionView]) {
        return self.homeCategoryModels.count;
    }else{
        return self.rushPurchaseDeals.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([collectionView isEqual:self.collectionView]) {
        
        DPHomeHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        DPHomeCategoryModel *homeCategoryModel = self.homeCategoryModels[indexPath.item];
        cell.label.text = homeCategoryModel.name;
        [cell.imageView sd_setImageWithURL:homeCategoryModel.iconUrl placeholderImage:[UIImage imageNamed:@"default_loading_icon"]];
        return cell;

    }else{
        
        DPRushPurchaseCellCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RushreuseIdentifier forIndexPath:indexPath];
         DPDeal *deal = self.rushPurchaseDeals[indexPath.item];
        cell.currentPriceLabel.text = [NSString stringWithFormat:@"%ld",deal.current_price.integerValue / 100];
        cell.marketPriceLabel.text = [NSString stringWithFormat:@"%ld",deal.market_price.integerValue / 100];
        cell.shopNameLabel.text = deal.title;
        cell.shopNameLabel.font = [UIFont systemFontOfSize:10];
        
        cell.iconView.layer.cornerRadius = 3;
        cell.iconView.layer.masksToBounds = YES;
        
        [cell.iconView sd_setImageWithURL:deal.tiny_image placeholderImage:[UIImage imageNamed:@"default_loading_bigicon"]];
        return cell;
        
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if([collectionView isEqual:self.collectionView]){
        
        DPHomeCategoryModel *homeCategoryModel = self.homeCategoryModels[indexPath.item];
        if ([self.delegate respondsToSelector:@selector(homeHeaderView:didSelectCatID:orSubCatID:)]) {
            [self.delegate homeHeaderView:self didSelectCatID:homeCategoryModel.cat_id orSubCatID:homeCategoryModel.subcat_id];
        }

    }
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if([collectionView isEqual:self.collectionView]){
         return CGSizeMake(DPScreenWidth / rowCount, DPScreenWidth / rowCount);
    }
    
    return CGSizeMake(DPScreenWidth / 3, DPScreenWidth / 3 + 10);
    
   
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    self.pageControl.currentPage =  (int) (scrollView.contentOffset.x/scrollView.bounds.size.width + 0.5)% (self.homeCategoryModels.count);
}
@end
