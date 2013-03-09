//
//  CardStatusViewController.h
//  XMLTest
//
//  Created by Javi on 18/02/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardStatusViewController : UITableViewController {
    NSMutableArray *tableContent;
}

@property IBOutlet UILabel *bankName;
@property IBOutlet UILabel *periodText;
@property (nonatomic,strong) NSMutableDictionary *reportParameters;

@end
