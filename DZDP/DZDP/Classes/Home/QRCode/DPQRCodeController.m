//
//  DPQRCodeController.m
//  DZDP
//
//  Created by nickchen on 15/10/10.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPQRCodeController.h"
#import <AVFoundation/AVFoundation.h>
#import "DPWebViewController.h"
@interface DPQRCodeController ()<AVCaptureMetadataOutputObjectsDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanLineTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerHeight;

@property(nonatomic,strong) AVCaptureSession *captureSession;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic) BOOL lastResult;

// 边框涂层
@property(nonatomic,strong) CALayer *drawLayer;
@property(nonatomic,strong) AVCaptureMetadataOutput *output;

@property(nonatomic,strong) AVCaptureDeviceInput *inputDevice;


@end

@implementation DPQRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"扫一扫";
    
    [self initaptureSession];
    // 预览图层
    [self initVideoPreviewLayer];
    
    [self initOutput];
    
    [self initInputDevice];
}

- (void)initaptureSession{
    
    // 创建会话
    _captureSession = [[AVCaptureSession alloc] init];
  
}

- (void)initOutput{
    _output = [[AVCaptureMetadataOutput alloc] init];
}

- (void)initInputDevice{

    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error = nil;
    
    _inputDevice = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if (error){
        DPLog(@"模拟器没有摄像头");
    }
}

- (void)initVideoPreviewLayer{
    
    // 创建输出对象
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    // 填充模式
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    //设置frame
    [_videoPreviewLayer setFrame:self.view.frame];
    
    _drawLayer = [CALayer layer];
    _drawLayer.frame = self.view.frame;
}

+ (instancetype)QRCodeController{
    
    UIStoryboard *stroryBoard = [UIStoryboard storyboardWithName:@"DPQRCodeController" bundle:nil];
    return [stroryBoard instantiateInitialViewController];

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
     self.view.backgroundColor = [UIColor clearColor];
    [self startAnimate];
    [self startScan];
}

- (void)startAnimate{
    
    //self.scanLineTop.constant =  -(_containerHeight.constant);
    [self.view layoutIfNeeded];
    
    [UIView animateWithDuration:3.0 delay:0 options:UIViewAnimationOptionAutoreverse animations:^{
        
        [UIView setAnimationRepeatCount:MAXFLOAT];
        _scanLineTop.constant = _containerHeight.constant - 5;
        [self.view layoutIfNeeded];
        
    } completion:nil];
    
  
}

- (void)startScan{
 
    if (![_captureSession canAddInput:_inputDevice])return;
    
    if (![_captureSession canAddOutput:_output])return;
    
    [_captureSession addInput:_inputDevice];
    [_captureSession addOutput:_output];
    
    _output.metadataObjectTypes = _output.availableMetadataObjectTypes;
    
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    [self.view.layer insertSublayer:_videoPreviewLayer atIndex:0];
    [_videoPreviewLayer addSublayer:_drawLayer];
    
    [_captureSession startRunning];
}

-(void)stopReading{
    [_captureSession stopRunning];
    _captureSession = nil;
    [_videoPreviewLayer removeFromSuperlayer];
}

#pragma mark -- AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        [self stopReading];
        NSURL *url = [NSURL URLWithString:metadataObj.stringValue];
        if (url) {
            
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"是否打开此链接" message:metadataObj.stringValue preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            UIAlertAction *sureAction =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                DPWebViewController *vc = [[DPWebViewController alloc] init];
                vc.url = url;
                [self.navigationController pushViewController:vc animated:YES];
                
            }];
            [ac addAction:cancelAction];
            [ac addAction:sureAction];
            [self presentViewController:ac animated:YES completion:nil];

            return;
        }
        
      
    }
    
    
    // 0.移除边线
    [self clearDrawLayer];
    
    // 1.绘制路径
    for (id object in metadataObjects) {
        
        if ([object isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
            
          AVMetadataMachineReadableCodeObject *codeObject =  (AVMetadataMachineReadableCodeObject *)[_videoPreviewLayer transformedMetadataObjectForMetadataObject:object];
            
            [self drawCorners:codeObject];
          

        }
  
        
    }
  

}

- (void)clearDrawLayer{
    
    // 1.判断是否有边线
    if (_drawLayer.sublayers.count == 0 || _drawLayer.sublayers == nil) {
        return;
    }
    
    // 2.移除所有边线
    for (CALayer *layer in  _drawLayer.sublayers) {
        [layer removeFromSuperlayer];
    }
}


- (void)drawCorners:(AVMetadataMachineReadableCodeObject*)codeObject{
    
    // 1.判断数组是否为空
    if (codeObject.corners.count <= 0) return;
    
    // 2.创建图层
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = 4;
    layer.strokeColor = [UIColor greenColor].CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    
    // 3.绘制图形
    layer.path = [self cornersPath:codeObject.corners];
    
    // 4.添加图层
    [_drawLayer addSublayer:layer];
}



- (CGPathRef)cornersPath:(NSArray *)corners
{
    // 3.1创建路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint point = CGPointZero;
    // 3.2移动到第一个点
    int index = 0;
    
    // 取出第0个点

    
    CGPointMakeWithDictionaryRepresentation( (__bridge CFDictionaryRef)corners[index], &point);
    [path moveToPoint:point];
    
    // 3.3设置其它点
    while (index < corners.count)
    {
        CGPointMakeWithDictionaryRepresentation( (__bridge CFDictionaryRef)corners[index++], &point);
        
        [path addLineToPoint:point];
    }
    // 3.4关闭路径
    [path closePath];
    return path.CGPath;
}

@end
