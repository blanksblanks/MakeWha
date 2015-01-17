//
//  WishList.m
//  BuyBuyBye
//
//  Created by Nina Baculinao on 1/17/15.
//  Copyright (c) 2015 JohnnyChen. All rights reserved.
//

#import "WishList.h"

static NSString *const LIST_ARRAY = @"ListArray";

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
        
        // Temporary testing: store data in mobile service
//        MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
//        NSDictionary *item = @{ @"text" : @"Awesome item" };
//        MSTable *itemTable = [client tableWithName:@"Item"];
//        [itemTable insert:item completion:^(NSDictionary *insertedItem, NSError *error) {
//            if (error) {
//                NSLog(@"Error: %@", error);
//            } else {
//                NSLog(@"Item inserted, id: %@", [insertedItem objectForKey:@"id"]);
//            }
//        }];
        
        if (![[NSUserDefaults standardUserDefaults]dataForKey:LIST_ARRAY]) {
            _list = [[NSMutableArray alloc] init];
            NSLog(@"NEW ARRAY");
            [[NSUserDefaults standardUserDefaults]setObject:_list forKey:LIST_ARRAY];
        }
        else {
            NSData *savedData = [[NSUserDefaults standardUserDefaults]dataForKey:LIST_ARRAY];
            _list = [NSKeyedUnarchiver unarchiveObjectWithData:savedData];
            NSLog(@"USE PREVIOUS");
            
            int size = (int) [_list count];
            NSLog(@"there are %d objects in the array", size);
        }
    }
   
    return self;
}

// Schedule a notification to appear once the expiration time has been reached
- (void)addItem:(Item *) item {

    // Insert item into Azure client
//    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
//    NSDictionary *object = @{ @"text" : item.name};
//    MSTable *objectTable = [client tableWithName:@"Object"];
//    [objectTable insert:object completion:^(NSDictionary *insObject, NSError *error) {
//        if (error) {
//            NSLog(@"Error: %@", error);
//        } else {
//            NSLog(@"Item inserted, id: %@", [insObject objectForKey:@"id"]);
//        }
//    }];
    
    // Insert item into internal data
    [_list addObject:item];
    // Must do this for all custom objects that don't fit property list
    NSData *savedData = [NSKeyedArchiver archivedDataWithRootObject:_list];
    // Update LIST_ARRAY with newest _list
    [[NSUserDefaults standardUserDefaults]setObject:savedData forKey:LIST_ARRAY];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    // Log complete contents of list after new addition
    NSLog(@"%@", _list);
    for (Item *item in _list){
        NSLog(@"%@", item.name);
        NSLog(@"%@", item.time);
    }
    int size = (int) [_list count];
    NSLog(@"there are %d objects in the array", size);
    
}


- (void)deleteItem:(Item *) item {
    //TODO: find the SPECIFIC item you must delete
    NSString *target = [NSString stringWithFormat:@"%@",item];
    for (Item *entry in _list) {
        if ([entry.name isEqualToString:target]) {
            [_list removeObject:entry];
        }
    }
    // Must do this for all custom objects that don't fit property list
    NSData *savedData = [NSKeyedArchiver archivedDataWithRootObject:_list];
    // Update LIST_ARRAY with newest _list
    [[NSUserDefaults standardUserDefaults]setObject:savedData forKey:LIST_ARRAY];
    [[NSUserDefaults standardUserDefaults]synchronize];

    for (Item *item in _list){
        NSLog(@"%@", item.name);
        NSLog(@"%@", item.time);
    }
    
    int size = [_list count];
    NSLog(@"there are %d objects in the array", size);
}

- (NSMutableArray *)list {
    return _list;
}


- (NSMutableArray*)getList{
    return _list;
}

@end
