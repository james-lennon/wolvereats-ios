//
//  OrderListTableViewCell.h
//  WolverEats
//
//  Created by Cameron Cohen on 3/3/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *restaurantLabel;
@property (nonatomic, strong) UILabel *orderLabel;
@property(nonatomic, strong) UIImageView *orderStatus;

@property(nonatomic) int eta;
@property(nonatomic, strong) NSString *restaurant;
@property(nonatomic) int orderState;
@property(nonatomic, strong) NSString *orderText; 

@end
