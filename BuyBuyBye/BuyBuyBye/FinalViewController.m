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
    // Do any additional setup after loading the view.
    [self updateLabels];
    [_websiteButton addTarget:self action:@selector(websiteButton) forControlEvents:UIControlEventTouchUpInside];
    [_exitButton addTarget:self action:@selector(exitButton) forControlEvents:UIControlEventTouchUpInside];
    
    // Use ebay API to do a price query
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary* paramName = @{ @"OPERATION-NAME": @"findItemsByKeywords", @"SERVICE-VERSION": @"1.0.0", @"SECURITY-APPNAME": @"MakeWha00-d9a3-45a1-9273-24390350eed",@"RESPONSE-DATA-FORMAT":@"JSON", @"REST-PAYLOAD": @"", @"keywords":self.tempItem.name};
    [manager GET:@"http://svcs.ebay.com/services/search/FindingService/v1" parameters:paramName success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *items = [[[[[responseObject valueForKey:@"findItemsByKeywordsResponse"] firstObject] objectForKey:@"searchResult"] firstObject] objectForKey:@"item"];
        
        NSDictionary *firstItem = [items firstObject];
        
        NSString *price = [[[[[firstItem objectForKey:@"sellingStatus"] firstObject] objectForKey:@"convertedCurrentPrice"] firstObject] objectForKey:@"__value__"];
        
        self.Price.text = price;
        NSLog(@"JSON: %@", price);
        
        NSString *website = [firstItem objectForKey:@"viewItemURL"];
        NSString *needle = [[website description] componentsSeparatedByString:@"\""][1];
        whatIWant = needle;
        
        NSLog(@"%@",website);
        NSLog(@"%@",needle);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
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
    self.imageView.image = self.tempItem.image;
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
