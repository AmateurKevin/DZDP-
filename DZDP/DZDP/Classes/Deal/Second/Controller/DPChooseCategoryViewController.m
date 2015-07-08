//
//  DPChooseCategoryViewController.m
//  DZDP
//
//  Created by nickchen on 15/7/6.
//  Copyright (c) 2015年 nickchen. All rights reserved.
//

#import "DPChooseCategoryViewController.h"
#import "DPDropdownMenu.h"
#import "DPMetaDataTool.h"

@interface DPChooseCategoryViewController ()<DPDropdownMenuDelegate>

@property(nonatomic,weak) UIView *menu;

@end

@implementation DPChooseCategoryViewController

- (void)loadView
{
    DPDropdownMenu *menu = [DPDropdownMenu dropdownMenu];
    menu.delegate = self;
    menu.items = [DPMetaDataTool categories];
    self.view =menu;
    self.menu = menu;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
}

- (void)dropdownMenu:(DPDropdownMenu *)menu didSelectMain:(NSInteger)mainRow
{
    NSLog(@"%zd",mainRow);
}



- (void)dropdownMenu:(DPDropdownMenu *)menu didSelectSub:(NSInteger)subRow ofMainRow:(NSInteger)mainRow
{
    NSLog(@"%zd",subRow);
}

@end
