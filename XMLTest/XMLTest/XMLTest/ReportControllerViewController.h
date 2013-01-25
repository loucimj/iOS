//
//  ReportControllerViewController.h
//  XMLTest
//
//  Created by Javier Loucim on 24/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportControllerViewController : UITableViewController {
    NSMutableArray *tableContent;
  
}
@property (nonatomic,strong) NSMutableDictionary *reportParameters;

@end
