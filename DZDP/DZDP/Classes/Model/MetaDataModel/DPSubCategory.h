//
//  DPSubCategory.h
//  DZDP
//
//  Created by nickchen on 15/9/27.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "MTLModel.h"

@interface DPSubCategory : MTLModel<MTLJSONSerializing>
@property (nonatomic,copy) NSNumber *subcat_id;
@property (nonatomic,copy) NSString *subcat_name;
@end
