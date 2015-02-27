//
//  ProfileViewController.m
//  WolverEats
//
//  Created by Cameron Cohen on 2/20/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "ProfileViewController.h"
#import "WelcomeViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id) init {
    if ((self = [super init])) {
        
        self.title = @"Profile";

        
        int w = self.view.bounds.size.width;
        int h = self.view.bounds.size.height;
        
        UILabel *loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,77,21)];
        loadingLabel.center = CGPointMake(w/2, h/2);
        loadingLabel.text = @"Loading...";
        loadingLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:loadingLabel];
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
