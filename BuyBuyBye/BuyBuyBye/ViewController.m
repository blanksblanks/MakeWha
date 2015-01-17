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

- (IBAction)button:(UIButton *)sender {
    self.textField.text = @"hi";
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
