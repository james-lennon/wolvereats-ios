//
//  OrderViewController.m
//  WolverEats
//
//  Created by Miller on 2/26/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "OrderViewController.h"

@interface OrderViewController ()

@end

@implementation OrderViewController

-(id)init {
    if ((self = [super init])){
    
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(dismissKeyboard)];
        
        [self.view addGestureRecognizer:tap];

        
        int w = self.view.bounds.size.width;
        int h = self.view.bounds.size.height;
        
        _orderText = [[UITextView alloc]initWithFrame: CGRectMake(w/5, h/4, 3*w/5, 200)];
        _orderText.backgroundColor = [UIColor whiteColor];
        _orderText.textColor = [UIColor blackColor];
        _orderText.textAlignment = NSTextAlignmentLeft;
        _orderText.returnKeyType = UIReturnKeyGo;
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
    float fee = 3;
    int driverID = _tripData[@"trip_id"];
                             
    

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
