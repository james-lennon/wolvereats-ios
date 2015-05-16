//
//  EditEmailViewController.m
//  WolverEats
//
//  Created by Miller on 5/14/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "EditEmailViewController.h"
#import "ProfileViewController.h"
#import "Backend.h"
#import <QuartzCore/QuartzCore.h>

@interface EditEmailViewController ()

@end

@implementation EditEmailViewController

- (id) init {
    if ((self = [super init])) {
        
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Update Email";
        
        int h = self.view.bounds.size.height;
        int w = self.view.bounds.size.width;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(dismissKeyboard)];
        
        [self.view addGestureRecognizer:tap];
        
        _email = [[UITextField alloc]initWithFrame:CGRectMake(w/10, h/5 + 20, 8*w/10, 40)];
        _email.backgroundColor = [UIColor whiteColor];
        _email.borderStyle = UITextBorderStyleRoundedRect;
        _email.textAlignment = NSTextAlignmentLeft;
        _email.placeholder = @"New Email";
        _email.textColor = [UIColor blackColor];
        _email.clearButtonMode = UITextFieldViewModeWhileEditing;
        _email.keyboardType = UIKeyboardTypeEmailAddress;
        _email.tag = 1;
        _email.autocorrectionType = UITextAutocorrectionTypeNo;
        [self.view addSubview:_email];
        
        _confirm = [[UITextField alloc]initWithFrame:CGRectMake(w/10, h/5 + 80, 8*w/10, 40)];
        _confirm.backgroundColor = [UIColor whiteColor];
        _confirm.borderStyle = UITextBorderStyleRoundedRect;
        _confirm.textAlignment = NSTextAlignmentLeft;
        _confirm.placeholder = @"Confirm Email";
        _confirm.textColor = [UIColor blackColor];
        _confirm.clearButtonMode = UITextFieldViewModeWhileEditing;
        _confirm.keyboardType = UIKeyboardTypeEmailAddress;
        _confirm.tag = 2;
        _confirm.autocorrectionType = UITextAutocorrectionTypeNo;
        [self.view addSubview:_confirm];
        
        _saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _saveButton.frame = CGRectMake(w/2 - 60, 2*h/6 + 60, 120, 40);
        [_saveButton setTitle:@"Save" forState:UIControlStateNormal];
        _saveButton.backgroundColor = [UIColor colorWithRed:(42/255.0f) green:(179/255.0f) blue:(139/255.0f) alpha:1];
        _saveButton.layer.cornerRadius = 15;
        [_saveButton setTintColor: [UIColor whiteColor]];
        [_saveButton addTarget: self action:@selector(setEmail) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_saveButton];
        

    
    }
    return self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setEmail
{
    NSString* email = _email.text;
    NSString* confirm = _confirm.text;
    [Backend sendRequestWithURL:@"users/set_email" Parameters:@{@"new_email":email} Callback:^(NSDictionary * data) {
        [Backend updateEmail:email];
    }];
    

    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)dismissKeyboard {
    [_emailq resignFirstResponder];
    [_confirm resignFirstResponder];
    
    
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
