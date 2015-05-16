//
//  EditPhoneViewController.m
//  WolverEats
//
//  Created by Miller on 5/14/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "EditPhoneViewController.h"
#import "ProfileViewController.h"
#import "Backend.h"
#import <QuartzCore/QuartzCore.h>

@interface EditPhoneViewController ()

@end

@implementation EditPhoneViewController

- (id) init{
    if ((self = [super init])) {

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Update Phone";
    
    int h = self.view.bounds.size.height;
    int w = self.view.bounds.size.width;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    _phoneNumber = [[UITextField alloc]initWithFrame:CGRectMake(w/10, h/5 + 20, 8*w/10, 40)];
    _phoneNumber.backgroundColor = [UIColor whiteColor];
    _phoneNumber.borderStyle = UITextBorderStyleRoundedRect;
    _phoneNumber.textAlignment = NSTextAlignmentLeft;
    _phoneNumber.placeholder = @"New Phone Number";
    _phoneNumber.textColor = [UIColor blackColor];
    _phoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    _phoneNumber.tag = 1;
    [self.view addSubview:_phoneNumber];
    
    _confirm = [[UITextField alloc]initWithFrame:CGRectMake(w/10, h/5 + 80, 8*w/10, 40)];
    _confirm.backgroundColor = [UIColor whiteColor];
    _confirm.borderStyle = UITextBorderStyleRoundedRect;
    _confirm.textAlignment = NSTextAlignmentLeft;
    _confirm.placeholder = @"Confirm Phone Number";
    _confirm.textColor = [UIColor blackColor];
    _confirm.clearButtonMode = UITextFieldViewModeWhileEditing;
    _confirm.keyboardType = UIKeyboardTypeNumberPad;
    _confirm.tag = 2;
    [self.view addSubview:_confirm];
    
    _updateButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _updateButton.frame = CGRectMake(w/2 - 60, 2*h/6 + 60, 120, 40);
    [_updateButton setTitle:@"Save" forState:UIControlStateNormal];
    _updateButton.backgroundColor = [UIColor colorWithRed:(42/255.0f) green:(179/255.0f) blue:(139/255.0f) alpha:1];
    _updateButton.layer.cornerRadius = 15;
    [_updateButton setTintColor: [UIColor whiteColor]];
    [_updateButton addTarget: self action:@selector(setPhone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_updateButton];
    
    
    }
    return  self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreaed.
}

-(void)setPhone{
    NSString* phone = _phoneNumber.text;
    NSString* confirm = _confirm.text;
    
    if (!([phone isEqualToString:confirm]))
    {
        NSLog(@"numbers do not match");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Update!"
                                                       message:@"Your numbers do not match. Please check and correct them."
                                                      delegate:self
                                             cancelButtonTitle:@"Okay"
                                             otherButtonTitles: nil];
        [alert show];
    }
    else if (!(phone.length == 10) || !(confirm.length == 10))
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Update!"
                                                       message:@"Your phone number should have 10 digits."
                                                      delegate:self
                                             cancelButtonTitle:@"Okay"
                                             otherButtonTitles: nil];
        [alert show];
    }
    else{
    
    
    [Backend sendRequestWithURL:@"users/set_phone" Parameters:@{@"phone":phone} Callback:^(NSDictionary * data) {
        
    }];
        [self.navigationController popToRootViewControllerAnimated:YES]; 
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString* totalString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    
    if (range.length == 1) {
        // Delete button was hit.. so tell the method to delete the last char.
        textField.text = [self formatPhoneNumber:totalString deleteLastChar:YES];
    } else {
        textField.text = [self formatPhoneNumber:totalString deleteLastChar:NO ];
    }
    return YES;
}

-(NSString*) formatPhoneNumber:(NSString*) simpleNumber deleteLastChar:(BOOL)deleteLastChar {
    if(simpleNumber.length==0) return @"";
    // use regex to remove non-digits(including spaces) so we are left with just the numbers
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\\s-\\(\\)]" options:NSRegularExpressionCaseInsensitive error:&error];
    simpleNumber = [regex stringByReplacingMatchesInString:simpleNumber options:0 range:NSMakeRange(0, [simpleNumber length]) withTemplate:@""];
    
    // check if the number is to long
    if(simpleNumber.length>10) {
        // remove last extra chars.
        simpleNumber = [simpleNumber substringToIndex:10];
    }
    
    if(deleteLastChar) {
        // should we delete the last digit?
        simpleNumber = [simpleNumber substringToIndex:[simpleNumber length] - 1];
    }
    
    // 123 456 7890
    // format the number.. if it's less then 7 digits.. then use this regex.
    if(simpleNumber.length<7)
        simpleNumber = [simpleNumber stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d+)"
                                                               withString:@"($1) $2"
                                                                  options:NSRegularExpressionSearch
                                                                    range:NSMakeRange(0, [simpleNumber length])];
    
    else   // else do this one..
        simpleNumber = [simpleNumber stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d{3})(\\d+)"
                                                               withString:@"($1) $2-$3"
                                                                  options:NSRegularExpressionSearch
                                                                    range:NSMakeRange(0, [simpleNumber length])];
    return simpleNumber;
}

-(void)dismissKeyboard {
    [_phoneNumber resignFirstResponder];
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
