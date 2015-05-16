//
//  OldTripOrdersTableViewController.h
//  WolverEats
//
//  Created by Miller on 4/14/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OldTripOrdersTableViewController : UITableViewController

@property (nonatomic,strong) NSDictionary *tripData;
@property (nonatomic,strong) NSArray *acceptedOrderData;
@property (nonatomic,strong) NSArray *rejectedOrderData;


-(id)initWithData:(NSDictionary *)tripData;
@end
