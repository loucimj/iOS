//
//  ReportControllerViewController.h
//  XMLTest
//
//  Created by Javier Loucim on 24/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportControllerViewController : UITableViewController {
    NSMutableArray *tableContent;
    IBOutlet UILabel *bank;
    IBOutlet UILabel *card;
    IBOutlet UIImageView *creditCardImage;
    IBOutlet UILabel *user;
    IBOutlet UILabel *dateSelection;
    IBOutlet UILabel *ticketText;
    IBOutlet UILabel *ticketValue;
}
@property (nonatomic,strong) NSMutableDictionary *reportParameters;
@property (nonatomic,strong) NSMutableDictionary *selectedCard;

- (IBAction) selectMenu:(id)sender;

@end
