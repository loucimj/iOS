//
//  ValuesViewController.h
//  XMLTest
//
//  Created by Javier Loucim on 23/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ValuesViewController : UITableViewController {
    IBOutlet UILabel *bank;
    IBOutlet UILabel *card;
    IBOutlet UIImageView *creditCardImage;
    IBOutlet UILabel *user;
    IBOutlet UILabel *dateSelection;
    
    IBOutlet UISwitch *loadByTicket;
    IBOutlet UISegmentedControl *currency;
    IBOutlet UITextField *value;
    IBOutlet UITextField *pagos;
    IBOutlet UILabel *leyenda;

}

@property (nonatomic,strong) NSMutableDictionary *selectedCard;

- (IBAction) buttonSave:(id)sender;

- (IBAction) textEdited:(id)sender;

- (BOOL) validateData;

- (BOOL) saveData;

- (void) updateLegend;

@end
