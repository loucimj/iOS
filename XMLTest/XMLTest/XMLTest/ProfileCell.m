//
//  ProfileCell.m
//  Fitpulse
//
//  Created by Valentin Filip on 8/13/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import "ProfileCell.h"
#import "ADVProgressBar.h"


@interface ProfileCell ()

@end


@implementation ProfileCell
//@synthesize imgIcon;
//@synthesize titleLabel;

@synthesize progressBar;


- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    //self = [super awakeAfterUsingCoder:aDecoder];
    if (self) {
        self.progressBar = [[ADVProgressBar alloc] initWithFrame:CGRectMake(20, 30, 200, 20)];
        [self addSubview:self.progressBar];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
