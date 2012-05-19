//
//  InstructionsViewController.h
//  ChecarPlazasConFirma
//
//  Created by DARIO ALESSAN LENCINA TALARICO on 9/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface InstructionsViewController : UIViewController {
	IBOutlet UILabel * instructionsLabel;
	NSInteger timerCount;
	NSInteger timerDuration;
	NSTimer * referenceTimer;
}
-(void)changeLabelText:(NSString *)text;
@property (nonatomic, assign) NSInteger timerCount;
@property (nonatomic, assign) NSInteger timerDuration;
-(void) showTheNextInstructions: (NSString *)instructions seconds: (NSInteger)secondsToShow;
-(void) showTheNextInstructions: (NSString *)instructions seconds: (NSInteger)secondsToShow locationInView: (CGPoint) point;
-(void) showTheNextInstructions: (NSString *)instructions seconds: (NSInteger)secondsToShow orientation:(NSString *)orientationString;
-(void)timerTick:(NSTimer*)theTimer;
-(void) showLoadingDataBaseInstructions;
-(void)	killInstructions;
- (void)orientationChanged:(NSNotification *)notification;
-(void)updateInstructionsViewWithOrientation:(UIInterfaceOrientation) orientation;
-(void)setHeightOfLineWithInstructions:(NSString *)instructions font:(UIFont *)font andSize:(CGSize)size;
@end
