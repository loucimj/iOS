//
//  GetGraph.h
//  XMLTest
//
//  Created by Javi on 24/02/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "MTXMLLists.h"

@interface GetGraph : MTXMLLists {
    NSNumber *maxValue;
    NSNumber *minValue;
    NSMutableArray *headerData;
    
}


@property IBOutlet NSMutableArray *headerData;
@property IBOutlet NSString *bankID;
@property IBOutlet NSString *creditCard;
@property IBOutlet NSString *username;
@property IBOutlet NSString *periodFrom;



@end
