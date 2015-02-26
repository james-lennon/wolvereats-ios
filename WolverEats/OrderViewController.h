//
//  OrderViewController.h
//  WolverEats
//
//  Created by Miller on 2/26/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController
@property NSDictionary* tripData;
@property NSDictionary* userData;
@property UITextView* orderText;
@property UIButton* doneButton;

@end
