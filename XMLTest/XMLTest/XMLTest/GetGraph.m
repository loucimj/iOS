//
//  GetGraph.m
//  XMLTest
//
//  Created by Javi on 24/02/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "GetGraph.h"

@implementation GetGraph

@synthesize username;
@synthesize bankID;
@synthesize creditCard;
@synthesize periodFrom;
@synthesize resultSet;

- (void) loadXML {
    
    
    NSMutableArray *res = [[NSMutableArray alloc] init];
    
    NSString *URL = [NSString alloc];
    URL = connectionString;
    
    URL = [URL stringByAppendingString:@"views/graph.php?"];
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

    if (creditCard != nil) {
        URL = [URL stringByAppendingString:@"&credit_card="];
        URL = [URL stringByAppendingString:creditCard];
    }
    if (periodFrom != nil) {
        URL = [URL stringByAppendingString:@"&period_from="];
        URL = [URL stringByAppendingString:periodFrom];
    }
    
    
    NSURL* url = [NSURL URLWithString:URL];
    
    NSLog(@"Graph %@",URL);
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    
    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    
    NSArray *nodes = NULL;
    
    nodes = [doc nodesForXPath:@"/graph/period" error:nil];
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
    
    NSLog(@"graph Resultset %@",resultSet);
}

@end
