//
//  DPWebViewCell.h
//  DZDP
//
//  Created by nickchen on 15/10/4.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "DPDetailBaseCell.h"

@interface DPHtmlCell : DPDetailBaseCell
@property (weak, nonatomic) IBOutlet UILabel *htmlLabel;

+ (instancetype)htmlCell;

@end
