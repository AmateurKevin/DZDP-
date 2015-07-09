//
//  DPFilterHeaderView.h
//  DZDP
//
//  Created by nickchen on 15/7/3.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DPFilterHeaderView : UICollectionReusableView

+ (instancetype)filterHeaderView;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@end
