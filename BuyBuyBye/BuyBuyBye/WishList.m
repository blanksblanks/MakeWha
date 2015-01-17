//
//  WishList.m
//  BuyBuyBye
//
//  Created by Nina Baculinao on 1/17/15.
//  Copyright (c) 2015 JohnnyChen. All rights reserved.
//

#import "WishList.h"

static NSString *const LIST_ARRAY = @"ListArray";
//static NSInteger CART_LIMIT = 5;

@implementation WishList {
    NSMutableArray *_list;
}

+(id) sharedHelper {
    static WishList *sharedHelper = nil;
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{sharedHelper = [[self alloc] init];});
    return sharedHelper;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        if (![[NSUserDefaults standardUserDefaults]arrayForKey:LIST_ARRAY]) {
            _list = [[NSMutableArray alloc] init];
            NSLog(@"NEW ARRAY");
            
        }
        else {
            _list = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]arrayForKey: LIST_ARRAY]];
            NSLog(@"USE PREVIOUS");
        }
//        else {
//            self.list = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults]arrayForKey: LIST_ARRAY]];
//        }
    }
   
    return self;
}

- (void)addItem:(Item *) item {
   /* if (_list == nil) {
        _list = [NSMutableArray array];
        // Loads the LIST_ARRAY (user default value retained) into _list
        [[NSUserDefaults standardUserDefaults]setObject:_list forKey:LIST_ARRAY];
    }*/
    [_list addObject:item];
    // Updates LIST_ARRAY with newest _list
    [[NSUserDefaults standardUserDefaults]synchronize];
//    for (int i = 0; i < CART_LIMIT; i++) {
//        NSNumber *num=[NSNumber numberWithInteger:i];
//        Item *newItem = [[Item alloc] init];
//        if (newItem) {
//            newItem = [self.list objectAtIndex:num];
//            if (newItem.time != INFINITY) {
//                continue;
//            }
//            else {
//                [self.list addObject:[[Item alloc] init]];
//                [[NSUserDefaults standardUserDefaults]setObject:self.list forKey:LIST_ARRAY];
//                [[NSUserDefaults standardUserDefaults]synchronize];
//                break;
//            }
//        }
//    }
    NSLog(@"%@", _list);
    for (Item *item in _list){
        NSLog(@"%@", item.name);
        NSLog(@"%f", item.time);
    }
}

- (NSArray *)list {
    return _list;
}

@end
