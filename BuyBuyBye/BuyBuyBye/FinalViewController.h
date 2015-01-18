//
//  FinalViewController.h
//  BuyBuyBye
//
//  Created by manojGURUNG on 1/17/15.
//  Copyright (c) 2015 JohnnyChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewController.h"
#import "Item.h"

@interface FinalViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *ItemName;
@property (strong, nonatomic) IBOutlet UILabel *Price;

@property (strong, nonatomic) Item* tempItem;

@end
