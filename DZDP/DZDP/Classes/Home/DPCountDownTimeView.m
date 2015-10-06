//
//  DPCountDownTimeLabel.m
//  DZDP
//
//  Created by nickchen on 15/10/3.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPCountDownTimeView.h"
#import "NSTimer+NKHelper.h"
#import "NSDate+DateTools.h"

@interface DPCountDownTimeView()

@property (weak, nonatomic) IBOutlet UILabel *hourLabel;
@property (weak, nonatomic) IBOutlet UILabel *minLabel;

@property (weak, nonatomic) IBOutlet UILabel *secLabel;

@end
@implementation DPCountDownTimeView

+ (instancetype)countDownTimeLabel{
    return [[[NSBundle mainBundle] loadNibNamed:@"DPCountDownTimeView" owner:nil options:nil] lastObject];
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    [NSTimer NK_scheduledTimerWithTimeInterval:1 block:^{
    
        NSInteger hour = [[NSDate date] hour];
        NSInteger min = [[NSDate date] minute];
        NSInteger sec = [[NSDate date] second];
        
        NSInteger showHour = 0;
         NSInteger showMin = 0;
         NSInteger showSec = 0;
        if (hour < 8) {
            showHour = 7 - hour;
            showMin = 59 - min;
            showSec = 60 - sec;
   
        } else if (hour > 17) {
            showHour = 33 - hour;
            showMin = 59 - min;
            showSec = 60 - sec;
        }else{
            showHour = 16 - hour;
            showMin = 59 - min;
            showSec = 60 - sec;

        }

        [self showHour:showHour andMin:showMin andSec:showSec];

        
    } repeats:YES];
}

- (void)showHour:(NSInteger)showHour andMin:(NSInteger)showMin andSec:(NSInteger)showSec{
    
    
    if (showHour >= 10) {
        self.hourLabel.text = [NSString stringWithFormat:@"%ld",showHour] ;
    }else{
        self.hourLabel.text = [NSString stringWithFormat:@"0%ld",showHour] ;
    }
    
    
    if (showMin >= 10) {
        self.minLabel.text = [NSString stringWithFormat:@"%ld",showMin] ;
    }else{
        self.minLabel.text = [NSString stringWithFormat:@"0%ld",showMin] ;
    }
    
    if (showSec >= 10) {
        self.secLabel.text = [NSString stringWithFormat:@"%ld",showSec] ;
    }else{
        self.secLabel.text = [NSString stringWithFormat:@"0%ld",showSec] ;
    }
}

@end
