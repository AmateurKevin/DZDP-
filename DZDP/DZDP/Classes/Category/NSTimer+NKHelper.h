//
//  NSTimer+NKHelper.h
//
//  Created by nickchen on 15/9/1.
//  Copyright (c) 2015年 https://github.com/nickqiao/. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSTimer (NKHelper)

+ (NSTimer*)NK_scheduledTimerWithTimeInterval:(NSTimeInterval)timerInterval block:(void(^)())inBlock repeats:(BOOL)inRepeats;

+ (NSTimer *)NK_timerWithTimeInterval:(NSTimeInterval)timerInterval block:(void(^)())inBlock repeats:(BOOL)inRepeats;

@end
