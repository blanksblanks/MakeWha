//
//  WishList.h
//  BuyBuyBye
//
//  Created by Nina Baculinao on 1/17/15.
//  Copyright (c) 2015 JohnnyChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import "Item.h"
#import "AppDelegate.h"

@interface WishList : NSObject

/**
 * Always access class through this singleton
 * Call it once on application start
 */

// we dont use this
@property (nonatomic, strong) NSMutableArray *list;

+(id) sharedHelper;

- (NSMutableArray*)getList;
- (void)addItem:(Item *) item;
- (void)deleteItem:(Item *) item;

@end
