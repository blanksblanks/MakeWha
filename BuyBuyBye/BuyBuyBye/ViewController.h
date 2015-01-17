//
//  ViewController.h
//  BuyBuyBye
//
//  Created by Johnny Chen on 1/17/15.
//  Copyright (c) 2015 JohnnyChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UISlider *timeSlider;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

- (IBAction)timeSliderChanged:(UISlider *)sender;
- (IBAction)addItemButtonPressed:(UIButton *)sender;

- (IBAction)fakebutton:(UIButton *)sender;

@end

