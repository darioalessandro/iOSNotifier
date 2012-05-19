//
//  BFViewController.h
//  iOSNotifier
//
//  Created by Dario Lencina on 5/19/12.
//  Copyright (c) 2012 Dario Lencina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFViewController : UIViewController
- (IBAction)showNotification:(UIButton *)sender;
@property (retain, nonatomic) IBOutlet UITextField *textToShow;
@property (retain, nonatomic) IBOutlet UITextField *numberOfSeconds;

@end
