//
//  DPHomeViewController.m
//  DZDP
//
//  Created by nickchen on 15/6/27.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPFoundController.h"
#import "DPSortCityController.h"


@interface DPFoundController ()

@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)ChooseCityClicked:(id)sender;

@end

@implementation DPFoundController

- (void)viewDidLoad {
    [super viewDidLoad];
    //NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
//    [[DPAPITool sharedAPITool] request:@"v1/metadata/get_regions_with_deals" params:nil success:^(NSDictionary *json) {
//        
//        NSString *fileName = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"regions.plist"];
//        [json[@"cities"] writeToFile:fileName atomically:NO];
//            } failure:^(NSError *error) {
//    }];
}

- (IBAction)ChooseCityClicked:(id)sender {
    UIStoryboard *stroryBoard = [UIStoryboard storyboardWithName:@"ChooseCity" bundle:nil];
    DPSortCityController *sortCityVc = [stroryBoard instantiateInitialViewController];
    [self presentViewController:sortCityVc animated:YES completion:nil];
    
}
@end
