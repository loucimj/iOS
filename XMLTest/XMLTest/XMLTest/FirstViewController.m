//
//  FirstViewController.m
//  XMLTest
//
//  Created by Javi on 17/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "GetCreditCardList.h"

@interface FirstViewController ()


@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    loadUnknownXML();
    /*
    GetXML *test = [GetXML alloc];
    
    
    
    NSLog(@"init");
    test.loadXML;
     */
    
    GetCreditCardList *list = [[GetCreditCardList alloc] init];
    
    list.loadXML;

    tableContent = [[NSMutableArray alloc] initWithArray:list.resultSet copyItems:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// UITABLEVIEW -------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    int selectedRow = indexPath.row;
    NSLog(@"touch on row %d", selectedRow);
}
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 // Return the number of sections.
 return 1 ;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 // Return the number of rows in the section.
 // If you're serving data from an array, return the length of the array:
 return [tableContent count];
 }
 


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    NSMutableDictionary *dic = [tableContent objectAtIndex:indexPath.row];

    
    NSString *title = [[NSString alloc] init];
    NSString *subtitle = [[NSString alloc] init];
    NSString *image = [[NSString alloc] init];
    
//    title = [title stringByAppendingString: [dic objectForKey:@"card_type"]];
    title = [title stringByAppendingString:@"XXXX-"];
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
}
// FIN UITABLEVIEW -------------------------------------------------------------------------------------


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if([segue.identifier isEqualToString:@"selectDateSegue"]){
//        SecondViewController *controller = (SecondViewController *)segue.destinationViewController;
        /*
        NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
        NSUInteger selectedRow = selectedRowIndexPath.row;
        NSMutableDictionary *selectedData = [tableContent objectAtIndex:selectedRowIndexPath.row];
        NSLog(@"%d",selectedRow);
        NSLog(@"%@",controller);
         //        controller.data = [[NSMutableDictionary alloc] init ];
        controller.selectedCard = selectedData;
        */
        NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
        NSMutableDictionary *selectedData = [tableContent objectAtIndex:selectedRowIndexPath.row];
        
        [segue.destinationViewController performSelector:@selector(setSelectedCard:) withObject:selectedData];
        
    }

}

@end
