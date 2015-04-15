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
@property(strong,nonatomic) NSDictionary *userInfo;


@end
