//
//  Item.h
//  BuyBuyBye
//
//  Created by Melanie Hsu on 1/17/15.
//  Copyright (c) 2015 JohnnyChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject <NSCoding> /*NSKeyedArchiver serializes NSCoding-compliant classes to/from data representation*/

@property NSString *name;
@property NSDate *time;

@end
