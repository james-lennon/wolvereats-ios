//
//  EmptyTripViewController.m
//  WolverEats
//
//  Created by Miller on 3/12/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "EmptyTripViewController.h"

@interface EmptyTripViewController ()

@end

@implementation EmptyTripViewController


- (id)initWithData:(NSDictionary *)tripData {
    if ((self = [super init]))
    {
        self.view.backgroundColor = [UIColor whiteColor];
        int w = self.view.bounds.size.width;
        int h = self.view.bounds.size.height;
        _exclamation = [[UIImageView alloc]initWithFrame:CGRectMake(w/2-50, h/5, 100, 100)];
        _exclamation.layer.cornerRadius = _exclamation.frame.size.width / 2;
        _exclamation.clipsToBounds = YES;
        _exclamation.backgroundColor = [UIColor whiteColor];
       _exclamation.image = [UIImage imageNamed:@"exclamation.png"];
        [self.view addSubview:_exclamation];

        
        
        
        
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
