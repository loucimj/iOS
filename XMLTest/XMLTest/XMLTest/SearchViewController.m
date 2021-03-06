//
//  SearchViewController.m
//  XMLTest
//
//  Created by Javi on 19/02/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "SearchViewController.h"
#import "Search.h"
#import "ReportCell.h"
#import "ADVTheme.h"
#import "DeletePurchase.h"

@interface SearchViewController ()


@end

@implementation SearchViewController

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

    UIImageView *imgTableFooter = [[UIImageView alloc] initWithImage:[[ADVThemeManager sharedTheme] tableFooterBackground]];
    [self.tableView setTableFooterView:imgTableFooter];

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
    ReportCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    if (cell == nil) {
        cell = [[ReportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    NSMutableDictionary *dic = [tableContent objectAtIndex:indexPath.row];
    
    cell.descripcion.text = [dic objectForKey:@"description"];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [f setLocale:locale];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *x = [f numberFromString:[dic objectForKey:@"payment_value"]];
    [f setNumberStyle:NSNumberFormatterCurrencyStyle];
    cell.valorAPagar.text = [f stringFromNumber:x];
    
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    x = [f numberFromString:[dic objectForKey:@"value"]];
    [f setNumberStyle:NSNumberFormatterCurrencyStyle];
    cell.valor.text = [f stringFromNumber:x];
    
    
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    x = [f numberFromString:[dic objectForKey:@"payments"]];
    if ([x integerValue] > 1) {
        cell.cuotas.text = [dic objectForKey:@"payments"];
        cell.cuotas.text  = [cell.cuotas.text stringByAppendingString:@" cuotas de "];
        
        float y;
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        
        NSNumber *numberValue=[f numberFromString:[dic objectForKey:@"value"]];
        NSNumber *cuotas = [f numberFromString:[dic objectForKey:@"payments"]];
        NSNumber *resultado = [[NSNumber alloc] init];
        
        y = [numberValue floatValue] / [cuotas floatValue];
        resultado = [NSNumber numberWithFloat:y];
        
        [f setNumberStyle:NSNumberFormatterCurrencyStyle];
        
        cell.cuotas.text  = [cell.cuotas.text stringByAppendingString:[f stringFromNumber:resultado]];
        
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSNumber *cuotasPagadas = [[NSNumber alloc] init];
        int remaining = ([cuotas intValue] - [[f numberFromString:[dic objectForKey:@"remaining_payments"]] intValue]);
        
        cuotasPagadas = [NSNumber numberWithInt:remaining];
        NSString *cuotasText = [[NSString alloc] init];
        cuotasText = [f stringFromNumber:cuotasPagadas];
        cuotasText = [cuotasText stringByAppendingString:@"/"];
        cuotasText = [cuotasText stringByAppendingString:[f stringFromNumber:cuotas]];
        
        //        NSLog(@"%@: %@ - %@",[dic objectForKey:@"remaining_payments"],cuotasPagadas,cuotasText);
        
        cell.cuotasProgress.text = cuotasText;
    } else {
        cell.cuotas.text = @"";
        cell.cuotasProgress.text = @"";
    }
    cell.fecha.text = [dic objectForKey:@"date"];

    NSString *image = [[NSString alloc] init];
    image = [image stringByAppendingString:[dic objectForKey:@"card_type"]];
    image = [image stringByAppendingString:@".png"];
    cell.imageView.image = [UIImage imageNamed:image];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImageView *imgBkg = [[UIImageView alloc] initWithImage:[[ADVThemeManager sharedTheme] tableSectionHeaderBackground]];
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 300, 22)];

    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];

    if ([tableContent count] > 0) {
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [f setLocale:locale];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        NSString *items = [[NSString alloc] init];
        NSNumber *itemCount = [[NSNumber alloc] init];
        itemCount = [NSNumber numberWithInt:[tableContent count]];
        items = [f stringFromNumber:itemCount];
        
        if ([tableContent count] > 1) {
            lblTitle.text = @"Se han encontrado ";
            lblTitle.text = [lblTitle.text stringByAppendingString:items];
            lblTitle.text = [lblTitle.text stringByAppendingString:@" tickets"];
        } else {
            lblTitle.text = @"Se ha encontrado 1 solo ticket";
        }
    } else {
        lblTitle.text = @"";
    }
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.textColor = [UIColor colorWithRed:0.43f green:0.43f blue:0.43f alpha:1.00f];
    lblTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:15.0f];
    
    [imgBkg addSubview:lblTitle];
    return imgBkg;
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


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        DeletePurchase *deleteService = [[DeletePurchase alloc] init];
        
        
#warning - Reemplazar con SINGLETON!!!
//        NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
        NSMutableDictionary *selectedData = [tableContent objectAtIndex:indexPath.row];
        
        deleteService.username = @"LOUCIMJ";
        deleteService.purchaseID = [selectedData objectForKey:@"pur_id"];

        NSLog(@"DELETE OBJECT %@",selectedData);
        
        [deleteService loadXML];

        Search *searchService = [[Search alloc] init];
        
        searchService.searchPhrase = lastSearch;
        searchService.username = @"LOUCIMJ";
        
        
        [searchService loadXML];
        
        tableContent = [[NSMutableArray alloc] initWithArray:searchService.resultSet copyItems:YES];
        
        [self.tableView reloadData];
        
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self handleSearch:searchBar];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [self handleSearch:searchBar];
}


- (void)handleSearch:(UISearchBar *)searchBar {
    NSLog(@"User searched for %@", searchBar.text);

    Search *searchService = [[Search alloc] init];
    
    searchService.searchPhrase = searchBar.text;
    searchService.username = @"LOUCIMJ";
    
    
    [searchService loadXML];
    
    tableContent = [[NSMutableArray alloc] initWithArray:searchService.resultSet copyItems:YES];
    
    [self.tableView reloadData];

    lastSearch = searchBar.text;
    
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
    NSLog(@"User canceled search");
    [searchBar resignFirstResponder]; // if you want the keyboard to go away
}
@end
