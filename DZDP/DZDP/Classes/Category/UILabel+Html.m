//
//  UILabel+Html.m
//  DZDP
//
//  Created by nickchen on 15/10/4.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "UILabel+Html.h"

@implementation UILabel (Html)
- (void) setHtml: (NSString*) html
{
    NSError *err = nil;
    
    NSMutableAttributedString *text =  [[NSMutableAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    if(err)
        NSLog(@"Unable to parse label text: %@", err);
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.headIndent = 20;//缩进
   // style.firstLineHeadIndent = 0;
    style.lineSpacing = 10;//行距
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    
    self.attributedText = text;
  
}
@end
