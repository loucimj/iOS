//
//  ReportControllerViewController.m
//  XMLTest
//
//  Created by Javier Loucim on 24/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "ReportControllerViewController.h"
#import "GetPurchasesList.h"
#import "ReportCell.h"

@interface ReportControllerViewController ()

@end

@implementation ReportControllerViewController
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
    
    
    NSLog(@"received %@",reportParameters);
    
    GetPurchasesList *list = [[GetPurchasesList alloc] init];
    
    list.duePeriod = [reportParameters objectForKey:@"duePeriod"];
    list.creditCardHolder = [reportParameters objectForKey:@"creditCardHolder"];
    list.rowLimit = [reportParameters objectForKey:@"rowLimit"];
    list.orderBy =[reportParameters objectForKey:@"orderBy"];

    [list loadXML];
    
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
    
    ReportCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ReportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    NSMutableDictionary *dic = [tableContent objectAtIndex:indexPath.row];
    
/*
    cell.descripcion = [dic objectForKey:@"]
    cell.imageView.image = [UIImage imageNamed:image];
    //cell.imageView.image = [UIImage imageNamed:@"flower.png"];
    
    // set the accessory view:
    //    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    cell.imageView.frame = CGRectMake(5, 5, 32, 32);
*/    
    return cell;
}
// FIN UITABLEVIEW -------------------------------------------------------------------------------------


@end
