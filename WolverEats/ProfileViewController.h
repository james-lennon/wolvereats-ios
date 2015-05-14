//
//  ProfileViewController.h
//  WolverEats
//
//  Created by Cameron Cohen on 3/2/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) UIImageView* profView;
@property (strong, nonatomic)UILabel *nameLabel;
@property (strong,nonatomic) NSDictionary *userInfo;
@property (strong,nonatomic) UIView* hLine;
@property (strong, nonatomic) UIView* vLine1;
@property (strong,nonatomic) UIView* vLine2;
@property (strong,nonatomic) UILabel* numTrips;
@property (strong, nonatomic) UILabel* numOrders;
@property (strong, nonatomic) UILabel* ratingNum;
@property (strong, nonatomic) UILabel* tripsLabel;
@property (strong, nonatomic) UILabel* ordersLabel;
@property (strong, nonatomic) UILabel* ratingsLabel;
@property (strong, nonatomic) UIView* whiteView;
@property (strong, nonatomic) UILabel* emailLabel;
@property (strong, nonatomic) UILabel* passLabel;
@property (strong, nonatomic) UILabel* email;
@property (strong, nonatomic) UILabel* pass;
@property (strong, nonatomic) UILabel* accountLabel;
@property (strong, nonatomic) UIView* hLine2;
@property (strong, nonatomic) UIView* hLine3;
@property (strong, nonatomic)   UIView* hLine4;
@property (strong, nonatomic) UILabel* phoneLabel;
@property (strong, nonatomic) UILabel* phone;
@property (strong, nonatomic) UIButton* editEmail;
@property (strong, nonatomic) UIButton* editPhone;
@property (strong, nonatomic) UIButton* editPass; 




@end
