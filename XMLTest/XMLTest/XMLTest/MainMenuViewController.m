//
//  MainMenuViewController.m
//  XMLTest
//
//  Created by Javi on 16/02/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "MainMenuViewController.h"
#import "GetOverviewStatus.h"
#import "BankCell.h"
#import "ADVTheme.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController
@synthesize label1;

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

    //Customizacion look and feel
    [ADVThemeManager customizeView:self.view];
//    [ADVThemeManager customizeTableView:self.tableView];
    UIImageView *imgTableFooter = [[UIImageView alloc] initWithImage:[[ADVThemeManager sharedTheme] tableFooterBackground]];
    [self.tableView setTableFooterView:imgTableFooter];
    

    [ADVThemeManager customizeSecondaryLabel:self.label1];
    self.label1.font = [UIFont fontWithName:@"DINPro-CondBold" size:15.0f];
    self.label1.textColor = [UIColor colorWithRed:0.29f green:0.29f blue:0.29f alpha:1.00f];
    
    [ADVThemeManager customizeMainLabel:month];
    month.font = [UIFont fontWithName:@"DINPro-CondBold" size:18.0f];
    month.textColor = [UIColor colorWithRed:0.29f green:0.29f blue:0.29f alpha:1.00f];

    [ADVThemeManager customizeMainLabel:value];
    value.font = [UIFont fontWithName:@"DINPro-Bold" size:26.0f];
    value.textColor = [UIColor colorWithRed:0.29f green:0.29f blue:0.29f alpha:1.00f];
    
    GetOverviewStatus *list = [[GetOverviewStatus alloc] init];
    
    list.creditCardHolder = @"LOUCIMJ";
    
    [list loadXML];
    
    tableContent = list.resultSet;
    if ([list.resultSet2 count] > 0) {
        headerData = [list.resultSet2 objectAtIndex:0];
    }
    
    month.text = [headerData objectForKey:@"period"];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [f setLocale:locale];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *x = [f numberFromString:[headerData objectForKey:@"total_to_pay"]];
    
    [f setNumberStyle:NSNumberFormatterCurrencyStyle];
    value.text = [f stringFromNumber:x];
    
    
    UIColor *tintColor = [UIColor colorWithRed:0.03f green:0.64f blue:0.83f alpha:1.00f];
    [[ADVRoundProgressView appearance] setTintColor:tintColor];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [tableContent count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    BankCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    if (cell == nil) {
        cell = [[BankCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    
    // Set the data for this cell:
    NSMutableDictionary *dic = [tableContent objectAtIndex:indexPath.row];
    
    
    cell.bankName.text = [dic objectForKey:@"description"];
    cell.percentage.text = [dic objectForKey:@"percentage"];

    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];

    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [f setLocale:locale];
    
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *x = [[NSNumber alloc] init];
    x = [f numberFromString:[dic objectForKey:@"value"]];
    [f setNumberStyle:NSNumberFormatterCurrencyStyle];
    cell.value.text = [f stringFromNumber:x];
    
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *y = [f numberFromString:[dic objectForKey:@"percentage"]];
    NSLog(@"%@,%@",[dic objectForKey:@"percentage"],y);
    cell.roundProgressSmall.progress = ([y floatValue]/100);
    cell.roundProgressSmall.image = [UIImage tallImageNamed:@"progress-circle-small"];
    cell.roundProgressSmall.fontSize = 12.0f;

    // Configure the cell...
    
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
    NSLog(@"MainMenuViewController segue.identifier %@",segue.identifier);
    
if([segue.identifier isEqualToString:@"ViewCardStatusSegue"]){
    
        NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
        NSMutableDictionary *selectedData = [tableContent objectAtIndex:selectedRowIndexPath.row];
        NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
        
        
        [tmp setObject:[headerData objectForKey:@"period"] forKey:@"due_period"];
        [tmp setObject:[selectedData objectForKey:@"description"] forKey:@"bank_name"];
        [tmp addEntriesFromDictionary:selectedData];
        
        [segue.destinationViewController performSelector:@selector(setReportParameters:)  withObject:tmp];
        
    }
 
}


@end
