//
//  BSViewController.m
//  ProgressDemo
//
//  Created by Balica S on 18/06/2014.
//  Copyright (c) 2014 Balica Stefan. All rights reserved.
//

#import "BSViewController.h"
#import "BSProgressSpeedIndicator.h"

@interface BSViewController ()


@property (nonatomic, strong) BSProgressSpeedIndicator *progrView;
@end

@implementation BSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _progrView = [[BSProgressSpeedIndicator alloc] initWithFrame:CGRectMake(10, 160, 300, 300)];
    
    [_progrView showWithProgress:0.75f onView:self.view];
    
    
    
}

- (IBAction)changeProgress:(id)sender {
    
    switch ([sender tag]) {
        case 1:
            [_progrView setBarProgress:0.1f animate:YES];
            break;
        case 2:
            [_progrView setBarProgress:0.5f animate:NO];
            break;
        case 3:
            [_progrView setBarProgress:0.85f animate:YES];
            break;
            
        default:
            break;
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
