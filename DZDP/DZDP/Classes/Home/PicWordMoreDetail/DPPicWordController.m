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
#import "GRMustache.h"

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

    NSDictionary *renderObject = @{@"contents":_detailDeal.buy_details,
                                   @"description":_detailDeal.shop_description};
  
    NSString *rendering = [GRMustacheTemplate renderObject:renderObject fromResource:@"picword" bundle:nil error:NULL];
    
    NSMutableString *html = [NSMutableString stringWithString:rendering];
    
     [html replaceOccurrencesOfString:@"img src" withString:@"img esrc" options:NSLiteralSearch range:NSMakeRange(0, html.length)];
    
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
