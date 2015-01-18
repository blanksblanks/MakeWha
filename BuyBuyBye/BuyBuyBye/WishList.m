//
//  WishList.m
//  BuyBuyBye
//
//  Created by Nina Baculinao on 1/17/15.
//  Copyright (c) 2015 JohnnyChen. All rights reserved.
//

#import "WishList.h"

#pragma mark * Private interface


@interface WishList() <MSFilter>

@property (nonatomic, strong)   MSTable *table;
@property (nonatomic)           NSInteger busyCount;

@end

static NSString *const LIST_ARRAY = @"ListArray";

#pragma mark * Private interface

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
        // Initialize the Mobile Service client with your URL and key

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

    // Insert item into backend
    MSClient *client = [(AppDelegate *) [[UIApplication sharedApplication] delegate] client];
    self.table = [client tableWithName:@"WishListItem"];
    NSDictionary *object = @{ @"name" : item.name};
    [self.table insert:object completion:^(NSDictionary *insObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"Item inserted, id: %@", [insObject objectForKey:@"id"]);
        }
    }];
    
    // Insert item into internal phone data
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
    NSString *target = [NSString stringWithFormat:@"%@",item.name];
    NSLog(@"%@", item.name);
    id itemToDelete = nil;
    for (Item *entry in _list) {
        if ([entry.name isEqualToString:target]) {
            itemToDelete = entry;
        }
    }
    [_list removeObject:itemToDelete];
    NSLog(@"deleting stuff");
    // Must do this for all custom objects that don't fit property list
    NSData *savedData = [NSKeyedArchiver archivedDataWithRootObject:_list];
    // Update LIST_ARRAY with newest _list
    [[NSUserDefaults standardUserDefaults]setObject:savedData forKey:LIST_ARRAY];
    [[NSUserDefaults standardUserDefaults]synchronize];

    for (Item *item in _list){
        NSLog(@"%@", item.name);
        NSLog(@"%@", item.time);
    }
    
    int size = (int) [_list count];
    NSLog(@"there are %d objects in the array", size);
}

- (UIImage *)getImage:(double)index {
    int idx = 0;
    UIImage *img;
    for (Item *entry in _list) {
        if (idx == index) {
            img = entry.image;
        }
    }
    return img;
}

- (NSMutableArray *)list {
    return _list;
}

- (NSMutableArray*)getList{
    return _list;
}

@end
