//
//  DPSearchWordController.h
//  DZDP
//
//  Created by nickchen on 15/10/9.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DPKeyWordSearchResultControllerDelegate <NSObject>

@optional
- (void)KeyWordSearchResultControllerGetWord:(NSString *)keyword;

@end

@interface DPKeyWordSearchResultController : UITableViewController

@property(nonatomic,strong) NSArray *filteredWords;

@property(nonatomic,weak) id<DPKeyWordSearchResultControllerDelegate> delegate;

@end
