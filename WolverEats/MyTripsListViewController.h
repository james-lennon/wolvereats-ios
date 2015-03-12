//
//  MyTripsListViewController.h
//  WolverEats
//
//  Created by Cameron Cohen on 3/2/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTripsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray* sections;
@property (strong, nonatomic) NSArray* activeTripsData;
@property (strong,nonatomic) NSArray* oldTripsData; 
@property (strong,nonatomic) NSDictionary* orders;
@property (strong, nonatomic) UITableView *tableView;

@end
