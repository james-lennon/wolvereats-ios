//
//  WelcomeViewController.m
//  WolverEats
//
//  Created by James Lennon on 2/4/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int w = self.view.bounds.size.width;
    int h = self.view.bounds.size.height;
    
    UILabel *welcome = [[UILabel alloc]initWithFrame:CGRectMake(0, h/5, w, 100)];
    welcome.text = @"WolverEats";
    welcome.textAlignment = NSTextAlignmentCenter;
    welcome.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:welcome];
    
    UIButton *login = [[UIButton alloc]initWithFrame:CGRectMake(214, 466, 55, 30)];
    [login setTitle:@"login" forState:UIControlStateNormal];
    [self.view addSubview:login];
    
    UIButton *signup = [[UIButton alloc]initWithFrame:CGRectMake(346, 466, 43, 30)];
    [signup setTitle:@"signup" forState:UIControlStateNormal];
    [self.view addSubview:signup];
    // Do any additional setup after loading the view.
}

-(id)init{

    UILabel *welcome = [[UILabel alloc]initWithFrame:CGRectMake(157, 77, 287, 72)];
    welcome.text = @"WolverEats";
    welcome.textAlignment = NSTextAlignmentCenter;
    welcome.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:welcome];
    
    UIButton *login = [[UIButton alloc]initWithFrame:CGRectMake(214, 466, 55, 30)];
    [login setTitle:@"login" forState:UIControlStateNormal];
    
    UIButton *signup = [[UIButton alloc]initWithFrame:CGRectMake(346, 466, 43, 30)];
    [signup setTitle:@"signup" forState:UIControlStateNormal];

    
}- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showLogin:(id)sender {
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"login"] animated:YES completion:nil];
}
- (IBAction)showSignUp:(id)sender {
    [self presentViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"signup"] animated:YES completion:nil];
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
