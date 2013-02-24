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
static NSMutableArray * notificationQueue;

@implementation InstructionsViewController
@synthesize timerCount, timerDuration;


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if(self){
		self.view.frame=CGRectMake(0, -100, 320, self.view.frame.size.height);
		if(!notificationQueue){
            notificationQueue=[NSMutableArray array];
        }
	}
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
												 name:UIDeviceOrientationDidChangeNotification object:nil];
	return self;
}

+(InstructionsViewController *)instructionsViewControllerInstance{
    InstructionsViewController * instructionViewController= [[InstructionsViewController alloc] initWithNibName:@"InstructionsView" bundle:nil];
    return instructionViewController;
}

-(void)showTheNextInstructions: (NSString *)instructions seconds: (NSInteger)secondsToShow{
    [self showTheNextInstructions:instructions seconds:secondsToShow locationInView:CGPointMake(0, 0)];
}

-(void)setHeightOfLineWithInstructions:(NSString *)instructions font:(UIFont *)font andSize:(CGSize)size{
	
	
}

-(void)showLoadingDataBaseInstructions{
	id delegate= [[UIApplication sharedApplication] delegate];
	[UIView beginAnimations:@"InstructionView" context:(__bridge void *)(self)];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
	UIActivityIndicatorView * activityView=	[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	[activityView startAnimating];
	activityView.frame= CGRectMake(250, 20, 40, 40);
	[self.view addSubview: activityView];
	[instructionsLabel setText:@"Cargando la base de datos..."];
	self.view.frame=CGRectMake(0, 140, 320, 200);
	[[delegate window] addSubview:self.view];
	[UIView commitAnimations];	
}

-(void)changeLabelText:(NSString *)text{
	instructionsLabel.text= text;
	[instructionsLabel setNeedsLayout];
}

-(void)killInstructions{
	[referenceTimer invalidate];
	[self.view removeFromSuperview];
    [notificationQueue removeObject:self];
}
	
-(void)showTheNextInstructions: (NSString *)instructions seconds: (NSInteger)secondsToShow locationInView: (CGPoint) point{
	timerCount= 0;
	timerDuration= secondsToShow;
	referenceTimer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerTick:) userInfo:self repeats:YES];	
	id delegate= [[UIApplication sharedApplication] delegate];
	[[delegate window] addSubview:self.view];
    [UIView transitionWithView:self.view duration:1 options:UIViewAnimationOptionTransitionCurlDown animations:^{
    [instructionsLabel setText:instructions];
    [self updateInstructionsViewWithOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
    } completion:^(BOOL finished) {
        
    }];
	
}

-(CGFloat)targetHeight{
    CGFloat height=0;
    if([[UIDevice currentDevice] userInterfaceIdiom]== UIUserInterfaceIdiomPad){
        if(UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])){
            height=1024;
        }else{
            height=768;
        }
    }else{
        if(UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])){
            height=480;
        }else{
            height=320;
        }
    }
    return height;
}

-(CGFloat)targetWidth{
    CGFloat width=0;
    if([[UIDevice currentDevice] userInterfaceIdiom]== UIUserInterfaceIdiomPad){
        if(UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
            width=1024;
        }else{
            width=768;
        }
    }else{
        if(UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
            width=480;
        }else{
            width=320;
        }
    }
    return width;
}

-(CGSize)constrainedSize{
    CGFloat width=100;
    CGFloat height=300;
    if([[UIDevice currentDevice] userInterfaceIdiom]== UIUserInterfaceIdiomPad){
        if(UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
            width=1024;
        }else{
            width=768;
        }
    }else{
        if(UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
            width=480;
        }else{
            width=320;
        }
    }
    return CGSizeMake(width, height);
}

-(CGFloat)yOrigin{
    __block CGFloat yOrigin=0;
    [notificationQueue enumerateObjectsUsingBlock:^(InstructionsViewController * obj, NSUInteger idx, BOOL *stop) {
    yOrigin+=obj.view.frame.size.height;
    }];
    NSLog(@"yOrigin %f", yOrigin);
    return yOrigin;
}

-(void)updateInstructionsViewWithOrientation:(UIInterfaceOrientation) orientation{
	CGFloat heightOfTextLine=0;
	CGSize instructionsLabelConstrainedSize;
	CGFloat widthOfInstructionsView;
	NSInteger heightofNavBarInLandscape=32;
	CGRect sizeOfStatusBar= [[UIApplication sharedApplication] statusBarFrame];
    widthOfInstructionsView= [self constrainedSize].width;
    CGFloat yOrigin=[self yOrigin];
		[self.view setTransform:CGAffineTransformIdentity];
    instructionsLabelConstrainedSize= CGSizeMake(widthOfInstructionsView, 300);
	if(orientation==UIInterfaceOrientationLandscapeLeft ){
		heightOfTextLine= [[instructionsLabel text] sizeWithFont:[instructionsLabel font] constrainedToSize: instructionsLabelConstrainedSize].height+5;
		self.view.frame=CGRectMake(sizeOfStatusBar.size.width - widthOfInstructionsView/2+heightOfTextLine/2+heightofNavBarInLandscape, widthOfInstructionsView/2 - heightOfTextLine/2 + yOrigin, widthOfInstructionsView, heightOfTextLine);
		[self.view setTransform:CGAffineTransformMakeRotation(-M_PI_2)];
	}
	if(orientation==UIInterfaceOrientationLandscapeRight){
        //podrido en iPad
		heightOfTextLine= [[instructionsLabel text] sizeWithFont:[instructionsLabel font] constrainedToSize: instructionsLabelConstrainedSize].height;
        if([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad)
        self.view.frame=CGRectMake(sizeOfStatusBar.size.width+ 164, widthOfInstructionsView/2 - heightOfTextLine/2, widthOfInstructionsView, heightOfTextLine);
        else
            self.view.frame=CGRectMake(sizeOfStatusBar.size.width, widthOfInstructionsView/2 - heightOfTextLine/2  + yOrigin, widthOfInstructionsView, heightOfTextLine);
		[self.view setTransform:CGAffineTransformMakeRotation(M_PI_2)];
	}
	if(orientation==UIInterfaceOrientationPortrait){
		heightOfTextLine= [[instructionsLabel text] sizeWithFont:[instructionsLabel font] constrainedToSize: instructionsLabelConstrainedSize].height;
		self.view.frame=CGRectMake(0, 64  + yOrigin, widthOfInstructionsView, heightOfTextLine);
	}
	if(orientation==UIInterfaceOrientationPortraitUpsideDown){
		heightOfTextLine= [[instructionsLabel text] sizeWithFont:[instructionsLabel font] constrainedToSize: instructionsLabelConstrainedSize].height;
		self.view.frame=CGRectMake(0, [self targetHeight]-44-20 + yOrigin, widthOfInstructionsView, heightOfTextLine);
		[self.view setTransform:CGAffineTransformMakeRotation(M_PI)];
	}
    NSLog(@"my frame %@", NSStringFromCGRect(self.view.frame));
    NSLog(@"frame %@", NSStringFromCGRect([[UIApplication sharedApplication] keyWindow].frame));
    NSLog(@"target %f", [self targetHeight]);
    [notificationQueue addObject:self];
}

-(void)orientationChanged:(NSNotification *)notification{
	@autoreleasepool {
		[self updateInstructionsViewWithOrientation:[[UIApplication sharedApplication] statusBarOrientation]];
	}
}

-(void)timerTick:(NSTimer*)theTimer{
	if(timerCount>timerDuration){
		[theTimer invalidate];
	}
	if(timerCount <= timerDuration){
		timerCount++;
	}else{
        [UIView animateWithDuration:1 animations:^{
            self.view.frame=CGRectMake(0, -100, 320, self.view.frame.size.height);
        } completion:^(BOOL finished) {
            [self killInstructions];
        }];
	}
}

@end
