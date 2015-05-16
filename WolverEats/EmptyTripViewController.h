//
//  EmptyTripViewController.h
//  WolverEats
//
//  Created by Miller on 3/12/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyTripViewController : UIViewController
- (id)initWithData:(NSDictionary *)tripData;
@property (strong,nonatomic) UIImageView *exclamation;

@end
