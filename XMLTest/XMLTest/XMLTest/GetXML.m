//
//  GetXML.m
//  XMLTest
//
//  Created by Javier Loucim on 19/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "GetXML.h"
#import "TouchXML.h"

@implementation GetXML
@synthesize content;

- (id) init
{
    self = [super init];

    return self;
}

- (void) loadXML {


    NSMutableArray *res = [[NSMutableArray alloc] init];
    
    NSString *const URL = @"http://mt.sdev.com.ar/php/views/list_cards.php?cHash=nada";
    NSURL* url = [NSURL URLWithString:URL];
    
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
    
    content = [[NSMutableArray alloc] initWithArray:res copyItems:YES];
    
    NSLog(@"%@",content);
    
    NSLog(@"done");
}

@end
