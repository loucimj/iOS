//
//  MainMenuViewController.h
//  XMLTest
//
//  Created by Javi on 16/02/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UITableViewController {
    NSMutableArray *tableContent;
    NSMutableDictionary *headerData;
    IBOutlet UILabel *month;
    IBOutlet UILabel *value;
}

@property (strong, nonatomic) IBOutlet UILabel *label1;


@end
