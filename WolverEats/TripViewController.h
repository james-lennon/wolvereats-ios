//
//  TripViewController.h
//  WolverEats
//
//  Created by Cameron Cohen and Amelia Miller on 2/5/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripViewController : UIViewController

@property NSDictionary* tripData;
@property NSDictionary* userData;
@property UILabel* tripLabel; 
@property UILabel* nameLabel;
@property UILabel* expLabel;
@property UILabel* etaLabel;
@property UIButton *orderButton;
@property UIImageView *profView;

- (void)placeOrder;
- (id)initWithData:(NSDictionary *)tripData;



@end
