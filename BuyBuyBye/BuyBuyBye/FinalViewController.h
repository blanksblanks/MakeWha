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
@property (weak, nonatomic) IBOutlet UIButton *websiteButton;
@property (weak, nonatomic) IBOutlet UIButton *exitButton;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;



@property (strong, nonatomic) Item* tempItem;

@end
