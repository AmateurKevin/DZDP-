//
//  DPCategory.h
//  DZDP
//
//  Created by nickchen on 15/9/27.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "MTLModel.h"

@interface DPCategory : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy) NSNumber *cat_id;
@property (nonatomic,copy) NSString *cat_name;
@property (nonatomic,strong) NSArray *subcategories;

@end
