//
//  SecondViewController.h
//  XMLTest
//
//  Created by Javi on 17/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UITableViewController {
    IBOutlet UILabel *bank;
    IBOutlet UILabel *card;
    IBOutlet UIImageView *creditCardImage;
    IBOutlet UILabel *user;
    IBOutlet UIDatePicker *dateSelection;
}

@property (nonatomic,strong) NSMutableDictionary *selectedCard;

@end
