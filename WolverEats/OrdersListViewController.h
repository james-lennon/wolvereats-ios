//
//  OrdersListViewController.h
//  WolverEats
//
//  Created by Cameron Cohen on 3/2/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrdersListViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray* tripsData;
@property (strong, nonatomic) NSArray* activeOrdersData;
@property (strong,nonatomic) NSArray* inactiveOrdersData;

@end
