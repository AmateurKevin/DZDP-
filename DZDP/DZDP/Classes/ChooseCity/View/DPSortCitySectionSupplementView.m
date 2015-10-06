//
//  DPSortCitySectionSupplementView.m
//  DZDP
//
//  Created by nickchen on 15/10/1.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPSortCitySectionSupplementView.h"

@implementation DPSortCitySectionSupplementView

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)SortCitySectionSupplementView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DPSortCitySectionSupplementView" owner:nil options:nil] lastObject] ;
}

@end
