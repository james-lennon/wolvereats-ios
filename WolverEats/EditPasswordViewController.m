//
//  EditPasswordViewController.m
//  WolverEats
//
//  Created by Miller on 5/14/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import "EditPasswordViewController.h"
#import "ProfileViewController.h"
#import "Backend.h"
#import <QuartzCore/QuartzCore.h>

@interface EditPasswordViewController ()

@end

@implementation EditPasswordViewController

- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Update Password"; 
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
