//
//  GetOverviewStatus.m
//  XMLTest
//
//  Created by Javi on 16/02/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "GetOverviewStatus.h"

@implementation GetOverviewStatus
@synthesize creditCardHolder;
@synthesize resultSet;
@synthesize resultSet2;

- (void) loadXML {
    
    
    NSMutableArray *res = [[NSMutableArray alloc] init];
    
    NSString *URL = [NSString alloc];
    URL = connectionString;
    
    URL = [URL stringByAppendingString:@"views/list_global_status.php?"];
    URL = [URL stringByAppendingString:@"cHash="];
    URL = [URL stringByAppendingString:connectionHash];
    
    if (creditCardHolder != nil) {
        URL = [URL stringByAppendingString:@"&username="];
        URL = [URL stringByAppendingString:creditCardHolder];
    }
        
    NSURL* url = [NSURL URLWithString:URL];
    
    NSLog(@"GetOverviewStastus %@",URL);
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    
    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    
    NSArray *nodes = NULL;
    
    nodes = [doc nodesForXPath:@"/status" error:nil];
    
    //copio todos los items dentro de un nodo
    NSString *tmpStr = [[NSString alloc] init];
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
    resultSet2 = [[NSMutableArray alloc] initWithArray:res copyItems:YES];
    
    nodes = [doc nodesForXPath:@"/status/banks/bank" error:nil];
    
    [res removeAllObjects];
    
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

    NSLog(@"GetOverviewStatus Resultset %@",resultSet2);
    NSLog(@"GetOverviewStatus Resultset %@",resultSet);
}

@end
