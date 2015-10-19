//
//  DPNearLocationView.m
//  DZDP
//
//  Created by nickchen on 15/10/6.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPNearLocationView.h"
#import <INTULocationManager.h>
#import "DPGeocoderTool.h"
#import <CoreLocation/CoreLocation.h>
@interface DPNearLocationView()

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

static NSTimeInterval  const LocationTimeOut = 10;


@implementation DPNearLocationView

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    
    [self refreshLocation];
   
}

- (void)refreshLocation{
    [[INTULocationManager sharedInstance] requestLocationWithDesiredAccuracy:INTULocationAccuracyCity timeout:LocationTimeOut block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
        
        [DPGeocoderTool getCityFromLocation:currentLocation andExecuteBlock:^(DPCity *city, NSString *address,NSString *locationStr) {
            
            self.locationLabel.text = address;

            if ([self.delegate respondsToSelector:@selector(nearLocationViewRefreshLocation:With:)]) {

                [self.delegate nearLocationViewRefreshLocation:locationStr With:city];
            }

            
        }];
       
        
        
    }];
}

- (IBAction)refreshBtnClicked:(id)sender {
    
    self.locationLabel.text = @"正在定位中";
    [self refreshLocation];
}

+ (instancetype)nearLocationView{

    return [[[NSBundle mainBundle] loadNibNamed:@"DPNearLocationView" owner:nil options:nil] lastObject];
}

@end
