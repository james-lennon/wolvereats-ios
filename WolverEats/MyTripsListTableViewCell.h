//
//  MyTripListViewControllerCell.h
//  WolverEats
//
//  Created by Miller on 3/10/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTripsListTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *restaurantLabel;
@property (nonatomic, strong) UILabel *etaLabel;
@property(nonatomic, strong) UILabel *numOrdersLabel;

@property(nonatomic ) int eta;
@property(nonatomic, strong) NSString *restaurant;
@property(nonatomic) int numOrders;
@property (nonatomic, strong) NSString *tripStatus;


- (void)setEta:(int)eta;
- (void)setRestaurant:(NSString *)restaurant;
- (void)setNumOrders:(int)numOrders;


@end
