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

@interface ViewController () {
    UIImagePickerController *_photoController;
}
@end

// showing melanie something.

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.timeLabel.text = [NSString stringWithFormat:@"%.0f Days",self.timeSlider.value];
    _img = [[UIImageView alloc]init];
    
    NSArray *buttons = [NSArray arrayWithObjects: self.addbutton, self.photobutton,nil];
    for(UIButton *btn in buttons)
    {
        // Set the button Text Color
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor brownColor] forState:UIControlStateHighlighted];
        
        
        // Draw a custom gradient
        CAGradientLayer *btnGradient = [CAGradientLayer layer];
        btnGradient.frame = btn.bounds;
        btnGradient.colors = [NSArray arrayWithObjects:
                              (id)[[UIColor colorWithRed:210.0f / 255.0f green:212.0f / 255.0f blue:220.0f / 210.0f alpha:1.0f] CGColor],
                              (id)[[UIColor colorWithRed:192.0f / 255.0f green:194.0 / 255.0f blue:206.0f / 255.0f alpha:1.0f] CGColor],
                              nil];
        [btn.layer insertSublayer:btnGradient atIndex:0];
        
        // Round button corners
        CALayer *btnLayer = [btn layer];
        [btnLayer setMasksToBounds:YES];
        [btnLayer setCornerRadius:8.0f];
    }
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
    
    _textField.delegate = self;
    _secondTextField.delegate = self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_textField resignFirstResponder];
    [_secondTextField resignFirstResponder];
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;
}

-(BOOL) secondTextFieldShouldReturn:(UITextField *)secondTextField{
    [secondTextField resignFirstResponder];
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)timeSliderChanged:(UISlider *)sender {
    float roundedSliderValue = lroundf(self.timeSlider.value);
    [self.timeSlider setValue:roundedSliderValue animated:YES];
    
    self.timeLabel.text = [NSString stringWithFormat:@"Number of Days: %.0f",roundedSliderValue];
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"SEGUE_CAMERA_PICTURE"]) {
//        UIImagePickerController *pickerController = segue.destinationViewController;
//        pickerController.delegate = self;
//        pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//        pickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
//        pickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
//        [self presentViewController:pickerController animated:YES completion:nil];
//    }
//}

- (IBAction)addPhotoButtonPressed:(id)sender {
    _photoController = [[UIImagePickerController alloc] init];
    _photoController.delegate = self;
    _photoController.sourceType = UIImagePickerControllerSourceTypeCamera;
    _photoController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    _photoController.allowsEditing = YES;
    _photoController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    [self presentViewController:_photoController animated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    [_photoController dismissViewControllerAnimated:NO completion:nil];
    
    //This is for the ALL ITEMS LIST
    _img.image = image;
    _img.contentMode = UIViewContentModeScaleAspectFill;
    _img.clipsToBounds = YES;
    
    //This is for the FIRST SCREEN
    //make sure nothing gets squished
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.image = image;
}

- (IBAction)addItemButtonPressed:(UIButton *)sender {
    NSString *nameOfItemAdded = self.textField.text;
    NSString *priceThatUserEntered = self.secondTextField.text;
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
    
    if([nameOfItemAdded isEqualToString:@""]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter an item name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    } else if ([priceThatUserEntered isEqualToString:@""]) {
        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter the price." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    } else {
        Item *newItem = [[Item alloc] init];
        if (newItem) {
            newItem.name = nameOfItemAdded;
            newItem.time = expirationTime;
            newItem.image = _img.image;
            
            //this is what is taking long
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
    
//    if (![nameOfItemAdded isEqualToString:@""] && ![priceThatUserEntered isEqualToString:@""]){
//        Item *newItem = [[Item alloc] init];
//        if (newItem) {
//            newItem.name = nameOfItemAdded;
//            newItem.time = expirationTime;
//            newItem.image = _img.image;
//            
//            //this is what is taking long
//            [[WishList sharedHelper] addItem:newItem];
//        }
//
//        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
//        
//        // Set the fire date/time
//        [localNotification setFireDate:expirationTime];
//        [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];
//        
//        localNotification.applicationIconBadgeNumber=1;
//        
//        // Setup alert notification
//        [localNotification setAlertAction:@"The wait is over!"];
//        [localNotification setAlertBody:[NSString stringWithFormat:@"Do you still want %@?", nameOfItemAdded]];
//        
//        localNotification.soundName=UILocalNotificationDefaultSoundName;
//        [localNotification setHasAction:YES];
//        UIApplication *app=[UIApplication sharedApplication];
//        [app scheduleLocalNotification:localNotification];
//        
//        alert = [[UIAlertView alloc] initWithTitle:@"Update" message:[NSString stringWithFormat:@"You have added %@ to the list.",nameOfItemAdded] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    }
//    else {
//        alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enter an item name." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//    }
    [alert show];
    
    //remove the text in box after the thing shows
    self.textField.text = @"";
    self.secondTextField = @"";
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
