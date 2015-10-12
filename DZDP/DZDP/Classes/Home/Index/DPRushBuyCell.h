//
//  DPRushBuyCell.h
//  DZDP
//
//  Created by nickchen on 15/10/11.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPRushSubView;
@interface DPRushBuyCell : UITableViewCell

@property(nonatomic,strong) NSArray *rushModels;


@property (weak, nonatomic) IBOutlet UIView *countDownView;

@end
