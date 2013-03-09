//
//  AddTicket.m
//  XMLTest
//
//  Created by Javi on 02/03/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "AddTicket.h"

@implementation AddTicket

@synthesize action;
@synthesize value;
@synthesize valueType;
@synthesize ticketDate;
@synthesize purchasedBy;
@synthesize creditCard;
@synthesize description;
@synthesize payments;
@synthesize bypassCheck;
@synthesize resultSet;

- (void) loadXML {
    
    
    NSMutableArray *res = [[NSMutableArray alloc] init];
    
    NSString *URL = [NSString alloc];
    URL = connectionString;
    
    URL = [URL stringByAppendingString:@"business/load_purchases.php?"];
    URL = [URL stringByAppendingString:@"cHash="];
    URL = [URL stringByAppendingString:connectionHash];
    
    if (action != nil) {
        URL = [URL stringByAppendingString:@"&cAction="];
        URL = [URL stringByAppendingString:action];
    } else {
        URL = [URL stringByAppendingString:@"&cAction=ADD"];
    }
    
    if (valueType != nil) {
        URL = [URL stringByAppendingString:@"&value_type="];
        URL = [URL stringByAppendingString:valueType];
    }
    
    if (value != nil) {
        URL = [URL stringByAppendingString:@"&value="];
        URL = [URL stringByAppendingString:value];
    }
    if (ticketDate != nil) {
        URL = [URL stringByAppendingString:@"&date="];
        URL = [URL stringByAppendingString:ticketDate];
    }
    if (purchasedBy != nil) {
        URL = [URL stringByAppendingString:@"&purchased_by="];
        URL = [URL stringByAppendingString:purchasedBy];
    }
    if (creditCard != nil) {
        URL = [URL stringByAppendingString:@"&credit_card="];
        URL = [URL stringByAppendingString:creditCard];
    }
    if (description != nil) {
        URL = [URL stringByAppendingString:@"&description="];
        NSString *encoded = [description stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        URL = [URL stringByAppendingString:encoded];
    }
    if (payments != nil) {
        URL = [URL stringByAppendingString:@"&payments="];
        URL = [URL stringByAppendingString:payments];
    }
    if (bypassCheck != nil) {
        URL = [URL stringByAppendingString:@"&bypass_check="];
        URL = [URL stringByAppendingString:bypassCheck];
    }
    
    
    NSURL* url = [NSURL URLWithString:URL];
    
    NSLog(@"AddTicket %@",URL);
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        
    NSLog(@"data %@",data);
    
    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    
    NSArray *nodes = NULL;
    
    nodes = [doc nodesForXPath:@"/action" error:nil];
    NSString *tmpStr = [[NSString alloc] init];
    
    //copio todos los items dentro de un nodo
    for (CXMLElement *node in nodes) {
        //armo el item
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        for(int counter = 0; counter < [node childCount]; counter++) {
            //  common procedure: dictionary with keys/values from XML node
            tmpStr = [[node childAtIndex:counter] stringValue];
            
            if (tmpStr != nil && tmpStr.length >0) {
                [item setObject:[[node childAtIndex:counter] stringValue] forKey:[[node childAtIndex:counter] name]];
            } else {
                [item setObject:@"" forKey:[[node childAtIndex:counter] name]];
            }
        }
        
        [res addObject:item];
    }
    
    resultSet = [[NSMutableArray alloc] initWithArray:res copyItems:YES];
    
    NSLog(@"AddTicket Resultset %@",resultSet);
}


@end
