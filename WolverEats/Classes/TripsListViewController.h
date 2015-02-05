//
//  TripsListViewController.h
//  WolverEats
//
//  Created by James Lennon on 2/4/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property NSArray* tripsData;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
