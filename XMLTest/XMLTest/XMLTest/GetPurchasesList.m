//
//  GetPurchasesList.m
//  XMLTest
//
//  Created by Javier Loucim on 24/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "GetPurchasesList.h"

@implementation GetPurchasesList

@synthesize resultSet;

@synthesize creditCardHolder;
@synthesize rowLimit;
@synthesize orderBy;
@synthesize duePeriod;

- (void) loadXML {
    
    
    NSMutableArray *res = [[NSMutableArray alloc] init];
    
    NSString *URL = [NSString alloc];
    URL = connectionString;
    
    URL = [URL stringByAppendingString:@"views/list_purchases.php?"];
    URL = [URL stringByAppendingString:@"cHash="];
    URL = [URL stringByAppendingString:connectionHash];
    
    if (creditCardHolder != nil) {
        URL = [URL stringByAppendingString:@"username="];
        URL = [URL stringByAppendingString:creditCardHolder];
    }

    if (rowLimit != nil) {
        URL = [URL stringByAppendingString:@"limit="];
        URL = [URL stringByAppendingString:rowLimit];
    }
    if (orderBy != nil) {
        URL = [URL stringByAppendingString:@"order_by="];
        URL = [URL stringByAppendingString:orderBy];
    }
    if (duePeriod != nil) {
        URL = [URL stringByAppendingString:@"due_period="];
        URL = [URL stringByAppendingString:duePeriod];
    }
    
    NSURL* url = [NSURL URLWithString:URL];
    
    NSLog(@"GetPurchasesList %@",connectionString);
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    
    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    
    NSArray *nodes = NULL;
    
    nodes = [doc nodesForXPath:@"/purchases/purchase" error:nil];
    
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
    
    NSLog(@"GetPurchasesList %@",resultSet);
}

@end
