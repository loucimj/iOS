//
//  BankCell.h
//  XMLTest
//
//  Created by Javi on 18/02/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADVRoundProgressView.h"

@interface BankCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *bankName;
@property (nonatomic, weak) IBOutlet UILabel *percentage;
@property (nonatomic, weak) IBOutlet UILabel *value;
@property (strong, nonatomic) IBOutlet ADVRoundProgressView *roundProgressSmall;

@end
