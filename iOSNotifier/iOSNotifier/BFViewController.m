//
//  BFViewController.m
//  iOSNotifier
//
//  Created by Dario Lencina on 5/19/12.
//  Copyright (c) 2012 Dario Lencina. All rights reserved.
//

#import "BFViewController.h"
#import "InstructionsViewController.h"

@interface BFViewController ()

@end

@implementation BFViewController
@synthesize textToShow;
@synthesize numberOfSeconds;

-(NSString *)title{
    return @"iOS Notifier";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setTextToShow:nil];
    [self setNumberOfSeconds:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    }
}

- (IBAction)showNotification:(UIButton *)sender {
    InstructionsViewController * instructionViewController= [[InstructionsViewController alloc] initWithNibName:@"InstructionsView" bundle:nil];
    NSString * string= [NSString stringWithFormat:@"Text: %@", textToShow.text];
    NSInteger seconds= [numberOfSeconds.text integerValue];
    [instructionViewController showTheNextInstructions:string seconds:seconds];
    [instructionViewController autorelease];
}
- (void)dealloc {
    [textToShow release];
    [numberOfSeconds release];
    [super dealloc];
}
@end
