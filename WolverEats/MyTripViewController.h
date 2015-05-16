//
//  MyTripViewController.h
//  WolverEats
//
//  Created by Cameron Cohen on 3/2/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol MyTripTableViewCellDelegate <NSObject>
//- (void)didClickOnAcceptOrder:(NSInteger)cellIndex withData:(id)data;
//@end

@interface MyTripViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong) NSDictionary *tripData;
@property (nonatomic, strong) NSArray *pendingOrderData;
@property (nonatomic, strong) NSArray *acceptedOrderData;
@property (nonatomic, strong) NSArray *rejectedOrderData;

- (id)initWithData:(NSDictionary *)tripData;
- (void)didClickOnAcceptOrder:(NSInteger)cellIndex withData:(id)data;

@end
