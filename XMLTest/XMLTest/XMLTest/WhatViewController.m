//
//  WhatViewController.m
//  XMLTest
//
//  Created by Javier Loucim on 23/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "WhatViewController.h"

@interface WhatViewController ()

@end

@implementation WhatViewController

@synthesize selectedCard;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"received on what %@",selectedCard);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"segue.identifier %@",segue.identifier);
    
    if([segue.identifier isEqualToString:@"selectValuesSegue"]){
        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
        
        [temp setObject:[ticketText text] forKey:@"ticket_text"];
        [temp addEntriesFromDictionary:selectedCard];
        
        [segue.destinationViewController performSelector:@selector(setSelectedCard:) withObject:temp];
        
    }
    
}

@end
