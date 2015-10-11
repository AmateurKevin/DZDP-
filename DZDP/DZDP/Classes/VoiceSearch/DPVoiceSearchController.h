//
//  DPVoiceSearchController.h
//  DZDP
//
//  Created by nickchen on 15/10/9.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DPVoiceSearchControllerDeletage <NSObject>
@optional
- (void)voiceSearchControllerGetResult:(NSString *)result;

@end


@interface DPVoiceSearchController : UIViewController

+ (instancetype)sharedInstance;

@property(nonatomic,weak) id<DPVoiceSearchControllerDeletage> delegate;

@end
