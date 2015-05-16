//
//  TripsListTableViewCell.h
//  WolverEats
//
//  Created by Cameron Cohen on 2/23/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TripsListTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *restaurantLabel;
@property (nonatomic, strong) UILabel *driverName;
@property (nonatomic, strong) UILabel *etaLabel;
@property (nonatomic, strong) UIImageView *profView;

@property(nonatomic ) int eta;
@property(nonatomic, strong) NSString *restaurant;
@property(nonatomic) int numOrders;
@property (nonatomic, strong) NSString *tripStatus;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *profImage;


@end
