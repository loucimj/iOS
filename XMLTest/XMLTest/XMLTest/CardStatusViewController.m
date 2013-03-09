//
//  CardStatusViewController.m
//  XMLTest
//
//  Created by Javi on 18/02/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "CardStatusViewController.h"
#import "GetCreditCardStatus.h"
#import "CardCell.h"

@interface CardStatusViewController ()

@end

@implementation CardStatusViewController

@synthesize reportParameters;
@synthesize bankName;
@synthesize periodText;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   
    bankName.text=[reportParameters objectForKey:@"bank_name"];
    periodText.text=[reportParameters objectForKey:@"due_period"];
    
    GetCreditCardStatus *list = [[GetCreditCardStatus alloc] init];
    
    list.bankID = [reportParameters objectForKey:@"bank_id"];
    list.duePeriod = [reportParameters objectForKey:@"due_period"];
    
    [list loadXML];
    
    tableContent = list.resultSet;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [tableContent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Set the data for this cell:
    NSMutableDictionary *dic = [tableContent objectAtIndex:indexPath.row];
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *x = [f numberFromString:[dic objectForKey:@"value"]];
    [f setNumberStyle:NSNumberFormatterCurrencyStyle];
    cell.value.text = [f stringFromNumber:x];
    
    cell.cardNumber.text = [dic objectForKey:@"cc_number"];
//    [cell.cardNumber.text stringByAppendingString:@" "];
//    [cell.cardNumber.text stringByAppendingString:[dic objectForKey:@"cc_number"]];
    
    cell.holderName.text = [dic objectForKey:@"cc_holder"];
    
    NSString *image = [[NSString alloc] init];
    image = [image stringByAppendingString:[dic objectForKey:@"card_type"]];
    image = [image stringByAppendingString:@".png"];
    cell.imageView.image = [UIImage imageNamed:image];
    //cell.imageView.image = [UIImage imageNamed:@"flower.png"];
    
    // set the accessory view:
    //    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    cell.imageView.frame = CGRectMake(5, 5, 32, 32);

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"CardStatusViewController segue.identifier %@",segue.identifier);
    
    if([segue.identifier isEqualToString:@"ViewPurchasesSegue"]){
        
        NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
        NSMutableDictionary *selectedData = [tableContent objectAtIndex:selectedRowIndexPath.row];
        NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
        
        
        [tmp setObject:[reportParameters objectForKey:@"due_period"] forKey:@"duePeriod"];
        [tmp setObject:bankName.text forKey:@"bank_name"];
        [tmp setObject:[selectedData objectForKey:@"cc_number"] forKey:@"card_number"];
        [tmp setObject:[selectedData objectForKey:@"cc_holder"] forKey:@"cc_holder"];
        [tmp setObject:[selectedData objectForKey:@"card_type"] forKey:@"card_type"];
        [tmp setObject:[selectedData objectForKey:@"cc_id"] forKey:@"cc_id"];
        
        [segue.destinationViewController performSelector:@selector(setReportParameters:)  withObject:tmp];
        
    }
    
}
@end
