//
//  OrderViewController.h
//  WolverEats
//
//  Created by Miller on 2/26/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceOrderViewController : UIViewController <UIAlertViewDelegate>
@property NSDictionary* tripData;
@property NSDictionary* userData;
@property (strong, nonatomic) UILabel* orderLabel; 
@property UITextView* orderText;
@property UIButton* doneButton;

@end
