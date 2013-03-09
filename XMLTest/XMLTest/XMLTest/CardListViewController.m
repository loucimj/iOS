//
//  CardListViewController.m
//  XMLTest
//
//  Created by Javi on 26/02/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "CardListViewController.h"
#import "GetCreditCardList.h"
#import "CardCell.h"

@interface CardListViewController ()

@end

@implementation CardListViewController

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
    
    GetCreditCardList *list = [[GetCreditCardList alloc] init];
    
    [list loadXML];
    
    tableContent = [[NSMutableArray alloc] initWithArray:list.resultSet copyItems:YES];
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
    
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    NSMutableDictionary *dic = [tableContent objectAtIndex:indexPath.row];
    
    
    NSString *title = [[NSString alloc] init];
    NSString *subtitle = [[NSString alloc] init];
    NSString *image = [[NSString alloc] init];
    
    //    title = [title stringByAppendingString: [dic objectForKey:@"card_type"]];
//    title = [title stringByAppendingString:@"XXXX-"];
    title = [title stringByAppendingString:[dic objectForKey:@"cc_number"]];
    
    subtitle = [subtitle stringByAppendingString:[dic objectForKey:@"bank"]];
    subtitle = [subtitle stringByAppendingString:@" "];
    subtitle = [subtitle stringByAppendingString:[dic objectForKey:@"holder"]];
    
    cell.textLabel.text = title;
    cell.detailTextLabel.text = subtitle;
    
    image = [image stringByAppendingString:[dic objectForKey:@"card_type"]];
    image = [image stringByAppendingString:@".png"];
    cell.imageView.image = [UIImage imageNamed:image];
    //cell.imageView.image = [UIImage imageNamed:@"flower.png"];
    
    // set the accessory view:
    //    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    cell.imageView.frame = CGRectMake(5, 5, 32, 32);
    
    return cell;
    
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
    
    if([segue.identifier isEqualToString:@"showFutureAndPastSegue"]){
        
        NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
        NSMutableDictionary *selectedData = [tableContent objectAtIndex:selectedRowIndexPath.row];
        NSMutableDictionary *tmp1 = [[NSMutableDictionary alloc] init];
        NSMutableDictionary *tmp2 = [[NSMutableDictionary alloc] init];
        
        [tmp1 addEntriesFromDictionary:selectedData];
        [tmp1 setObject:@"-12" forKey:@"periodFrom"];
        //[segue.destinationViewController performSelector:@selector(setSelectedCard:) withObject:selectedData];
        
        //acceder a los dos viewcontrollers para pasarle los datos.
//        [[[segue.destinationViewController customizableViewControllers] objectAtIndex:0]performSelector:@selector(setReportParameters:) withObject:selectedData];

        [[[segue.destinationViewController customizableViewControllers] objectAtIndex:0]performSelector:@selector(setReportParameters:) withObject:tmp1];

        [tmp2 addEntriesFromDictionary:selectedData];
        [tmp2 setObject:@"TODAY" forKey:@"periodFrom"];

        [[[segue.destinationViewController customizableViewControllers] objectAtIndex:1]performSelector:@selector(setReportParameters:) withObject:tmp2];

//        [[[[[segue.destinationViewController customizableViewControllers] objectAtIndex:1] viewControllers] objectAtIndex:0] performSelector:@selector(setReportParameters:) withObject:selectedData];
        
    }
    
}



@end
