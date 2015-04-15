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
        
        [Backend sendRequestWithURL:@"users/get_current_user_content" Parameters:@{} Callback:^(NSDictionary * data) {
            _userInfo = data[@"user"];
            NSString* fName = _userInfo[@"first_name"];
            NSString* lName = _userInfo[@"last_name"];
            
            _profView = [[UIImageView alloc] initWithFrame:CGRectMake(w/2 -35 , h/5 - 20, 75, 75)];
            _profView.layer.cornerRadius = _profView.frame.size.width / 2;
            _profView.clipsToBounds = YES;
            [_profView.layer setBorderColor:[[UIColor blackColor]CGColor]];
            [_profView.layer setBorderWidth:2.0];
            [self.view addSubview:_profView];
            
            
            _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, h/4 + 30, w, 50)];
            _nameLabel.textAlignment = NSTextAlignmentCenter;
            _nameLabel.text = [NSString stringWithFormat:@"%@ %@", fName, lName];
            _nameLabel.font = [UIFont systemFontOfSize:25];
            _nameLabel.textColor = [UIColor blackColor];
            
            [self.view addSubview:_nameLabel];
        }];

     

      
    
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
