//
//  BFViewController.m
//  iOSNotifier
//
/*Copyright [2012] [Dario Alessandro Lencina Talarico]
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.*/

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
    return TRUE;
}

- (IBAction)showNotification:(UIButton *)sender {
    InstructionsViewController * instructionViewController= [[InstructionsViewController alloc] initWithNibName:@"InstructionsView" bundle:nil];
    NSString * string= [NSString stringWithFormat:@"Text: %@", textToShow.text];
    NSInteger seconds= [numberOfSeconds.text integerValue];
    [instructionViewController showTheNextInstructions:string seconds:seconds];
}
@end
