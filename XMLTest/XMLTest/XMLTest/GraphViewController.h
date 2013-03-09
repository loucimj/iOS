//
//  GraphViewController.h
//  XMLTest
//
//  Created by Javi on 27/02/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface GraphViewController : UITableViewController {
    NSMutableArray *tableContent;

    IBOutlet UILabel *bankName;
    IBOutlet UILabel *cardNumber;
    IBOutlet UIImageView *creditCardImage;
    IBOutlet UILabel *username;
}
@property (nonatomic,strong) NSMutableDictionary *reportParameters;
@property (nonatomic,strong) NSMutableDictionary *selectedCard;


@end
