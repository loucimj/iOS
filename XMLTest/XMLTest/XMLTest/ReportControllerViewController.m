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
#import "CardCell.h"

@interface ReportControllerViewController ()

@end

@implementation ReportControllerViewController
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    NSLog(@"received %@",reportParameters);
    
    NSString *title = [[NSString alloc] init];
    NSString *imageString = [[NSString alloc] init];
    NSDate *dateValue = [[NSDate alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //    title = [title stringByAppendingString: [dic objectForKey:@"card_type"]];
    title = [title stringByAppendingString:@"XXXX-"];
    title = [title stringByAppendingString:[reportParameters objectForKey:@"cc_number"]];
    
    bank.text = [reportParameters objectForKey:@"bank"];
    user.text = [reportParameters objectForKey:@"holder"];
    card.text = title;
    
    imageString = [imageString stringByAppendingString:[reportParameters objectForKey:@"card_type"]];
    imageString = [imageString stringByAppendingString:@".png"];
    
    creditCardImage.image = [UIImage imageNamed:imageString];
    
    dateValue = [reportParameters objectForKey:@"date"];
    [formatter setDateFormat:@"dd LLLL YYYY"];
    dateSelection.text = [formatter stringFromDate:dateValue ];
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    NSNumber *n = [[NSNumber alloc] init];
    n = [f numberFromString:[reportParameters objectForKey:@"value"]];
    [f setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    ticketValue.text= [f stringFromNumber:n];
    ticketText.text = [reportParameters objectForKey:@"ticket_text"];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectMenu:(id)sender {

    
    [self performSegueWithIdentifier:@"GoToReportSegue" sender:sender];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@" ReportController segue.identifier %@",segue.identifier);
    
    if([segue.identifier isEqualToString:@"CardStatusSegue"]){
        //acceder a la primera instancia del tabcontroller
        
        [reportParameters setObject:@"10" forKey:@"rowlimit"];
        [reportParameters setObject:@"TIMESTAMP" forKey:@"orderBy"];
        
        [[[segue.destinationViewController customizableViewControllers] objectAtIndex:0] performSelector:@selector(setReportParameters:) withObject:reportParameters];

        [[[segue.destinationViewController customizableViewControllers] objectAtIndex:1] performSelector:@selector(setReportParameters:) withObject:reportParameters];

        [[[segue.destinationViewController customizableViewControllers] objectAtIndex:2] performSelector:@selector(setReportParameters:) withObject:reportParameters];

    }
    
}


@end
