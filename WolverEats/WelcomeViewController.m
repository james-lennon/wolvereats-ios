//
//  WelcomeViewController.m
//  WolverEats
//
//  Created by Cameron Cohen and Amelia Miller on 2/4/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LoginViewController.h"
#import "HWAuthenticationController.h"
#import "SignUpViewController.h"
#import "Backend.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController



- (id) init {
    if ((self = [super init])) {
        
        int w = self.view.bounds.size.width;
        int h = self.view.bounds.size.height;
        
        UILabel *welcome = [[UILabel alloc]initWithFrame:CGRectMake(0, h/5, w, 100)];
        welcome.text = @"WolverEats";
        welcome.textAlignment = NSTextAlignmentCenter;
        welcome.font = [UIFont systemFontOfSize:40];
        [self.view addSubview:welcome];
    
        UIButton *login = [UIButton buttonWithType:UIButtonTypeSystem];
        login.frame = CGRectMake(w/4, 3*h/5, w/4, 30);
        [login setTitle:@"Login" forState:UIControlStateNormal];
        [login addTarget:self action:@selector(showLogin) forControlEvents:UIControlEventTouchUpInside];

        UIButton *signup = [UIButton buttonWithType:UIButtonTypeSystem];
        signup.frame = CGRectMake(w/2, 3*h/5, w/4, 30);
        [signup setTitle:@"Sign Up" forState:UIControlStateNormal];
        [signup addTarget:self action:@selector(showSignUp) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:login];
        [self.view addSubview:signup];

        
    }
    
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    BOOL success = [Backend loadCredentials];
    if(success){
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showLogin {
    //LoginViewController *loginController = [[LoginViewController alloc] init];
    HWAuthenticationController *loginController = [[HWAuthenticationController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginController];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)showSignUp {
    SignUpViewController *signUpController = [[SignUpViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:signUpController];
    [self presentViewController:nav animated:YES completion:nil];
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
