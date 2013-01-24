//
//  SecondViewController.m
//  XMLTest
//
//  Created by Javi on 17/01/13.
//  Copyright (c) 2013 Javi. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController()


@end

@implementation SecondViewController

@synthesize selectedCard;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"received %@",selectedCard);
    
    NSString *title = [[NSString alloc] init];
//    NSString *subtitle = [[NSString alloc] init];
    NSString *imageString = [[NSString alloc] init];
    
    //    title = [title stringByAppendingString: [dic objectForKey:@"card_type"]];
    title = [title stringByAppendingString:@"XXXX-"];
    title = [title stringByAppendingString:[selectedCard objectForKey:@"cc_number"]];

    bank.text = [selectedCard objectForKey:@"bank"];
    user.text = [selectedCard objectForKey:@"holder"];
    card.text = title;
    
    imageString = [imageString stringByAppendingString:[selectedCard objectForKey:@"card_type"]];
    imageString = [imageString stringByAppendingString:@".png"];
    
    creditCardImage.image = [UIImage imageNamed:imageString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"segue.identifier %@",segue.identifier);
    
    if([segue.identifier isEqualToString:@"selectWhatSegue"]){
        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];

        [temp setObject:[dateSelection date] forKey:@"date"];
        [temp addEntriesFromDictionary:selectedCard];
        
        [segue.destinationViewController performSelector:@selector(setSelectedCard:) withObject:temp];
        
    }
    
}
@end
