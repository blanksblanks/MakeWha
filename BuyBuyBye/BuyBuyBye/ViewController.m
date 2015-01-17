//
//  ViewController.m
//  BuyBuyBye
//
//  Created by Johnny Chen on 1/17/15.
//  Copyright (c) 2015 JohnnyChen. All rights reserved.
//

#import "ViewController.h"
#import "WishList.h"
#import "Item.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)timeSliderChanged:(UISlider *)sender {
    int roundedSliderValue = lroundf(self.timeSlider.value);
    [self.timeSlider setValue:roundedSliderValue animated:YES];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%i Days",roundedSliderValue];
}

- (IBAction)addItemButtonPressed:(UIButton *)sender {
    NSString *nameOfItemAdded = self.textField.text;
    UIAlertView *alert;
    
    if (![nameOfItemAdded isEqualToString:@""]){
        alert = [[UIAlertView alloc] initWithTitle:@"Update" message:[NSString stringWithFormat:@"You have added %@ to the list.",nameOfItemAdded] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
    else {
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter an item name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
    [alert show];

}

- (IBAction)fakebutton:(UIButton *)sender {
    Item *newItem = [[Item alloc] init];
    if (newItem) {
        newItem.name = @"Rubber Ducky";
        newItem.time = 48;
        
        [[WishList sharedHelper] addItem:newItem];
    }
}

@end
