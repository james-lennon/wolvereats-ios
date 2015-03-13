//
//  OrderViewController.m
//  WolverEats
//
//  Created by Miller on 2/26/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "PlaceOrderViewController.h"
#import "Backend.h"
#import <QuartzCore/QuartzCore.h>
#import "ProfileViewController.h"

@interface PlaceOrderViewController ()

@end

@implementation PlaceOrderViewController

-(id)init {
    if ((self = [super init])){
    
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(dismissKeyboard)];
        
        [self.view addGestureRecognizer:tap];
        
        self.view.backgroundColor = [UIColor whiteColor];

        
        int w = self.view.bounds.size.width;
        int h = self.view.bounds.size.height;
        
        _orderLabel = [[UILabel alloc]initWithFrame:CGRectMake(w/5, h/4 -20, 3*w/5, 50)];
        _orderLabel.textColor = [UIColor blackColor];
        _orderLabel.textAlignment = NSTextAlignmentCenter;
        _orderLabel.text = @"Please provide a detailed description of your order.";
        _orderLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _orderLabel.numberOfLines = 0;
        [self.view addSubview:_orderLabel];
        
        
        _orderText = [[UITextView alloc]initWithFrame: CGRectMake(w/5, h/4 + 45, 3*w/5, 200)];
        _orderText.backgroundColor = [UIColor whiteColor];
        _orderText.textColor = [UIColor blackColor];
        //_orderText.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
        _orderText.textAlignment = NSTextAlignmentLeft;
        _orderText.returnKeyType = UIReturnKeyGo;
        [_orderText.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
        [_orderText.layer setBorderWidth:2.0];
        [self.view addSubview:_orderText];
    
        _doneButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _doneButton.frame = CGRectMake(0, 3*h/5 +50 , w, 100);
        [_doneButton setTitle:@"Place Order" forState:UIControlStateNormal];
        [_doneButton addTarget: self action:@selector(placeOrder) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_doneButton];
        
    }
    
        return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dismissKeyboard {
    [_orderText resignFirstResponder];

    
}

- (void)placeOrder {
    NSString* order = _orderText.text;
    NSInteger* fee1 = 3;
    NSNumber* fee2 = [NSNumber numberWithInteger:fee1];
    NSString *tripID = _tripData[@"trip_id"];
    [Backend sendRequestWithURL:@"orders/place_order" Parameters:@{@"order_text":order, @"fee":fee2, @"trip_id":tripID} Callback:^(NSDictionary * data){
    
    }];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Great!"
                                                    message:@"We've processed your order and will let you know when your driver accepts it!"
                                                   delegate:nil
                                          cancelButtonTitle:@"Okay"
                                          otherButtonTitles:nil];
    [alert show];
    
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


