//
//  Item.m
//  BuyBuyBye
//
//  Created by Melanie Hsu on 1/17/15.
//  Copyright (c) 2015 JohnnyChen. All rights reserved.
//

#import "Item.h"

@implementation Item

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.time = [aDecoder decodeObjectForKey:@"time"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.time forKey:@"time"];
}

- (NSString*)getName{
    return self.name;
}

@end
