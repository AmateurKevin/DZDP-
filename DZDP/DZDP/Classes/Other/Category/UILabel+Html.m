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
    
    self.attributedText =  [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    if(err)
        NSLog(@"Unable to parse label text: %@", err);
  
}
@end
