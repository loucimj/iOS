//
//  GraphViewController.m
//  XMLTest
//
//  Created by Javi on 27/02/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "GraphViewController.h"
#import "GetGraph.h"
#import "ReportCell.h"

@interface GraphViewController ()

@end

@implementation GraphViewController
@synthesize reportParameters;
@synthesize selectedCard;

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

    
    NSLog(@"GraphViewController parameters received %@",reportParameters);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    bankName.text = [reportParameters objectForKey:@"bank"];
    cardNumber.text = [reportParameters objectForKey:@"cc_number"];
    username.text = [reportParameters objectForKey:@"holder"];
    
    NSString *imageString = [[NSString alloc] init];
    
    imageString = [imageString stringByAppendingString:[reportParameters objectForKey:@"card_type"]];
    imageString = [imageString stringByAppendingString:@".png"];
    
    creditCardImage.image = [UIImage imageNamed:imageString];

    GetGraph *list = [[GetGraph alloc] init];
    
    list.username = [reportParameters objectForKey:@"holder"];
    list.creditCard = [reportParameters objectForKey:@"cc_id"];
    list.periodFrom = [reportParameters objectForKey:@"periodFrom"];
    
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
    ReportCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[ReportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Set the data for this cell:
    NSMutableDictionary *dic = [tableContent objectAtIndex:indexPath.row];
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *x = [f numberFromString:[dic objectForKey:@"total"]];
    [f setNumberStyle:NSNumberFormatterCurrencyStyle];
    cell.valorAPagar.text = [f stringFromNumber:x];
    cell.descripcion.text = [dic objectForKey:@"month"];
    
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
    NSLog(@"Graph segue.identifier %@",segue.identifier);
    
    if([segue.identifier isEqualToString:@"showPurchasesDetailSegue"]){
        
        NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
        NSMutableDictionary *selectedData = [tableContent objectAtIndex:selectedRowIndexPath.row];
        NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
                
        NSString *imageString = [[NSString alloc] init];
        
        imageString = [imageString stringByAppendingString:[reportParameters objectForKey:@"card_type"]];

        [tmp setObject:[reportParameters objectForKey:@"cc_id"] forKey:@"cc_id"];
        [tmp setObject:[selectedData objectForKey:@"period"] forKey:@"duePeriod"];
        [tmp setObject:[reportParameters objectForKey:@"holder"] forKey:@"cardHolder"];
        [tmp setObject:[reportParameters objectForKey:@"card_type"] forKey:@"card_type"];
//        [tmp setObject:[reportParameters objectForKey:@"holder"] forKey:@"cc_holder"];
        [tmp setObject:[reportParameters objectForKey:@"cc_number"] forKey:@"card_number"];
        [tmp setObject:[reportParameters objectForKey:@"bank"] forKey:@"bank_name"];

        [segue.destinationViewController performSelector:@selector(setReportParameters:)  withObject:tmp];

        
    }
    
}




@end
