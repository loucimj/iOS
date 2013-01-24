//
//  SimpleTableCell.m
//  XMLTest
//
//  Created by Javier Loucim on 20/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "SimpleTableCell.h"

@implementation SimpleTableCell

@synthesize title = _title;
@synthesize subtitle = _subtitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
