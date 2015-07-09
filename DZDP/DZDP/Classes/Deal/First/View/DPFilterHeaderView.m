//
//  DPFilterHeaderView.m
//  DZDP
//
//  Created by nickchen on 15/7/3.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPFilterHeaderView.h"

@interface DPFilterHeaderView ()

- (IBAction)btnClicked:(id)sender;

@end

@implementation DPFilterHeaderView

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)filterHeaderView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DPFilterHeaderView" owner:nil options:nil] lastObject] ;
}

- (IBAction)btnClicked:(id)sender {
    NSLog(@"%s",__func__);
}
@end
