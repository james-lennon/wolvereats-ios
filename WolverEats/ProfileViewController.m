//
//  ProfileViewController.m
//  WolverEats
//
//  Created by Cameron Cohen on 3/2/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "ProfileViewController.h"
#import "Backend.h"
#import <QuartzCore/QuartzCore.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController


- (id) init {
    if ((self = [super init])) {
        
        int w = self.view.bounds.size.width;
        int h = self.view.bounds.size.height;
        
        self.title = @"Profile";
        self.tabBarItem.image = [UIImage imageNamed:@"ProfileTab.png"];
        self.view.backgroundColor =  [UIColor colorWithRed:(42/255.0f) green:(179/255.0f) blue:(139/255.0f) alpha:1];
        
        _profView = [[UIImageView alloc] initWithFrame:CGRectMake(w/2 -35 , h/5 - 10, 75, 75)];
        _profView.layer.cornerRadius = _profView.frame.size.width / 2;
        _profView.clipsToBounds = YES;
        [_profView.layer setBorderColor:[[UIColor whiteColor]CGColor]];
        [_profView.layer setBorderWidth:2.0];
        
        
        NSURL *profURL = [NSURL URLWithString:@"http://placehold.it/75x75"];
        
        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(concurrentQueue, ^{
            NSData *image = [[NSData alloc] initWithContentsOfURL:profURL];
            
            
            //this will set the image when loading is finished
            dispatch_async(dispatch_get_main_queue(), ^{
               _profView.image = [UIImage imageWithData:image];
            });
        });
        
        [self.view addSubview:_profView];
        
        

        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, h/4 + 40, w, 50)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        
        _nameLabel.font = [UIFont systemFontOfSize:23];
        _nameLabel.textColor = [UIColor whiteColor];
        
        _hLine = [[UIView alloc]initWithFrame:CGRectMake(w/8, h/3 + 45, 6*w/8, 2)];
        _hLine.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
        [self.view addSubview:_hLine];
        
        _vLine1 = [[UIView alloc]initWithFrame:CGRectMake(3*w/8, h/3 +47, 2, 50)];
        _vLine1.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
        [self.view addSubview:_vLine1];
        
        _vLine2 = [[UIView alloc]initWithFrame:CGRectMake(5*w/8, h/3 +47, 2, 50)];
        _vLine2.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
        [self.view addSubview:_vLine2];
        

        _tripsLabel = [[UILabel alloc]initWithFrame:CGRectMake(w/8, h/3 + 77, 2*w/8, 20)];
        _tripsLabel.textColor = [UIColor whiteColor];
        _tripsLabel.text = @"trips";
        _tripsLabel.font = [UIFont systemFontOfSize:15];
        _tripsLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_tripsLabel];
        
        _ordersLabel = [[UILabel alloc]initWithFrame:CGRectMake(3*w/8, h/3 + 77, 2*w/8, 20)];
        _ordersLabel.textColor = [UIColor whiteColor];
        _ordersLabel.text = @"orders";
        _ordersLabel.font = [UIFont systemFontOfSize:15];
        _ordersLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_ordersLabel];
        
        _ratingsLabel = [[UILabel alloc]initWithFrame:CGRectMake(5*w/8, h/3 + 77, 2*w/8, 20)];
        _ratingsLabel.textColor = [UIColor whiteColor];
        _ratingsLabel.text = @"stars";
        _ratingsLabel.font = [UIFont systemFontOfSize:15];
        _ratingsLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_ratingsLabel];
        
        _numTrips = [[UILabel alloc]initWithFrame:CGRectMake(w/8, h/3 + 57, 2*w/8, 20)];
        _numTrips.textAlignment = NSTextAlignmentCenter;
        _numTrips.textColor = [UIColor whiteColor];
        _numTrips.font = [UIFont systemFontOfSize:22];
        
        _numOrders = [[UILabel alloc]initWithFrame:CGRectMake(3*w/8, h/3 + 57, 2*w/8, 20)];
        _numOrders.textAlignment = NSTextAlignmentCenter;
        _numOrders.textColor = [UIColor whiteColor];
        _numOrders.font = [UIFont systemFontOfSize:22];
        
        _ratingNum = [[UILabel alloc]initWithFrame:CGRectMake(5*w/8, h/3 + 57, 2*w/8, 20)];
        _ratingNum.textAlignment = NSTextAlignmentCenter;
        _ratingNum.textColor = [UIColor whiteColor];
        _ratingNum.font = [UIFont systemFontOfSize:22];
        _ratingNum.text = @"4.5";
        
        _whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 3*h/5, w, 2*h/5)];
        _whiteView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_whiteView];
        
        /*
        _accountLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 3*h/5 +10, w, 20)];
        _accountLabel.textAlignment = NSTextAlignmentLeft;
        _accountLabel.text = @"Account Information";
        _accountLabel.font = [UIFont systemFontOfSize:15];
        _accountLabel.textColor = [UIColor colorWithRed:(42/255.0f) green:(179/255.0f) blue:(139/255.0f) alpha:1];
        [self.view addSubview:_accountLabel]; */
        
        _emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(w/12, 3*h/5 + 20, w, 20)];
        _emailLabel.text = @"Email";
        _emailLabel.textColor = [UIColor colorWithRed:(42/255.0f) green:(179/255.0f) blue:(139/255.0f) alpha:1];
        _emailLabel.textAlignment = NSTextAlignmentLeft;
        _emailLabel.font = [UIFont systemFontOfSize:13];
        [self.view addSubview:_emailLabel];
        
        _email = [[UILabel alloc]initWithFrame:CGRectMake(w/12, 3*h/5 + 40, w, 20)];
        _email.textColor = [UIColor blackColor];
        _email.textAlignment = NSTextAlignmentLeft;
        _email.font = [UIFont systemFontOfSize:16];
        
        _hLine2 = [[UIView alloc]initWithFrame:CGRectMake(w/12, 3*h/5 + 70, 10*w/12, 2)];
        _hLine2.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        [self.view addSubview:_hLine2];
        
        _editEmail = [UIButton buttonWithType:UIButtonTypeSystem];
        _editEmail.frame = CGRectMake(10*w/12, 3*h/5 + 20, w/12, 40);
       // _editEmail.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_editEmail];
        
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(w/12, 3*h/5 + 80, w, 20)];
        _phoneLabel.text = @"Phone";
        _phoneLabel.textColor =[UIColor colorWithRed:(42/255.0f) green:(179/255.0f) blue:(139/255.0f) alpha:1];
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.font = [UIFont systemFontOfSize:13];
        [self.view addSubview:_phoneLabel];
        
        _phone = [[UILabel alloc]initWithFrame:CGRectMake(w/12, 3*h/5 + 100, w, 20)];
        _phone.textColor = [UIColor blackColor];
        _phone.text = @"310-804-9275"; // placeholder
        _phone.textAlignment = NSTextAlignmentLeft;
        _phone.font = [UIFont systemFontOfSize:16];
        
        _hLine4 = [[UIView alloc]initWithFrame:CGRectMake(w/12, 3*h/5 + 130, 10*w/12, 2)];
        _hLine4.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        [self.view addSubview:_hLine4];
        
        
        _passLabel = [[UILabel alloc]initWithFrame:CGRectMake(w/12, 3*h/5 + 140, w, 20)];
        _passLabel.text = @"Password";
        _passLabel.textColor = [UIColor colorWithRed:(42/255.0f) green:(179/255.0f) blue:(139/255.0f) alpha:1];
        _passLabel.textAlignment = NSTextAlignmentLeft;
        _passLabel.font = [UIFont systemFontOfSize:13];
        [self.view addSubview:_passLabel];
        
        _pass = [[UILabel alloc]initWithFrame:CGRectMake(w/12, 3*h/5 + 160, w, 20)];
        _pass.text = @"Greenstone007"; //placeholder
        _pass.textColor = [UIColor blackColor];
        _pass.textAlignment = NSTextAlignmentLeft;
        _pass.font = [UIFont systemFontOfSize:16];
        
        _hLine3 = [[UIView alloc]initWithFrame:CGRectMake(w/12, 3*h/5 + 190, 10*w/12, 2)];
        _hLine3.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        [self.view addSubview:_hLine3];
        
        
    
        
        
        [Backend sendRequestWithURL:@"users/get_current_user_content" Parameters:@{} Callback:^(NSDictionary * data) {
            _userInfo = data[@"user"];
            NSString* fName = _userInfo[@"first_name"];
            NSString* lName = _userInfo[@"last_name"];
            NSNumber* numTrips = data[@"num_trips"];
            NSNumber* numOrders = data[@"num_orders"];
            //NSString* pass = _userInfo[@"password"];
            NSString* email = _userInfo[@"email"];
            
            
            _nameLabel.text = [NSString stringWithFormat:@"%@ %@", fName, lName];
            _numTrips.text = [NSString stringWithFormat:@"%@", numTrips];
            _numOrders.text = [NSString stringWithFormat:@"%@", numOrders];
            //_pass.text = [NSString stringWithFormat:@"%@", pass];
             _email.text = [NSString stringWithFormat:@"%@", email];
            if ([numTrips intValue] == 1)
            {
                _tripsLabel.text = @"trip";
            }
            if ([numOrders intValue] == 1)
            {
                _ordersLabel.text = @"order";
            }
            
        }];
        
        
        [self.view addSubview:_nameLabel];
        [self.view addSubview:_numTrips];
        [self.view addSubview:_numOrders];
        [self.view addSubview:_ratingNum];
        [self.view addSubview:_email];
        [self.view addSubview:_pass];
        [self.view addSubview:_phone];
        
    
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
