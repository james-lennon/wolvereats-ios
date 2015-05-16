//
//  NoConnectionViewController.m
//  WolverEats
//
//  Created by Cameron Cohen and Amelia Miller on 2/6/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import "NoConnectionViewController.h"

@interface NoConnectionViewController ()

@end

@implementation NoConnectionViewController


- (id) init {
    if ((self = [super init])) {
        
        UILabel *welcome = [[UILabel alloc] initWithFrame:CGRectMake(50, 77, 200, 72)];
        welcome.text = @"No connection..chilll";
        welcome.textAlignment = NSTextAlignmentCenter;
        welcome.font = [UIFont systemFontOfSize:20];
        [self.view addSubview:welcome];

        
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *noConnection = [[UILabel alloc]initWithFrame:CGRectMake(130, 63, 341, 85)];
    noConnection.text = @"No Internet Connection";
    noConnection.font = [UIFont systemFontOfSize:40]; 
    
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
