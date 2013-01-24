//
//  GetCreditCardList.m
//  XMLTest
//
//  Created by Javier Loucim on 23/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "GetCreditCardList.h"
#import "TouchXML.h"

@implementation GetCreditCardList

@synthesize creditCardHolder;
@synthesize resultSet;

- (id) init
{
    self = [super init];
    return self;
}
- (void) loadXML {
    
    
    NSMutableArray *res = [[NSMutableArray alloc] init];
    
    NSString *URL = [NSString alloc];
    URL = connectionString;
    
    URL = [URL stringByAppendingString:@"views/list_cards.php?"];
    URL = [URL stringByAppendingString:@"cHash="];
    URL = [URL stringByAppendingString:connectionHash];
    
    if (creditCardHolder != nil) {
        URL = [URL stringByAppendingString:@"username="];
        URL = [URL stringByAppendingString:creditCardHolder];
    }
    
    NSURL* url = [NSURL URLWithString:URL];

    NSLog(@"GetCreditCardList %@",connectionString);
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    
    CXMLDocument *doc = [[CXMLDocument alloc] initWithData:data options:0 error:nil];
    
    NSArray *nodes = NULL;
    
    nodes = [doc nodesForXPath:@"/credit_cards/credit_card" error:nil];
    
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
    
    NSLog(@"GetCreditCardList %@",resultSet);
}
@end
