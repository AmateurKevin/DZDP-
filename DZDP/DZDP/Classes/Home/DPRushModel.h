//
//  DPRushModel.h
//  DZDP
//
//  Created by nickchen on 15/9/29.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "MTLModel.h"

@interface DPRushModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy) NSString *name;

@property(nonatomic,strong) NSURL *iconUrl;

+ (NSArray *)RushModelFromJsonFile;
@end
