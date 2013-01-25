//
//  ReportCell.h
//  XMLTest
//
//  Created by Javier Loucim on 24/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *descripcion;
@property (nonatomic, weak) IBOutlet UILabel *valor;
@property (nonatomic, weak) IBOutlet UILabel *fecha;
@property (nonatomic, weak) IBOutlet UILabel *cuotas;

@end
