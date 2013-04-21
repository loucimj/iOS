//
//  ProfileCell.h
//  Fitpulse
//
//  Created by Valentin Filip on 8/13/12.
//  Copyright (c) 2012 AppDesignVault. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADVProgressBar.h"

@interface ProfileCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descripcion;
@property (nonatomic, weak) IBOutlet UILabel *valor;
@property (strong, nonatomic) ADVProgressBar *progressBar;

@end
