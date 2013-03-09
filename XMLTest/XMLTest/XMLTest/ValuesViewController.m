//
//  ValuesViewController.m
//  XMLTest
//
//  Created by Javier Loucim on 23/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "ValuesViewController.h"
#import "AddTicket.h"


@interface ValuesViewController ()

@end

@implementation ValuesViewController

@synthesize selectedCard;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
//        [value addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        //[value addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    /*
    IBOutlet UILabel *bank;
    IBOutlet UILabel *card;
    IBOutlet UIImageView *creditCardImage;
    IBOutlet UILabel *user;
    IBOutlet UILabel *dateSelection;
     */
    NSLog(@"received %@",selectedCard);

    NSString *title = [[NSString alloc] init];
    NSString *imageString = [[NSString alloc] init];
    NSDate *dateValue = [[NSDate alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //    title = [title stringByAppendingString: [dic objectForKey:@"card_type"]];
    title = [title stringByAppendingString:@"XXXX-"];
    title = [title stringByAppendingString:[selectedCard objectForKey:@"cc_number"]];
    
    bank.text = [selectedCard objectForKey:@"bank"];
    user.text = [selectedCard objectForKey:@"holder"];
    card.text = title;
    
    imageString = [imageString stringByAppendingString:[selectedCard objectForKey:@"card_type"]];
    imageString = [imageString stringByAppendingString:@".png"];
    
    creditCardImage.image = [UIImage imageNamed:imageString];
    
    dateValue = [selectedCard objectForKey:@"date"];
    [formatter setDateFormat:@"dd LLLL YYYY"];
    dateSelection.text = [formatter stringFromDate:dateValue ];
    leyenda.text=@"";

//    value.keyboardType = UIKeyboardTypeDecimalPad;
    
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) validateData  {
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSNumber *numberValue=[f numberFromString:value.text];
    NSNumber *cuotas = [f numberFromString:pagos.text];

    NSLog (@"%@ / %@" ,numberValue,cuotas);
    
    if ([numberValue intValue] <= 0 ) {
        leyenda.text = @"La compra no fue gratis! o si?";
        return NO;
    }
    
    if ([cuotas intValue] <= 0) {
        leyenda.text = @"Por lo menos fue en 1 pago!";
        pagos.text = @"1";
        return NO;
    }
    
    return YES;
}

- (void) updateLegend {
}

- (IBAction)buttonSave:(id)sender {
    
    
    NSLog(@"buttonSave pressed");
    
    if ([self validateData]) {
        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
        
        if (loadByTicket.on) {
            [temp setObject:@"" forKey:@"value_type"];
            [selectedCard addEntriesFromDictionary:temp];
        } else {
            [temp setObject:@"MONTHLY_PAYMENT" forKey:@"value_type"];
            [selectedCard addEntriesFromDictionary:temp];
        }
        [temp setObject:value.text forKey:@"value"];
        [selectedCard addEntriesFromDictionary:temp];
        
        [temp setObject:pagos.text forKey:@"payments"];
        [selectedCard addEntriesFromDictionary:temp];
        
        
        AddTicket *list = [[AddTicket alloc] init];
        
        NSDate *fecha = [selectedCard objectForKey:@"date"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        list.value = value.text;
        list.action = @"ADD";
        list.valueType = [selectedCard objectForKey:@"value_type"];
        list.ticketDate = [formatter stringFromDate:fecha];
        list.purchasedBy = [selectedCard objectForKey:@"holder"];
        list.creditCard = [selectedCard objectForKey:@"cc_id"];
        list.description = [selectedCard objectForKey:@"ticket_text"];
        list.payments = pagos.text;
        list.bypassCheck = @"";
        list.value = value.text;
        
        [list loadXML];
        
/*
        URL = [URL stringByAppendingString:@"&bypass_check"];
        URL = [URL stringByAppendingString:[ticketInfo objectForKey:@"bypass_check"]];
 */
        
        NSMutableDictionary *response = [[NSMutableDictionary alloc] init];
        
        if ([list.resultSet count] > 0) {
            response = [list.resultSet objectAtIndex:0];
            
            if ([response objectForKey:@"code"] != nil) {
                if ([[response objectForKey:@"code"] isEqualToString:@"1"]) {
                    leyenda.text = @"saved";
                    NSLog(@"save %@",selectedCard);
                    [self performSegueWithIdentifier:@"GoToReportSegue" sender:sender];
                } else {
                    leyenda.text = [response objectForKey:@"error"];
                    NSLog(@"save %@",[response objectForKey:@"error"]);
                }
            }
        } else {
            leyenda.text = @"Error enviando los datos!";
        }
        
    }
}

- (IBAction)textEdited:(id)sender {
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSNumber *numberValue=[f numberFromString:value.text];
    NSNumber *cuotas = [f numberFromString:pagos.text];
    NSNumber *resultado = [[NSNumber alloc] init];

    NSString *x = [[NSString alloc] init];
    float y;

    if (loadByTicket.on) {
        value.placeholder = @"valor del ticket";
        y = [numberValue floatValue] / [cuotas floatValue];
        resultado = [NSNumber numberWithFloat:y];
        
        NSLog(@"%@",resultado );
        if ([resultado intValue] <= 0) {
            leyenda.text = @"";
        } else {
            if ([cuotas intValue] != 1) {
                [f setNumberStyle:NSNumberFormatterCurrencyStyle];
                x =[x stringByAppendingString:@"Cuotas de "];
                x =[x stringByAppendingString:[f stringFromNumber:resultado]];
                leyenda.text = x;
            }
        }
    } else {
        value.placeholder = @"valor de la cuota";
        y = [numberValue floatValue] * [cuotas floatValue];
        resultado = [NSNumber numberWithFloat:y];
        if ([resultado intValue] <= 0) {
            leyenda.text = @"";
        } else {
            [f setNumberStyle:NSNumberFormatterCurrencyStyle];
            x =[x stringByAppendingString:@"Compra de "];
            x =[x stringByAppendingString:[f stringFromNumber:resultado]];
            leyenda.text = x;
        }
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@" ValuesViewController segue.identifier %@",segue.identifier);
    
    if([segue.identifier isEqualToString:@"GoToReportSegue"]){
        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
        
        
        [temp setObject:[selectedCard objectForKey:@"cc_id"] forKey:@"creditCardID"];

        [temp addEntriesFromDictionary:selectedCard];
        
        NSLog(@"sent %@",temp);
        //acceder a la primera instancia del tabcontroller

        
        [[[segue.destinationViewController childViewControllers] objectAtIndex:0] performSelector:@selector(setReportParameters:) withObject:temp];
        
//        [segue.destinationViewController performSelector:@selector(setReportParameters:) withObject:temp];
    }
    
}

@end
