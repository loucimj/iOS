//
//  SaveTicket.m
//  XMLTest
//
//  Created by Javi on 24/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "SaveTicket.h"

@implementation SaveTicket

@synthesize ticketInfo;
@synthesize resultSet;

- (void) loadXML {
    
    
    NSMutableArray *res = [[NSMutableArray alloc] init];
    
    NSString *URL = [NSString alloc];
    URL = connectionString;
    
    URL = [URL stringByAppendingString:@"business/load_purchases.php?"];
    URL = [URL stringByAppendingString:@"cHash="];
    URL = [URL stringByAppendingString:connectionHash];
    
    URL = [URL stringByAppendingString:@"&cAction=ADD"];

    URL = [URL stringByAppendingString:@"&value_type"];
    URL = [URL stringByAppendingString:[ticketInfo objectForKey:@"value_type"]];

    URL = [URL stringByAppendingString:@"&date"];
    URL = [URL stringByAppendingString:[ticketInfo objectForKey:@"date"]];

    URL = [URL stringByAppendingString:@"&purchased_by"];
    URL = [URL stringByAppendingString:[ticketInfo objectForKey:@"holder"]];

    URL = [URL stringByAppendingString:@"&credit_card"];
    URL = [URL stringByAppendingString:[ticketInfo objectForKey:@"cc_id"]];

    URL = [URL stringByAppendingString:@"&description"];
    URL = [URL stringByAppendingString:[ticketInfo objectForKey:@"ticket_text"]];
    
    URL = [URL stringByAppendingString:@"&value"];
    URL = [URL stringByAppendingString:[ticketInfo objectForKey:@"value"]];

    URL = [URL stringByAppendingString:@"&payments"];
    URL = [URL stringByAppendingString:[ticketInfo objectForKey:@"payments"]];

    URL = [URL stringByAppendingString:@"&bypass_check"];
    URL = [URL stringByAppendingString:[ticketInfo objectForKey:@"bypass_check"]];

    NSURL* url = [NSURL URLWithString:URL];
    
    NSLog(@"SaveTicket %@",connectionString);
    
    NSLog(@"SaveTicket received %@",ticketInfo);
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    
    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    
    NSArray *nodes = NULL;
    
    nodes = [doc nodesForXPath:@"/action" error:nil];
    
    //copio todos los items dentro de un nodo
    for (CXMLElement *node in nodes) {
        //armo el item
        NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
        for(int counter = 0; counter < [node childCount]; counter++) {
            //  common procedure: dictionary with keys/values from XML node
            [item setObject:[[node childAtIndex:counter] stringValue] forKey:[[node childAtIndex:counter] name]];
        }
        
        [res addObject:item];
    }
    
    resultSet = [[NSMutableArray alloc] initWithArray:res copyItems:YES];
    
    NSLog(@"SaveTicket %@",resultSet);
}


@end
