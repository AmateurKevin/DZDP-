//
//  DPCaptureHelper.h
//  DZDP
//
//  Created by nickchen on 15/10/17.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^DidOutputSampleBufferBlock)(CMSampleBufferRef sampleBuffer);
@interface DPCaptureHelper : NSObject <AVCaptureVideoDataOutputSampleBufferDelegate>

- (void)setDidOutputSampleBufferHandle:(DidOutputSampleBufferBlock)didOutputSampleBuffer;

- (void)showCaptureOnView:(UIView *)preview;

@end
