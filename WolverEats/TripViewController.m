//
//  TripViewController.m
//  WolverEats
//
//  Created by Cameron Cohen and Amelia Miller on 2/5/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import "TripViewController.h"
#import "TripsListViewController.h"
#import "Backend.h"
#import "PlaceOrderViewController.h"
#import "NSDate+Helper.h"

@interface TripViewController ()

@end

@implementation TripViewController

- (id)initWithData:(NSDictionary *)tripData {
    if ((self = [super init]))
    {
        
    self.title = _tripData[@"restuarant_name"]; 
    _tripData = tripData;
    
    int w = self.view.bounds.size.width;
    int h = self.view.bounds.size.height;
        
        self.view.backgroundColor = [UIColor whiteColor]; 

    _profView = [[UIImageView alloc] initWithFrame:CGRectMake(w/2 -35 , h/5 -60, 75, 75)];
    _profView.layer.cornerRadius = _profView.frame.size.width / 2;
    _profView.clipsToBounds = YES;
    _profView.backgroundColor = [UIColor redColor];
    //[self.view addSubview:_profView];
 
        
    _tripLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, h/5, w, 100)];
    _tripLabel.text = _tripData[@"restaurant_name"];
    _tripLabel.textAlignment = NSTextAlignmentCenter;
    _tripLabel.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:_tripLabel];
    
    UILabel *from = [[UILabel alloc]initWithFrame:CGRectMake(w/4, h/5+75, w/2, 40)];
    from.text = @"from";
    from.font = [UIFont systemFontOfSize:20];
    from.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:from]; 
    
    
    _expLabel = [[UILabel alloc]initWithFrame:CGRectMake(w/4, h/2, w/2, 50)];
    int expiration = [_tripData[@"expiration"] intValue];
    NSDate *expDate = [NSDate dateWithTimeIntervalSince1970:expiration];
    NSString *expText = [NSDate stringForDisplayFromDate:expDate prefixed:YES alwaysDisplayTime:YES];
    NSString *expString = @"Order By: ";
    _expLabel.text = [NSString stringWithFormat:@"%@%@", expString,expText];
    _expLabel.textAlignment = NSTextAlignmentCenter;
    _expLabel.font = [UIFont systemFontOfSize:20];
    _expLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:_expLabel];
        
    _etaLabel = [[UILabel alloc]initWithFrame:CGRectMake(w/4, h/2 +50, w/2, 50)];
    int eta = [_tripData[@"eta"] intValue];
    NSDate *etaDate = [NSDate dateWithTimeIntervalSince1970:eta];
    NSString *etaText = [NSDate stringForDisplayFromDate:etaDate prefixed:YES alwaysDisplayTime:YES];
    NSString *etaString = @"Arrive By: ";
    _etaLabel.text = [NSString stringWithFormat:@"%@%@", etaString,etaText];
    _etaLabel.textAlignment = NSTextAlignmentCenter;
    _etaLabel.font = [UIFont systemFontOfSize:20];
    _etaLabel.adjustsFontSizeToFitWidth = YES;

    
    [self.view addSubview:_etaLabel];
    
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, h/5+110 , w, 50)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = [UIFont systemFontOfSize:30];
        
    NSString* firstName = tripData[@"first_name"];
    NSString* lastName = tripData[@"last_name"];
    _nameLabel.text = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    [self.view addSubview:_nameLabel];
    
    
    _orderButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _orderButton.frame = CGRectMake(w/2 - 60, 3*h/5 + 70, 120, 40);
    _orderButton.backgroundColor = [UIColor colorWithRed:(42/255.0f) green:(179/255.0f) blue:(139/255.0f) alpha:1];
    _orderButton.layer.cornerRadius = 15;
        [_orderButton setTintColor: [UIColor whiteColor]];
    [_orderButton setTitle:@"Place Order" forState:UIControlStateNormal];
    [_orderButton addTarget: self action:@selector(placeOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_orderButton];
        
    }
    
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)placeOrder {
    PlaceOrderViewController *placeOrderController = [[PlaceOrderViewController alloc] init];
    placeOrderController.tripData = _tripData;
    placeOrderController.userData = _userData;
    
    [self.navigationController pushViewController:placeOrderController animated:YES];
   
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
