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
    NSMutableArray *headerData;

    IBOutlet UILabel *bankName;
    IBOutlet UILabel *cardNumber;
    IBOutlet UIImageView *creditCardImage;
    IBOutlet UILabel *username;
    NSNumber *maxValue;
    NSNumber *minValue;
}
@property (nonatomic,strong) NSMutableDictionary *reportParameters;
@property (nonatomic,strong) NSMutableDictionary *selectedCard;


@end
