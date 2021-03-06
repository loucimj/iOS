//
//  ListPurchasesController.m
//  XMLTest
//
//  Created by Javi on 30/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "ListPurchasesController.h"
#import "ReportCell.h"
#import "GetPurchasesList.h"
#import "ADVTheme.h"
#import "DeletePurchase.h"

@interface ListPurchasesController ()

@end

@implementation ListPurchasesController

@synthesize reportParameters;

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
//    [ADVThemeManager customizeView:self.view];
    //    [ADVThemeManager customizeTableView:self.tableView];
    UIImageView *imgTableFooter = [[UIImageView alloc] initWithImage:[[ADVThemeManager sharedTheme] tableFooterBackground]];
    [self.tableView setTableFooterView:imgTableFooter];
    
    [ADVThemeManager customizeSecondaryLabel:bankName];
    bankName.font = [UIFont fontWithName:@"DINPro-CondBold" size:15.0f];
    bankName.textColor = [UIColor colorWithRed:0.29f green:0.29f blue:0.29f alpha:1.00f];
    
    [ADVThemeManager customizeMainLabel:periodText];
    periodText.font = [UIFont fontWithName:@"DINPro-CondBold" size:26.0f];
    periodText.textColor = [UIColor colorWithRed:0.29f green:0.29f blue:0.29f alpha:1.00f];
    
    [ADVThemeManager customizeSecondaryLabel:cardNumber];
    cardNumber.font = [UIFont fontWithName:@"DINPro-Bold" size:18.0f];
    cardNumber.textColor = [UIColor colorWithRed:0.29f green:0.29f blue:0.29f alpha:1.00f];

    
    
    GetPurchasesList *purchases = [[GetPurchasesList alloc] init];
    
    NSLog(@"--------------------------------------------------------------------");
    NSLog(@"ListPurchases %@",reportParameters);
    
    
    purchases.creditCardID = [reportParameters objectForKey:@"cc_id"];
    purchases.orderBy = [reportParameters objectForKey:@"orderBy"];
    purchases.rowLimit = [reportParameters objectForKey:@"rowLimit"];
    purchases.duePeriod = [reportParameters objectForKey:@"duePeriod"];
    purchases.creditCardHolder = [reportParameters objectForKey:@"cardHolder"];
    
    bankName.text = [reportParameters objectForKey:@"bank_name"];
    periodText.text = [reportParameters objectForKey:@"duePeriod"];
    cardNumber.text = [reportParameters objectForKey:@"card_number"];
    username.text = [reportParameters objectForKey:@"cc_holder"];
    
    NSString *imageString = [[NSString alloc] init];
    
    imageString = [imageString stringByAppendingString:[reportParameters objectForKey:@"card_type"]];
    imageString = [imageString stringByAppendingString:@".png"];
    
    cardImage.image = [UIImage imageNamed:imageString];
//    purchases.orderBy = @"TIMESTAMP";
//    purchases.rowLimit = @"10";
    
    
    
    [purchases loadXML];
    
    tableContent = [[NSMutableArray alloc] initWithArray:purchases.resultSet copyItems:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//warning Incomplete method implementation.
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
    
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [f setLocale:locale];
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

        float z;
        z = [cuotasPagadas intValue];
        z = z/[cuotas intValue];
        
        cell.roundProgressSmall.textLabel = cuotasText;
        cell.roundProgressSmall.progress = z;
        cell.roundProgressSmall.image = [UIImage tallImageNamed:@"progress-circle-small"];
        cell.roundProgressSmall.fontSize = 12.0f;
        cell.roundProgressSmall.hidden = NO;
    } else {
        cell.cuotas.text = @"";
        cell.cuotasProgress.text = @"";
        cell.roundProgressSmall.hidden = YES;
    }

    [ADVThemeManager customizeMainLabel:cell.valorAPagar];
    cell.fecha.text = [dic objectForKey:@"date"];
    
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
        
        [tableContent removeAllObjects];
        [self viewDidLoad];
        
    }
}


@end
