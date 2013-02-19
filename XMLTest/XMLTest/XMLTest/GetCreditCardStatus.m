//
//  GetCreditCardStatus.m
//  XMLTest
//
//  Created by Javi on 18/02/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "GetCreditCardStatus.h"

@implementation GetCreditCardStatus

@synthesize resultSet;
@synthesize username;
@synthesize bankID;
@synthesize duePeriod;

- (void) loadXML {
    
    
    NSMutableArray *res = [[NSMutableArray alloc] init];
    
    NSString *URL = [NSString alloc];
    URL = connectionString;
    
    URL = [URL stringByAppendingString:@"views/list_cards_status.php?"];
    URL = [URL stringByAppendingString:@"cHash="];
    URL = [URL stringByAppendingString:connectionHash];
    
    if (username != nil) {
        URL = [URL stringByAppendingString:@"&username="];
        URL = [URL stringByAppendingString:username];
    }
    
    if (bankID != nil) {
        URL = [URL stringByAppendingString:@"&bank_id="];
        URL = [URL stringByAppendingString:bankID];
    }
    if ( duePeriod != nil) {
        URL = [URL stringByAppendingString:@"&due_period="];
        URL = [URL stringByAppendingString:duePeriod];
    }
    
    NSURL* url = [NSURL URLWithString:URL];
    
    NSLog(@"GetCreditCardStatus %@",URL);
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    
    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    
    NSArray *nodes = NULL;
    
    nodes = [doc nodesForXPath:@"/status/credit_cards/credit_card" error:nil];
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
    
    NSLog(@"GetCreditCardStatus Resultset %@",resultSet);
}


@end
