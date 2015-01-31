//
//  FinalViewController.m
//  BuyBuyBye
//
//  Created by manojGURUNG on 1/17/15.
//  Copyright (c) 2015 JohnnyChen. All rights reserved.
//

#import "FinalViewController.h"
#import "TableViewController.h"
#import "WishList.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>

@interface FinalViewController ()

@end

@implementation FinalViewController{
    NSString *whatIWant;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *buttons = [NSArray arrayWithObjects: self.webButton, self.quitButton,nil];
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

    
    // Do any additional setup after loading the view.
    [self priceQuery];
    [self updateLabels];
}

-(IBAction)websiteButton {
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:[NSString stringWithFormat:@"%@",whatIWant]]];
}

-(IBAction)exitButton {
    NSLog(@"exit button recognized");
    exit(0);
}

-(void) setTempItem:(Item *)tempItem {
    _tempItem = tempItem;
    [self updateLabels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateLabels {
    self.ItemName.text = self.tempItem.name;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.image = self.tempItem.image;
}

- (void)priceQuery {
    [_websiteButton addTarget:self action:@selector(websiteButton) forControlEvents:UIControlEventTouchUpInside];
    [_exitButton addTarget:self action:@selector(exitButton) forControlEvents:UIControlEventTouchUpInside];
    
    // Use ebay API to do a price query
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary* paramName = @{ @"OPERATION-NAME": @"findItemsByKeywords", @"SERVICE-VERSION": @"1.0.0", @"SECURITY-APPNAME": @"MakeWha00-d9a3-45a1-9273-24390350eed",@"RESPONSE-DATA-FORMAT":@"JSON", @"REST-PAYLOAD": @"", @"keywords":self.tempItem.name};
    [manager GET:@"http://svcs.ebay.com/services/search/FindingService/v1" parameters:paramName success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *items = [[[[[responseObject valueForKey:@"findItemsByKeywordsResponse"] firstObject] objectForKey:@"searchResult"] firstObject] objectForKey:@"item"];
        
        NSDictionary *firstItem = [items firstObject];
        
        NSString *price, *text, *priceText, *website, *needle;
        
        price = [[[[[firstItem objectForKey:@"sellingStatus"] firstObject] objectForKey:@"convertedCurrentPrice"] firstObject] objectForKey:@"__value__"];
        if ([price isEqual:[NSNull null]]) {
            text = @"eBay says this costs $";
            priceText = [NSString stringWithFormat:@"%@ %@", text, price];
            website = [firstItem objectForKey:@"viewItemURL"];
            needle = [[website description] componentsSeparatedByString:@"\""][1];
        } else {
            priceText = @"eBay could not find this item";
            needle = @"http://www.ebay.com/";
        }
        
        self.Price.text = priceText;
        whatIWant = needle;
        NSLog(@"JSON: %@", price);
        NSLog(@"%@",website);
        NSLog(@"%@",needle);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
