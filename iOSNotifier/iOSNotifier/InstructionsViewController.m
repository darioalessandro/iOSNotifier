//
//  InstructionsViewController.m
//  ChecarPlazasConFirma

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

#import "InstructionsViewController.h"


@implementation InstructionsViewController
@synthesize timerCount, timerDuration;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if(self){
		self.view.frame=CGRectMake(0, -100, 320, 80);
		
	}
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
												 name:UIDeviceOrientationDidChangeNotification object:nil];
	return self;
}


-(void) showTheNextInstructions: (NSString *)instructions seconds: (NSInteger)secondsToShow{
//	DarioSharedPreprocessorDirectivesDebugLog(@"I got Called with %d seconds", secondsToShow);
	timerCount= 0;
	timerDuration= secondsToShow;

	referenceTimer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTick:) userInfo:self repeats:YES];	
	id delegate= [[[UIApplication sharedApplication] delegate] retain];
	[UIView beginAnimations:@"InstructionView" context:self];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
	[instructionsLabel setText:instructions];
	[self updateInstructionsViewWithOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
	[[delegate window] addSubview:self.view];
	[UIView commitAnimations];
	[delegate release];
}

-(void)setHeightOfLineWithInstructions:(NSString *)instructions font:(UIFont *)font andSize:(CGSize)size{
	
	
}

-(void) showTheNextInstructions: (NSString *)instructions seconds: (NSInteger)secondsToShow orientation:(NSString *)orientationString{
	//	DarioSharedPreprocessorDirectivesDebugLog(@"I got Called with %d seconds", secondsToShow);
	timerCount= 0;
	timerDuration= secondsToShow;
	referenceTimer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTick:) userInfo:self repeats:YES];	
	id delegate= [[[UIApplication sharedApplication] delegate] retain];
	[UIView beginAnimations:@"InstructionView" context:self];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
	[instructionsLabel setText:instructions];
	[self updateInstructionsViewWithOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
	[[delegate window] addSubview:self.view];
	[UIView commitAnimations];
	[delegate release];
}

-(void) showLoadingDataBaseInstructions{
	id delegate= [[[UIApplication sharedApplication] delegate] retain];
	[UIView beginAnimations:@"InstructionView" context:self];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
	UIActivityIndicatorView * activityView=	[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	[activityView startAnimating];
	activityView.frame= CGRectMake(250, 20, 40, 40);
	[self.view addSubview: activityView];
	[activityView release];
	[instructionsLabel setText:@"Cargando la base de datos..."];
	self.view.frame=CGRectMake(0, 140, 320, 200);
	[[delegate window] addSubview:self.view];
	[UIView commitAnimations];
	[delegate release];
	
}

-(void)changeLabelText:(NSString *)text{
	instructionsLabel.text= text;
	[instructionsLabel setNeedsLayout];
}

-(void) killInstructions{
	[referenceTimer invalidate];
	[self.view removeFromSuperview];
}
	
-(void) showTheNextInstructions: (NSString *)instructions seconds: (NSInteger)secondsToShow locationInView: (CGPoint) point{
	//	DarioSharedPreprocessorDirectivesDebugLog(@"I got Called with %d seconds", secondsToShow);
	timerCount= 0;
	timerDuration= secondsToShow;
	referenceTimer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTick:) userInfo:self repeats:YES];	
	id delegate= [[[UIApplication sharedApplication] delegate] retain];
	[UIView beginAnimations:@"InstructionView" context:self];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
	[instructionsLabel setText:instructions];
	self.view.frame=CGRectMake(point.x, point.y, 320, 80);
	[[delegate window] addSubview:self.view];
	[UIView commitAnimations];
	[delegate release];
	
}

-(void)updateInstructionsViewWithOrientation:(UIInterfaceOrientation) orientation{
	CGFloat heightOfTextLine=0;
	CGSize instructionsLabelConstrainedSize;
	CGFloat widthOfInstructionsView;
	NSInteger heightofNavBarInLandscape=32;
	CGRect sizeOfStatusBar= [[UIApplication sharedApplication] statusBarFrame];

	if(orientation==UIInterfaceOrientationLandscapeLeft ){
		[self.view setTransform:CGAffineTransformIdentity];
		widthOfInstructionsView= 1024;
		instructionsLabelConstrainedSize= CGSizeMake(widthOfInstructionsView, 300);
		heightOfTextLine= [[instructionsLabel text] sizeWithFont:[instructionsLabel font] constrainedToSize: instructionsLabelConstrainedSize].height+5;
		self.view.frame=CGRectMake(sizeOfStatusBar.size.width - widthOfInstructionsView/2+heightOfTextLine/2+heightofNavBarInLandscape, widthOfInstructionsView/2 - heightOfTextLine/2, widthOfInstructionsView, heightOfTextLine);
		instructionsLabel.frame= CGRectMake(5, 0, widthOfInstructionsView-2.5, heightOfTextLine);
		[self.view setTransform:CGAffineTransformMakeRotation(-90*2*3.1415/360)];
	}
	if(orientation==UIInterfaceOrientationLandscapeRight){
		[self.view setTransform:CGAffineTransformIdentity];
		widthOfInstructionsView= 1024;
		instructionsLabelConstrainedSize= CGSizeMake(widthOfInstructionsView, 300);
		heightOfTextLine= [[instructionsLabel text] sizeWithFont:[instructionsLabel font] constrainedToSize: instructionsLabelConstrainedSize].height;
		//self.view.frame=CGRectMake(-sizeOfStatusBar.size.width + widthOfInstructionsView/2- heightOfTextLine/2-160-heightofNavBarInLandscape, widthOfInstructionsView/2 - heightOfTextLine/2, widthOfInstructionsView, heightOfTextLine);
		self.view.frame=CGRectMake(180, widthOfInstructionsView/2 - heightOfTextLine/2, widthOfInstructionsView, heightOfTextLine);
		instructionsLabel.frame= CGRectMake(5, 0, widthOfInstructionsView-2.5, heightOfTextLine);
		[self.view setTransform:CGAffineTransformMakeRotation(90*2*3.1415/360)];
	}
	if(orientation==UIInterfaceOrientationPortrait){
		[self.view setTransform:CGAffineTransformIdentity];
		widthOfInstructionsView= 1024;
		instructionsLabelConstrainedSize= CGSizeMake(widthOfInstructionsView, 300);
		heightOfTextLine= [[instructionsLabel text] sizeWithFont:[instructionsLabel font] constrainedToSize: instructionsLabelConstrainedSize].height;
		self.view.frame=CGRectMake(0, 64, widthOfInstructionsView, heightOfTextLine);
		instructionsLabel.frame= CGRectMake(5, 0, widthOfInstructionsView-2.5, heightOfTextLine);
	}
	if(orientation==UIInterfaceOrientationPortraitUpsideDown){
		[self.view setTransform:CGAffineTransformIdentity];
		widthOfInstructionsView= 1024;
		instructionsLabelConstrainedSize= CGSizeMake(widthOfInstructionsView, 300);
		heightOfTextLine= [[instructionsLabel text] sizeWithFont:[instructionsLabel font] constrainedToSize: instructionsLabelConstrainedSize].height;
		self.view.frame=CGRectMake(0, 395, widthOfInstructionsView, heightOfTextLine);
		instructionsLabel.frame= CGRectMake(5, 0, widthOfInstructionsView-2.5, heightOfTextLine);
		[self.view setTransform:CGAffineTransformMakeRotation(180*2*3.1415/360)];
	}
//	DarioSharedPreprocessorDirectivesDebugLog(@"Frame que entrego %f %f %f %f con orientacion %d",  self.view.frame.origin.x, self.view.frame.origin.y,  self.view.frame.size.height,self.view.frame.size.width, orientation);
}

- (void)orientationChanged:(NSNotification *)notification
{
	NSAutoreleasePool * pool= [[NSAutoreleasePool alloc] init];
	//[self updateInstructionsViewWithOrientation:[[notification object] orientation]];
	[self updateInstructionsViewWithOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
	[pool release];
}

-(void)timerTick:(NSTimer*)theTimer{
	if(timerCount>timerDuration){
		[theTimer invalidate];
	}
	
	if(timerCount <= timerDuration){
		timerCount++;
//		DarioSharedPreprocessorDirectivesDebugLog(@"Tick after %d seconds", timerCount);
	}else{
		[UIView beginAnimations:@"InstructionView" context:self];
		[UIView setAnimationDuration:1];
		[UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
		[self.view setTransform:CGAffineTransformIdentity];
		self.view.frame=CGRectMake(0, -100, 320, 80);
		instructionsLabel.frame=CGRectMake(0, -100, 320, 80);
		[UIView commitAnimations];
	}
}

-(void)dealloc{
//	DarioSharedPreprocessorDirectivesDebugLog(@"Instrucciones mueren");
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[instructionsLabel release], instructionsLabel=nil;
	[super dealloc];
}
@end
