//
//  ReportCell.h
//  XMLTest
//
//  Created by Javier Loucim on 24/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADVRoundProgressView.h"

@interface ReportCell : UITableViewCell


@property (nonatomic, weak) IBOutlet UIImageView *cardImage;
@property (nonatomic, weak) IBOutlet UILabel *descripcion;
@property (nonatomic, weak) IBOutlet UILabel *valor;
@property (nonatomic, weak) IBOutlet UILabel *fecha;
@property (nonatomic, weak) IBOutlet UILabel *cuotas;
@property (nonatomic, weak) IBOutlet UILabel *cuotasProgress;
@property (nonatomic, weak) IBOutlet UILabel *valorAPagar;
@property (nonatomic, weak) IBOutlet UILabel *bankName;
@property (nonatomic, weak) IBOutlet UILabel *cardHolder;
@property (nonatomic, weak) IBOutlet UILabel *cardNumber;
@property (strong, nonatomic) IBOutlet ADVRoundProgressView *roundProgressSmall;


@end
