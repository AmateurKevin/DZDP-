//
//  DPVoiceSearchController.m
//  DZDP
//
//  Created by nickchen on 15/10/9.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPVoiceSearchController.h"
#import "iflyMSC/IFlyMSC.h"
#import "IATConfig.h"
#import "ISRDataHelper.h"
#import "DPSearchResultsViewController.h"
@interface DPVoiceSearchController ()<IFlySpeechRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *speakLoudLabel;

@property (weak, nonatomic) IBOutlet UILabel *waitLabel;

@property (nonatomic, strong) NSString *pcmFilePath;//音频文件路径
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;//不带界面的识别对象

@property (nonatomic, strong) IFlyDataUploader *uploader;//数据上传对象
@property (nonatomic, strong) NSString * result;

@property (nonatomic, assign) BOOL isCanceled;


@end

@implementation DPVoiceSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.uploader = [[IFlyDataUploader alloc] init];
    
    //demo录音文件保存路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    _pcmFilePath = [[NSString alloc] initWithFormat:@"%@",[cachePath stringByAppendingPathComponent:@"asr.pcm"]];
    
    
    _result = [NSString string];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    self.waitLabel.hidden = YES;
    self.speakLoudLabel.hidden = NO;

}



+ (instancetype)sharedInstance{

    static DPVoiceSearchController * vc = nil;
    static dispatch_once_t predict;
    dispatch_once(&predict, ^{
        
        UIStoryboard *stroryBoard = [UIStoryboard storyboardWithName:@"VoiceSearch" bundle:nil];
        vc =  [stroryBoard instantiateInitialViewController];
        
    });

    return vc;

}

- (IBAction)dismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 按钮响应函数

/**
 启动听写
 *****/
- (IBAction)startBtnHandler:(id)sender {
    
    DPLog(@"%s[IN]",__func__);
    
    if ([IATConfig sharedInstance].haveView == NO) {//无界面
        
        //[_textView setText:@""];
        //[_textView resignFirstResponder];
        self.isCanceled = NO;
        
        if(_iFlySpeechRecognizer == nil)
        {
            [self initRecognizer];
        }
        
        [_iFlySpeechRecognizer cancel];
        
        //设置音频来源为麦克风
        [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        
        //设置听写结果格式为json
        [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
        
        //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
        [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        
        [_iFlySpeechRecognizer setDelegate:self];
        
        BOOL ret = [_iFlySpeechRecognizer startListening];
        
        if (ret) {
            //[_audioStreamBtn setEnabled:NO];
            //[_upWordListBtn setEnabled:NO];
            //[_upContactBtn setEnabled:NO];
        }else{
            //[_popUpView showText: @"启动识别服务失败，请稍后重试"];//可能是上次请求未结束，暂不支持多路并发
            DPLog(@"%@",@"启动识别服务失败，请稍后重试");
        }
    }else {
        
//        if(_iflyRecognizerView == nil)
//        {
//            [self initRecognizer ];
//        }
//        
//        //[_textView setText:@""];
//        //[_textView resignFirstResponder];
//        
//        //设置音频来源为麦克风
//        [_iflyRecognizerView setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
//        
//        //设置听写结果格式为json
//        [_iflyRecognizerView setParameter:@"plain" forKey:[IFlySpeechConstant RESULT_TYPE]];
//        
//        //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
//        [_iflyRecognizerView setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
//        
//        [_iflyRecognizerView start];
    }
    
}

/**
 设置识别参数
 ****/
-(void)initRecognizer
{
    DPLog(@"%s",__func__);
    
    if ([IATConfig sharedInstance].haveView == NO) {//无界面
        
        //单例模式，无UI的实例
        if (_iFlySpeechRecognizer == nil) {
            _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
            
            [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
            
            //设置听写模式
            [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        }
        _iFlySpeechRecognizer.delegate = self;
        
        if (_iFlySpeechRecognizer != nil) {
            IATConfig *instance = [IATConfig sharedInstance];
            
            //设置最长录音时间
            [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
            //设置后端点
            [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
            //设置前端点
            [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
            //网络等待时间
            [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
            
            //设置采样率，推荐使用16K
            [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
            
            if ([instance.language isEqualToString:[IATConfig chinese]]) {
                //设置语言
                [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
                //设置方言
                [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            }else if ([instance.language isEqualToString:[IATConfig english]]) {
                [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            }
            //设置是否返回标点符号
            [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
            
        }
    }else  {//有界面
        
        //单例模式，UI的实例
//        if (_iflyRecognizerView == nil) {
//            //UI显示剧中
//            _iflyRecognizerView= [[IFlyRecognizerView alloc] initWithCenter:self.view.center];
//            
//            [_iflyRecognizerView setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
//            
//            //设置听写模式
//            [_iflyRecognizerView setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
//            
//        }
//        _iflyRecognizerView.delegate = self;
//        
//        if (_iflyRecognizerView != nil) {
//            IATConfig *instance = [IATConfig sharedInstance];
//            //设置最长录音时间
//            [_iflyRecognizerView setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
//            //设置后端点
//            [_iflyRecognizerView setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
//            //设置前端点
//            [_iflyRecognizerView setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
//            //网络等待时间
//            [_iflyRecognizerView setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
//            
//            //设置采样率，推荐使用16K
//            [_iflyRecognizerView setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
//            if ([instance.language isEqualToString:[IATConfig chinese]]) {
//                //设置语言
//                [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
//                //设置方言
//                [_iflyRecognizerView setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
//            }else if ([instance.language isEqualToString:[IATConfig english]]) {
//                //设置语言
//                [_iflyRecognizerView setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
//            }
//            //设置是否返回标点符号
//            [_iflyRecognizerView setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
//            
//        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - IFlySpeechRecognizerDelegate

/**
 音量回调函数
 volume 0－30
 ****/
//- (void) onVolumeChanged: (int)volume
//{
//    if (self.isCanceled) {
//        [_popUpView removeFromSuperview];
//        return;
//    }
//    
//    NSString * vol = [NSString stringWithFormat:@"音量：%d",volume];
//    [_popUpView showText: vol];
//}



/**
 开始识别回调
 ****/
- (void) onBeginOfSpeech
{
    DPLog(@"onBeginOfSpeech");
    //[_popUpView showText: @"正在录音"];
}

/**
 停止录音回调
 ****/
- (void) onEndOfSpeech
{
    DPLog(@"onEndOfSpeech");
    
    //[_popUpView showText: @"停止录音"];
}


/**
 听写结束回调（注：无论听写是否正确都会回调）
 error.errorCode =
 0     听写正确
 other 听写出错
 ****/
- (void) onError:(IFlySpeechError *) error
{
    NSLog(@"%s",__func__);
    
    if ([IATConfig sharedInstance].haveView == NO ) {
        NSString *text ;
        
        if (self.isCanceled) {
            text = @"识别取消";
            
        } else if (error.errorCode == 0 ) {
            if (_result.length == 0) {
                text = @"无识别结果";
            }else {
                text = @"识别成功";
            }
            
            [self finish];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            DPSearchResultsViewController *vc =[[DPSearchResultsViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else {
            text = [NSString stringWithFormat:@"发生错误：%d %@", error.errorCode,error.errorDesc];
        }
        
        DPLog(@"%@",text);
        //[_popUpView showText: text];
        
    }else {
        DPLog(@"%@",@"识别结束");
        //[_popUpView showText:@"识别结束"];
        DPLog(@"errorCode:%d",[error errorCode]);
    }
    
}

/**
 无界面，听写结果回调
 results：听写结果
 isLast：表示最后一次
 ****/
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    
    if (isLast){
        
        DPLog(@"听写结果(json)：%@测试",  self.result);
        return;
    }

    NSString * resultFromJson =  [ISRDataHelper stringFromJson:resultString];
    _result = [NSString stringWithFormat:@"%@", resultFromJson];

}

/**
 *  返回语音识别结果后调用
 */
- (void) finish{
    
    
    if ([self.delegate respondsToSelector:@selector(voiceSearchControllerGetResult:)]) {
        
        [self.delegate voiceSearchControllerGetResult:_result];
        _result = nil;
    }
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
}


@end
