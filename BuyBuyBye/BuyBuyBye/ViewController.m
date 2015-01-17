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
    float timeLeft = self.timeSlider.value; //value in hours
    
    /*we will be calculating the expiration times by checking the system time
     against the timer expiration time*/
    NSDate *currentTime = [self getSystemTime];
    NSTimeInterval secondsPerHour = 1; //set back to 3600 after demo
    NSDate *expirationTime = [currentTime dateByAddingTimeInterval:24*timeLeft*secondsPerHour];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    NSLog(@"Timer expires on %@",[dateFormatter stringFromDate:expirationTime]);
    
    UIAlertView *alert;
    
    if (![nameOfItemAdded isEqualToString:@""]){
        Item *newItem = [[Item alloc] init];
        if (newItem) {
            newItem.name = nameOfItemAdded;
            newItem.time = expirationTime;
            
            [[WishList sharedHelper] addItem:newItem];
        }
        
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        
        // Set the fire date/time
        [localNotification setFireDate:expirationTime];
        [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];
        
        localNotification.applicationIconBadgeNumber=1;
        
        // Setup alert notification
        [localNotification setAlertAction:@"The wait is over!"];
        [localNotification setAlertBody:[NSString stringWithFormat:@"Do you still want %@?", nameOfItemAdded]];
        
        localNotification.soundName=UILocalNotificationDefaultSoundName;
        [localNotification setHasAction:YES];
        UIApplication *app=[UIApplication sharedApplication];
        [app scheduleLocalNotification:localNotification];
        
        alert = [[UIAlertView alloc] initWithTitle:@"Update" message:[NSString stringWithFormat:@"You have added %@ to the list.",nameOfItemAdded] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
    else {
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter an item name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }
    [alert show];

}

- (NSDate *)getSystemTime {
    NSDate *now = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSLog(@"The Current Time is %@",[dateFormatter stringFromDate:now]);
    return now;
}

@end
