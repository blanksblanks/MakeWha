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

@implementation FinalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateLabels];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary* paramName = @{ @"OPERATION-NAME": @"findItemsByKeywords", @"SERVICE-VERSION": @"1.0.0", @"SECURITY-APPNAME": @"MakeWha00-d9a3-45a1-9273-24390350eed",@"RESPONSE-DATA-FORMAT":@"JSON", @"REST-PAYLOAD": @"", @"keywords":self.tempItem.name};
    [manager GET:@"http://svcs.ebay.com/services/search/FindingService/v1" parameters:paramName success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *items = [[[[[responseObject valueForKey:@"findItemsByKeywordsResponse"] firstObject] objectForKey:@"searchResult"] firstObject] objectForKey:@"item"];
        
        NSDictionary *firstItem = [items firstObject];
        
        NSString *price = [[[[[firstItem objectForKey:@"sellingStatus"] firstObject] objectForKey:@"convertedCurrentPrice"] firstObject] objectForKey:@"__value__"];
        
        self.Price.text = price;
        NSLog(@"JSON: %@", price);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
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
