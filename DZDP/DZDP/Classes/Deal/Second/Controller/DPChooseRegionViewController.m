//
//  DPChooseRegionViewController.m
//  DZDP
//
//  Created by nickchen on 15/7/6.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "DPChooseRegionViewController.h"
#import "DPDropdownMenu.h"
#import "DPMetaDataTool.h"
#import "DPCity.h"
@interface DPChooseRegionViewController ()<DPDropdownMenuDelegate>
@property(nonatomic,weak) UIView *menu;
@end

@implementation DPChooseRegionViewController

- (void)loadView
{
    DPDropdownMenu *menu = [DPDropdownMenu dropdownMenu];
    menu.delegate = self;
    DPCity *city = [DPMetaDataTool cityWithName:self.cityName];
    menu.items = city.regions;
    self.view = menu;
    self.menu = menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)dropdownMenu:(DPDropdownMenu *)menu didSelectMain:(NSInteger)mainRow
{
    
}

- (void)dropdownMenu:(DPDropdownMenu *)menu didSelectSub:(NSInteger)subRow ofMainRow:(NSInteger)mainRow
{
    
}

@end
