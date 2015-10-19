//
//  DPRushBuyModel.h
//  DZDP
//
//  Created by nickchen on 15/10/15.
//  Copyright © 2015年 https://github.com/nickqiao/. All rights reserved.
//

#import "MTLModel.h"

@interface DPRushBuyModel : MTLModel<MTLJSONSerializing>

/*
"deal_id": "4951836",
"brand": "久久丫",
"market_price": 20000,
"current_price": 14400,
"na_logo":
*/
@property (nonatomic,copy) NSNumber *deal_id;
@property (nonatomic,copy) NSString* brand;
@property (nonatomic,copy) NSNumber *market_price;
@property (nonatomic,copy) NSNumber *current_price;
@property (nonatomic,copy) NSString *na_logo;

@end
