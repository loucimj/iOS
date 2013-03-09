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
    
    IBOutlet UILabel *bankName;
    IBOutlet UILabel *periodText;
    IBOutlet UILabel *cardNumber;
    IBOutlet UILabel *username;
    IBOutlet UIImageView *cardImage;
}

@property (nonatomic,strong) NSMutableDictionary *reportParameters;

@end
