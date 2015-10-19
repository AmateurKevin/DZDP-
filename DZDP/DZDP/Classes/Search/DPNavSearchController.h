//
//  test.h
//  DZDP
//
//  Created by nickchen on 15/10/10.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DPNavSearchControllerDelegate <NSObject>

@optional
- (void)navSearchControllerGetkeyword:(NSString *)keyword;

@end

@interface DPNavSearchController : UINavigationController

@property(nonatomic,weak) id <DPNavSearchControllerDelegate> proxy;

+ (instancetype)sharedInstance;

/**
 *  设置搜索框的文字
 *
 *  @param text 将要设置的搜索文字
 */
- (void)setSearchBarText:(NSString *)text;

@end
