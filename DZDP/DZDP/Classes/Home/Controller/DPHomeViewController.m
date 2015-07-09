//
//  DPHomeViewController.m
//  DZDP
//
//  Created by nickchen on 15/6/27.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPHomeViewController.h"
#import "DPSortCityController.h"


@interface DPHomeViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)ChooseCityClicked:(id)sender;

@end

@implementation DPHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)ChooseCityClicked:(id)sender {
    UIStoryboard *stroryBoard = [UIStoryboard storyboardWithName:@"ChooseCity" bundle:nil];
    DPSortCityController *sortCityVc = [stroryBoard instantiateInitialViewController];
    [self presentViewController:sortCityVc animated:YES completion:nil];
}
@end
