//
//  NSTimer+NKHelper.m
//
//  Created by nickchen on 15/9/1.
//  Copyright (c) 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "NSTimer+NKHelper.h"

@implementation NSTimer (NKHelper)


+ (NSTimer*)NK_scheduledTimerWithTimeInterval:(NSTimeInterval)timerInterval block:(void(^)())inBlock repeats:(BOOL)inRepeats
{
    void (^block)() = [inBlock copy];
    NSTimer *timer = [self scheduledTimerWithTimeInterval:timerInterval target:self selector:@selector(NK_executeTimerBlock:) userInfo:block repeats:inRepeats];
    return timer;
}

+ (NSTimer *)NK_timerWithTimeInterval:(NSTimeInterval)timerInterval block:(void(^)())inBlock repeats:(BOOL)inRepeats
{
     void (^block)() = [inBlock copy];
    NSTimer *timer = [self timerWithTimeInterval:timerInterval target:self selector:@selector(NK_executeTimerBlock:) userInfo:block repeats:inRepeats];
    return timer;
}

+ (void)NK_executeTimerBlock:(NSTimer *)inTimer
{
    if ([inTimer userInfo]) {
        void(^block)() = (void(^)())[inTimer userInfo];
        block();
    }
}

@end
