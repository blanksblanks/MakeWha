//
//  TableViewController.m
//  BuyBuyBye
//
//  Created by Johnny Chen on 1/17/15.
//  Copyright (c) 2015 JohnnyChen. All rights reserved.
//

#import "TableViewController.h"
#import "WishList.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "FinalViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [[[WishList sharedHelper] getList] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    //cell.textLabel.text = @"hi";
    //cell.textLabel.text = [[[[WishList sharedHelper] getList] objectAtIndex:indexPath.row] getName];
    Item* i = [[[WishList sharedHelper] getList] objectAtIndex:indexPath.row];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"E MMM dd h:mma";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *date = [dateFormatter stringFromDate:i.time];
    cell.textLabel.numberOfLines = 0;
//    [[self cell.textLabel] setFont:[UIFont fontWithName:@"Cambria" size:17]];
    cell.textLabel.font = [UIFont fontWithName:@"Noteworthy" size:17];
    cell.textLabel.text = [NSString stringWithFormat:@"%@\nDecision Time: %@", [[[[WishList sharedHelper] getList] objectAtIndex:indexPath.row] getName], date];
    UIImage *image = i.image;
    cell.imageView.image = image;
    
    if ([i.time timeIntervalSinceNow] < 0.0) {
        UIColor* mint = [[UIColor alloc]initWithRed:254.0/255.0 green:129.0/255.0 blue:129.0/255.0 alpha:1];
        cell.backgroundColor = mint; // [self mixRandomColorWith:mint];
    }
    else if (indexPath.row % 2) {
        UIColor* color2 = [[UIColor alloc]initWithRed:210.0/255.0 green:212.0/255.0 blue:220.0/255.0 alpha:1];
        cell.backgroundColor = color2; // [self mixRandomColorWith:color2];
    } else {
        UIColor* color3 = [[UIColor alloc]initWithRed:179.0/255.0 green:236.0/255.0 blue:236.0/255.0 alpha:1];
        cell.backgroundColor = color3; // [self mixRandomColorWith:color3];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[[[WishList sharedHelper] getList] objectAtIndex:indexPath.row];
    [[WishList sharedHelper] deleteItem:[[[WishList sharedHelper] getList] objectAtIndex:indexPath.row]];
    [tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // do stuff
    Item* i = [[[WishList sharedHelper] getList] objectAtIndex:indexPath.row];
    self.nameOfItemSelected = i.name;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (UIColor*) mixRandomColorWith:(UIColor*) mix {
    CGFloat r, g, b, a;
    [mix getRed:&r green:&g blue:&b alpha:&a];
    r = ((CGFloat) arc4random_uniform(256) + r) / 2;
    g = ((CGFloat) arc4random_uniform(256) + g) / 2;
    b = ((CGFloat) arc4random_uniform(256) + b) /2;
    UIColor* color = [[UIColor alloc]initWithRed:r/255.0 green:129.0/255.0 blue:129.0/255.0 alpha:1];
    return color;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"ShowDetails"]) {
        FinalViewController* finalVC = (FinalViewController*)segue.destinationViewController;
        NSIndexPath* myNewPath = self.tableView.indexPathForSelectedRow;
        Item* i = [[[WishList sharedHelper] getList] objectAtIndex:myNewPath.row];
        finalVC.tempItem = i;

    }
}


@end
