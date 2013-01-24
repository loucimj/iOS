//
//  MTXMLLists.m
//  XMLTest
//
//  Created by Javier Loucim on 23/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "MTXMLLists.h"
#import "TouchXML.h"

@implementation MTXMLLists

@synthesize resultSet;

- (id) init
{
    self = [super init];
    connectionString = @"http://mt.sdev.com.ar/php/";
    connectionHash = @"nada";
    return self;
}

- (NSMutableArray *) parseXMLResultSet:(CXMLDocument *)doc docPath:(NSString *)xmlPath { 
    NSArray *nodes = NULL;
    NSMutableArray *res = [[NSMutableArray alloc] init];
    
    nodes = [doc nodesForXPath:xmlPath error:nil];
    
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
    
    return res;
}

@end
