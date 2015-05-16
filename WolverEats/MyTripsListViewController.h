//
//  MyTripsListViewController.h
//  WolverEats
//
//  Created by Cameron Cohen on 3/2/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTripsListViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray* sections;
@property (strong, nonatomic) NSArray* activeTripsData;
@property (strong,nonatomic) NSArray* inactiveTripsData;
@property (strong,nonatomic) NSDictionary* orders;

@end
