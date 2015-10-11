//
//  testTable.h
//  DZDP
//
//  Created by nickchen on 15/10/10.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DPKeyWordControllerDelegate <NSObject>

@optional

- (void)keyWordControllerSearchBtnClicked:(NSString *)keyWord;

- (void)keyWordControllerCancleBtnClicked;

@end


@interface DPKeyWordController : UITableViewController

@property(nonatomic,weak) id<DPKeyWordControllerDelegate> delegate;

// 搜索控制器
@property (nonatomic, strong) UISearchController *searchController;

@end
