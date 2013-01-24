//
//  MTXMLLists.h
//  XMLTest
//
//  Created by Javier Loucim on 23/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TouchXML.h"

@interface MTXMLLists : NSObject {
    NSString *connectionString;
    NSString *connectionHash;
}

- (NSMutableArray *) parseXMLResultSet:(CXMLDocument *) doc docPath:(NSString *)xmlPath ;
- (void) loadXML;

@property IBOutlet NSMutableArray *resultSet;


@end
