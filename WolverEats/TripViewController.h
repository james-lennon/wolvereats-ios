//
//  TripViewController.h
//  WolverEats
//
//  Created by James Lennon on 2/5/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripViewController : UIViewController

@property NSDictionary* tripData;
@property NSDictionary* userData;
@property UILabel* nameLabel;
@property UILabel* expLabel;
@property UILabel* etaLabel;
@property UIButton *orderButton;

- (IBAction)placeOrder:(id)sender;
- (id)initWithData:(NSDictionary *)tripData;


@end
