//
//  DPHomeHeaderModel.h
//  DZDP
//
//  Created by nickchen on 15/9/29.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "MTLModel.h"

@interface DPHomeCategoryModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy) NSNumber *cat_id;

@property (nonatomic,copy) NSNumber *subcat_id;

@property(nonatomic,strong) NSURL *iconUrl;

@property (nonatomic,copy) NSString *name;

+ (NSArray *)HomeCategoryModelFromJsonFile;

@end
