//
//  DPDropdownMenu.h
//  DZDP
//
//  Created by nickchen on 15/7/6.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import <UIKit/UIKit.h>
@class DPDropdownMenu;

@protocol DPDropdownMenuItemDelegate <NSObject>
@required
- (NSString *)title;
- (NSArray *)subTitles;
@end

@protocol DPDropdownMenuDelegate <NSObject>

@optional
- (void)dropdownMenu:(DPDropdownMenu *)menu didSelectMain:(NSInteger)mainRow;
- (void)dropdownMenu:(DPDropdownMenu *)menu didSelectSub:(NSInteger)subRow ofMainRow:(NSInteger)mainRow;
@end

@interface DPDropdownMenu : UIView

+ (instancetype)dropdownMenu;

@property(nonatomic,strong) NSArray *items;

@property(nonatomic,weak) id<DPDropdownMenuDelegate> delegate;

@end
