//
//  WhatViewController.h
//  XMLTest
//
//  Created by Javier Loucim on 23/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhatViewController : UIViewController {
    IBOutlet UITextView *ticketText;
}

@property (nonatomic,strong) NSMutableDictionary *selectedCard;

@end
