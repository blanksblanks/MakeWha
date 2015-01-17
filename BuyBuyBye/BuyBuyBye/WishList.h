//
//  WishList.h
//  BuyBuyBye
//
//  Created by Nina Baculinao on 1/17/15.
//  Copyright (c) 2015 JohnnyChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"


@interface WishList : NSObject

/**
 * Always access class through this singleton
 * Call it once on application start
 */

+(id) sharedHelper;

@property (strong, nonatomic, readonly) NSArray *list;

- (void)addItem:(Item *) item;

@end
