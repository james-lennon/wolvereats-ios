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
@property (weak, nonatomic) IBOutlet UILabel *tripLabel;
@property (weak, nonatomic) IBOutlet UILabel *expLabel;
@property (weak, nonatomic) IBOutlet UILabel *etaLabel;

@end
