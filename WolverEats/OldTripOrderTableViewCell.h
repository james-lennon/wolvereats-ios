//
//  OldTripOrderTableViewCell.h
//  WolverEats
//
//  Created by Miller on 4/14/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OldTripOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *orderLabel;
@property(nonatomic, strong) UIButton *acceptButton;
@property(nonatomic, strong) UIButton *declineButton;
@property(nonatomic, strong)UIImageView *accept;
@property(nonatomic, strong)UIImageView *decline;

@property(nonatomic ) NSString *name;
@property(nonatomic, strong) NSString *order;
@property(nonatomic) int orderID;
@property(nonatomic) int state;

@end
