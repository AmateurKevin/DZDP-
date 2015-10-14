//
//  DPPicWordController.h
//  DZDP
//
//  Created by nickchen on 15/7/8.
//  Copyright (c) 2015年 https://github.com/nickqiao All rights reserved.
//

#import "DPPicWordController.h"
#import "DPDeal.h"
#import "WebViewJavascriptBridge.h"
#import <SDWebImage/SDWebImageManager.h>

@interface DPPicWordController ()<WebViewJavascriptBridgeBaseDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property(nonatomic,strong) NSString *html;

@property(nonatomic,weak) UISegmentedControl *segment;

@property WebViewJavascriptBridge *bridge;

@property(nonatomic,strong) NSMutableArray *allImagesOfThisArticle;


@end

@implementation DPPicWordController

+ (instancetype)picWordController{
    
    UIStoryboard *stroryBoard = [UIStoryboard storyboardWithName:@"DPPicWordController" bundle:nil];
    return [stroryBoard instantiateInitialViewController];
  
}

- (IBAction)valueChanged:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            [_bridge send:@"1" responseCallback:^(id responseData) {
                DPLog(@"哈哈");
            }];
            break;
            
        default:
            [_bridge send:@"2" responseCallback:^(id responseData) {
                DPLog(@"去看详情");
            }];
            break;
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self prepareHtml];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView  webViewDelegate:self handler:^(id data, WVJBResponseCallback responseCallback) {
        
        if ([data isKindOfClass:[NSArray class]]) {
            DPLog(@"是数组类型");
        }
        
        [self downloadAllImagesInNative:data];
        
    }];
    
    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        
    }];

    
    [self.webView loadHTMLString:_html baseURL:nil];

    
}

- (void)prepareHtml{
    
    NSMutableString *html = [[NSMutableString alloc] init];
   [html appendString:@"<!DOCTYPE html>"];
    [html appendString:@"<html>"];
    
    [html appendString:@"<head lang=\"en\">"];
    [html appendString:@" <meta charset='utf-8'><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no\">"];
    
    [html appendString:@"<style type=\"text/css\">"];
    [html appendString:@"img {clear: both;width: 100%;height:auto;display: block;}"];
    [html appendString:@"</style>"];
    
    
    [html appendString:@"<script type=\"text/javascript\">"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"picWord.js" ofType:nil];
    NSString *jsStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [html appendString:jsStr];
    
    [html appendString:@"</script>"];
    
    [html appendString:@"</head>"];
    
    [html appendString:@"<body onload=\"onLoaded()\">"];
    
    [html appendString:@"<h4 id = top>套餐内容</h4>"];
    [html appendString:@"<hr width=screen.width size=1 color=#DDDDDD align=center noshade>"];
    [html appendString:_detailDeal.buy_details];
    [html appendString:@"<hr width=screen.width size=1 color=#DDDDDD align=center noshade>"];
    [html appendString:@"<hr width=screen.width size=1 color=#DDDDDD align=center noshade  style=\"padding-top: 30px\">"];
    [html appendString:@"<h4 id = detail>商家详情</h4>"];
    [html appendString:@"<hr width=screen.width size=1 color=#DDDDDD align=center noshade>"];
    [html appendString:_detailDeal.shop_description];
    
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    
    [html replaceOccurrencesOfString:@"img src" withString:@"img esrc" options:NULL range:NSMakeRange(0, html.length)];
    
    _html = html;
    
}

#pragma mark -- 下载全部图片
-(void)downloadAllImagesInNative:(NSArray *)imageUrls{
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    
    DPLog(@"%lu",(unsigned long)imageUrls.count);
    //初始化一个置空元素数组
    _allImagesOfThisArticle = [NSMutableArray arrayWithCapacity:imageUrls.count];//本地的一个用于保存所有图片的数组
    for (NSUInteger i = 0; i < imageUrls.count; i++) {
        [_allImagesOfThisArticle addObject:[NSNull null]];
    }
    
    for (NSUInteger i = 0; i < imageUrls.count; i++) {
        NSString *_url = imageUrls[i];
        
        [manager downloadImageWithURL:[NSURL URLWithString:_url] options:SDWebImageHighPriority progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
            if (image) {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSString *imgB64 = [UIImageJPEGRepresentation(image, 1.0) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                    
                    //把图片在磁盘中的地址传回给JS
                    NSString *key = [manager cacheKeyForURL:imageURL];
                    
                    
                    NSString *source = [NSString stringWithFormat:@"data:image/png;base64,%@", imgB64];
                    [_bridge callHandler:@"imagesDownloadComplete" data:@[key,source]];
                    
                });
                
            }
            
        }];
        
    }
    
}

 @end
