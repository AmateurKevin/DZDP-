//
//  DPCategoryMenuController.m
//  DZDP
//
//  Created by nickchen on 15/7/3.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPCategoryMenuController.h"
#import "DPMetaDataTool.h"
#import "DPCategory.h"
#import "DPCategroryMenuCell.h"
#import "DPFilterHeaderView.h"
#import "DPDealMainController.h"
#import "DPSubCategory.h"
@interface DPCategoryMenuController ()
@property(nonatomic,strong) NSArray *categoryArray;

/**
 *  每组的cell数量
 */
//@property(nonatomic,strong) NSArray *cellCountPerSection;

/**
 *  每组的cell数据
 */
@property(nonatomic,strong) NSMutableArray *cellDataPerSection;

@end

@implementation DPCategoryMenuController
static NSString * const reuseIdentifier = @"Cell";
static NSString * const kHeaderViewCellIdentifier = @"HeaderViewCellIdentifier";
- (instancetype)init{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection =  UICollectionViewScrollDirectionVertical;
    
    layout.itemSize = CGSizeMake(DPScreenWidth / 3, DPScreenWidth / 3 *0.4);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.headerReferenceSize = CGSizeMake(DPScreenWidth, 44);
    return [super initWithCollectionViewLayout:layout];
}


- (NSArray *)categoryArray
{
    if (_categoryArray == nil) {
        _categoryArray = [DPMetaDataTool categories];
    }
    return _categoryArray;
}

- (NSMutableArray *)cellDataPerSection
{
    if (_cellDataPerSection == nil) {
        _cellDataPerSection = @[].mutableCopy;
        for (DPCategory *catetory in self.categoryArray) {
            
            
            if (catetory.subcategories.count <= 9 && catetory.subcategories.count > 0) {
                [_cellDataPerSection addObject:catetory.subcategories];
            }else if(catetory.subcategories.count > 9){
                NSArray *arr = [catetory.subcategories objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 8)]];
                arr = [arr arrayByAddingObject:@"更多"];
                [_cellDataPerSection addObject:arr];
            }else {
                [_cellDataPerSection addObject:@[]];
            }
        }
    }
    return _cellDataPerSection;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:[DPCategroryMenuCell class] forCellWithReuseIdentifier:reuseIdentifier];
  
    [self.collectionView registerNib:[UINib nibWithNibName:@"DPFilterHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewCellIdentifier];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.categoryArray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *perSection = self.cellDataPerSection[section];
    return perSection.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DPCategroryMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    //DPCategory *category = self.categoryArray[indexPath.section];
    //cell.categoryName = category.subcategories[indexPath.item];
    NSArray *perSection = self.cellDataPerSection[indexPath.section];
    
    if ([perSection[indexPath.row] isKindOfClass:[NSString class]]) {
        [cell.Label setTextColor:[UIColor redColor]];
        cell.Label.text = perSection[indexPath.row];
    }else{
        [cell.Label setTextColor:[UIColor blackColor]];
        cell.Label.text = [perSection[indexPath.row] subcat_name];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqual: UICollectionElementKindSectionHeader]) {
        DPFilterHeaderView *filterHeaderView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewCellIdentifier forIndexPath:indexPath];
        if (filterHeaderView == nil) {
            filterHeaderView = [DPFilterHeaderView filterHeaderView];
        }
        DPCategory *category = self.categoryArray[indexPath.section];
        
       
        filterHeaderView.categoryLabel.text = category.cat_name;
        return filterHeaderView;
    }
    return nil;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DPCategroryMenuCell *cell = (DPCategroryMenuCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([cell.Label.text isEqualToString:@"更多"]) {
        DPCategory *category = self.categoryArray[indexPath.section];
      
        NSMutableArray *mutaArray = [NSMutableArray arrayWithArray:category.subcategories];
        if (mutaArray.count % 3 == 0) {
            [mutaArray addObjectsFromArray:@[@"",@"",@"收起"]];
        }
        if (mutaArray.count % 3 == 1) {
            [mutaArray addObjectsFromArray:@[@"",@"收起"]];
        }
        if (mutaArray.count % 3 == 2) {
            [mutaArray addObjectsFromArray:@[@"收起"]];
        }
        [self.cellDataPerSection replaceObjectAtIndex:indexPath.section withObject:mutaArray];
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    }else if([cell.Label.text isEqualToString:@"收起"]) {
        NSArray *perSection = self.cellDataPerSection[indexPath.section];
        NSArray *arr = [perSection objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 8)]];
        arr = [arr arrayByAddingObject:@"更多"];
        [self.cellDataPerSection replaceObjectAtIndex:indexPath.section withObject:arr];
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    }else{
        DPDealMainController *vc = [[DPDealMainController alloc] init];
        vc.shopsParam.city_id = UserDefaultCityID;
        NSArray *perSection = self.cellDataPerSection[indexPath.section];
        vc.shopsParam.subcat_ids = [[perSection[indexPath.item] subcat_id] description];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
