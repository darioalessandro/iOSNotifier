//
//  InstructionsViewController.h
//  ChecarPlazasConFirma
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

#import <Foundation/Foundation.h>

@interface InstructionsViewController : UIViewController {
	IBOutlet UILabel * instructionsLabel;
	NSInteger timerCount;
	NSInteger timerDuration;
	NSTimer * referenceTimer;
}

+(InstructionsViewController *)instructionsViewControllerInstance;
-(void)changeLabelText:(NSString *)text;
@property (nonatomic, assign) NSInteger timerCount;
@property (nonatomic, assign) NSInteger timerDuration;
-(void) showTheNextInstructions: (NSString *)instructions seconds: (NSInteger)secondsToShow;
-(void) showTheNextInstructions: (NSString *)instructions seconds: (NSInteger)secondsToShow locationInView: (CGPoint) point;
-(void) showLoadingDataBaseInstructions;
-(void)	killInstructions;
@end
