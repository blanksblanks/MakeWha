//
//  WishList.m
//  BuyBuyBye
//
//  Created by Nina Baculinao on 1/17/15.
//  Copyright (c) 2015 JohnnyChen. All rights reserved.
//

#import "WishList.h"
#import "Item.h"

static NSString *const LIST_ARRAY = @"ListArray";
static NSInteger CART_LIMIT = 5;

@implementation WishList

+(id) sharedHelper {
    static WishList *sharedHelper = nil;
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{sharedHelper = [[self alloc] init];});
    return sharedHelper;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        if (![[NSUserDefaults standardUserDefaults]objectForKey:LIST_ARRAY]) {
            self.list = [NSMutableArray array];
            for (int i = 0; i < CART_LIMIT; i++) {
                Item *newItem = [[Item alloc] init];
                if (newItem) {
                    newItem.name = @"";
                    newItem.time = INFINITY;
                }
                [self.list addObject: newItem];
            }
            [[NSUserDefaults standardUserDefaults]setObject:self.list forKey:LIST_ARRAY];
        }
        else {
            self.list = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]arrayForKey: LIST_ARRAY]];
        }
    }
    return self;
}

- (void)addItem:(Item*) item {
    for (int i = 0; i < CART_LIMIT; i++) {
        NSNumber *num=[NSNumber numberWithInteger:i];
        Item *newItem = [[Item alloc] init];
        if (newItem) {
            newItem = [self.list objectAtIndex:num];
            if (newItem.time != INFINITY) {
                continue;
            }
            else {
                [self.list addObject:[[Item alloc] init]];
                [[NSUserDefaults standardUserDefaults]setObject:self.list forKey:LIST_ARRAY];
                [[NSUserDefaults standardUserDefaults]synchronize];
                break;
            }
        }
    }
    
    NSLog(@"%@", self.list);
}

@end
