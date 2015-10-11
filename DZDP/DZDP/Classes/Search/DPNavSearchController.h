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

- (void)setSearchBarText:(NSString *)text;

@end
