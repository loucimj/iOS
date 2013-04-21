//
//  DeletePurchase.m
//  CCTrackr
//
//  Created by Javi on 11/03/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "DeletePurchase.h"

@implementation DeletePurchase

@synthesize username;
@synthesize purchaseID;
@synthesize resultSet;
- (void) loadXML {
    
    
    NSMutableArray *res = [[NSMutableArray alloc] init];
    
    NSString *URL = [NSString alloc];
    URL = connectionString;
    
    URL = [URL stringByAppendingString:@"business/delete_purchase.php?"];
    URL = [URL stringByAppendingString:@"cHash="];
    URL = [URL stringByAppendingString:connectionHash];
    
    if (username != nil) {
        URL = [URL stringByAppendingString:@"&username="];
        URL = [URL stringByAppendingString:username];
    } else {
        URL = [URL stringByAppendingString:@"&cAction=ADD"];
    }
    
    if (purchaseID != nil) {
        URL = [URL stringByAppendingString:@"&purchase_id="];
        URL = [URL stringByAppendingString:purchaseID];
    }
    
    
    NSURL* url = [NSURL URLWithString:URL];
    
    NSLog(@"DeletePurchase %@",URL);
    
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
    
    NSLog(@"Delete Purchase Resultset %@",resultSet);
}


@end
