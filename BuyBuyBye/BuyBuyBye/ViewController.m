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
    self.timeLabel.text = [NSString stringWithFormat:@"%.0f Days",self.timeSlider.value];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)timeSliderChanged:(UISlider *)sender {
    float roundedSliderValue = lroundf(self.timeSlider.value);
    [self.timeSlider setValue:roundedSliderValue animated:YES];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%.0f Days",roundedSliderValue];
}

- (IBAction)addItemButtonPressed:(UIButton *)sender {
    NSString *nameOfItemAdded = self.textField.text;
    float timeLeft = self.timeSlider.value*86400;
    UIAlertView *alert;
    
    if (![nameOfItemAdded isEqualToString:@""]){
        Item *newItem = [[Item alloc] init];
        if (newItem) {
            newItem.name = nameOfItemAdded;
            newItem.time = timeLeft;
            
            [[WishList sharedHelper] addItem:newItem];
        }
        alert = [[UIAlertView alloc] initWithTitle:@"Update" message:[NSString stringWithFormat:@"You have added %@ to the list.",nameOfItemAdded] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
    else {
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter an item name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
    [alert show];

}

@end
