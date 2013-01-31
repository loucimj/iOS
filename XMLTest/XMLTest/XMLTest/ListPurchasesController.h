//
//  ListPurchasesController.h
//  XMLTest
//
//  Created by Javi on 30/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListPurchasesController : UITableViewController {
        NSMutableArray *tableContent;
}

@property (nonatomic,strong) NSMutableDictionary *reportParameters;

@end
