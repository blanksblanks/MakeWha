//
//  WishList.m
//  BuyBuyBye
//
//  Created by Nina Baculinao on 1/17/15.
//  Copyright (c) 2015 JohnnyChen. All rights reserved.
//

#import "WishList.h"

@implementation WishList {
    // TODO: Declare aray here
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
        // TODO: Initialize array here
    }
    return self;
}


@end
