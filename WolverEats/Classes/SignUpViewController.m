//
//  SignUpViewController.m
//  WolverEats
//
//  Created by Cameron Cohen and Amelia Miller on 2/3/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import <MBProgressHUD.h>
#import "SignUpViewController.h"
#import "Backend.h"
#import "LoginViewController.h"

#define BANNERHEIGHT 25

@implementation SignUpViewController


-(id)init {
    if ((self = [super init])){
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(dismissKeyboard)];
        
        [self.view addGestureRecognizer:tap];
        
        int w = self.view.bounds.size.width;
        int h = self.view.bounds.size.height;
        
        _fNameText = [[UITextField alloc]initWithFrame: CGRectMake(w/5, h/4, 3*w/5, 30)];
        _fNameText.placeholder = @"First Name";
        _fNameText.backgroundColor = [UIColor whiteColor];
        _fNameText.textColor = [UIColor blackColor];
        _fNameText.borderStyle = UITextBorderStyleRoundedRect;
        _fNameText.textAlignment = NSTextAlignmentLeft;
        _fNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _fNameText.returnKeyType = UIReturnKeyGo;
        [self.view addSubview: _fNameText];
        
        _lNameText = [[UITextField alloc]initWithFrame: CGRectMake(w/5, h/4 + 50, 3*w/5, 30)];
        _lNameText.placeholder = @"Last Name";
        _lNameText.backgroundColor = [UIColor whiteColor];
        _lNameText.textColor = [UIColor blackColor];
        _lNameText.borderStyle = UITextBorderStyleRoundedRect;
        _lNameText.textAlignment = NSTextAlignmentLeft;
        _lNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _lNameText.returnKeyType = UIReturnKeyGo;
        [self.view addSubview:_lNameText];
        
        _emailText = [[UITextField alloc]initWithFrame: CGRectMake(w/5, h/4 + 100, 3*w/5, 30)];
        _emailText.placeholder = @"Email";
        _emailText.backgroundColor = [UIColor whiteColor];
        _emailText.textColor = [UIColor blackColor];
        _emailText.borderStyle = UITextBorderStyleRoundedRect;
        _emailText.textAlignment = NSTextAlignmentLeft;
        _emailText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _emailText.returnKeyType = UIReturnKeyGo;
        [self.view addSubview:_emailText];
        
        _phoneText = [[UITextField alloc]initWithFrame: CGRectMake(w/5, h/4 + 150, 3*w/5, 30)];
        _phoneText.placeholder = @"Phone Number";
        _phoneText.backgroundColor = [UIColor whiteColor];
        _phoneText.textColor = [UIColor blackColor];
        _phoneText.borderStyle = UITextBorderStyleRoundedRect;
        _phoneText.textAlignment = NSTextAlignmentLeft;
        _phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _phoneText.returnKeyType = UIReturnKeyGo;
        [self.view addSubview:_phoneText];
        
        UILabel *profileLabel = [[UILabel alloc] initWithFrame:CGRectMake(w/5,h/4+200, 2*w/5, 30)];
        profileLabel.text = @"Profile Picture";
        [self.view addSubview:profileLabel];
        
        _profImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _profImageButton.frame = CGRectMake(7*w/10, h/4 + 195, 45, 45);
        [_profImageButton setTitle:@"Prof" forState:UIControlStateNormal];
        [_profImageButton addTarget: self action:@selector(setPicture) forControlEvents:UIControlEventTouchUpInside];
        _profImageButton.backgroundColor = [UIColor greenColor];
        [self.view addSubview:_profImageButton];
        
        _signupButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _signupButton.frame = CGRectMake(0, 4*h/6, w, 50);
        [_signupButton setTitle:@"Sign Up" forState:UIControlStateNormal];
        [_signupButton addTarget:self action:@selector(signUp) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_signupButton];
        
        _backButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _backButton.frame = CGRectMake(0, 4*h/6+50, w, 50);
        [_backButton setTitle:@"Back" forState:UIControlStateNormal];
        [_backButton addTarget: self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backButton];
        
        _bannerView = [[UIView alloc]  initWithFrame:CGRectMake(100, 0, 0, BANNERHEIGHT)];
        _bannerView.backgroundColor = [UIColor redColor];
        _bannerView.alpha = .8;
        [self.view addSubview:_bannerView];
        _bannerView.hidden = YES;
        
        
        _errorLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.view.bounds.size.width*.1, 5, self.view.bounds.size.width*.8, 15)];
        _errorLabel.textAlignment = NSTextAlignmentCenter;
        _errorLabel.backgroundColor = [UIColor clearColor];
        _errorLabel.textColor = [UIColor whiteColor];
        _errorLabel.font = [UIFont systemFontOfSize:12];
        
        [_bannerView addSubview:_errorLabel];

    }
    return self;
}

- (void)setPicture {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select a profile image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo Library", @"Take Photo", nil];
        actionSheet.tag = 1;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];

    }
    
    else if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Select a profile image" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Photo Library", nil];
        actionSheet.tag = 2;
        [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
    }
    
    else {
        [self animateBanner:@"Please grant permission to access photos"];
    }
}


-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        UIImagePickerController *_picker = [[UIImagePickerController alloc] init];
        _picker.delegate = self;
        _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _picker.allowsEditing = YES;
        [self presentViewController:_picker animated:YES completion:nil];
            
            
    }
    else if (buttonIndex == 1) {
        if (actionSheet.tag == 1) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [self presentViewController:picker animated:YES completion:NULL];
        }
        else if (actionSheet.tag == 2) {
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [_profImageButton setBackgroundImage:chosenImage forState:UIControlStateNormal];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dismissKeyboard {
    [_fNameText resignFirstResponder];
    [_lNameText resignFirstResponder];
    [_emailText resignFirstResponder];
    [_phoneText resignFirstResponder];
}

- (BOOL)formComplete {
    
    if (!(_fNameText.text.length > 0 && _lNameText.text.length > 0 && _emailText.text.length > 0 && _phoneText.text.length > 0)) {
        [self animateBanner:@"Please complete all fields"];
    }
    
    else if (![self NSStringIsValidEmail:_emailText.text]) {
        [self animateBanner:@"Please enter a valid email"];
    }
    
    else {
        return true;
    }
    return false;
}

- (void)signUp {
    
    if (![self formComplete]) {
        return;
    }
    
    [_signupButton setEnabled:NO];
    
    NSString* email = _emailText.text, *fname = _fNameText.text, *lname = _lNameText.text, *phone = _phoneText.text;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [Backend sendRequestWithURL:@"users/add" Parameters:@{@"email":email, @"firstname":fname, @"lastname":lname, @"phone":phone} Callback:^(NSDictionary * data) {
        [_signupButton setEnabled:YES];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if([data objectForKey:@"error"]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Already In Use"
                                                            message:[NSString stringWithFormat:@"An account already exists with the email '%@'.", email]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                            message:@"Please check your email to verify your account."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil];
            [alert show];
            
            LoginViewController *loginController = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginController animated:YES];
        }
    }];
}


- (void) animateBanner:(NSString *)error
{
    //If they keep clicking submit don't keep reanimating until done or error changed
    
    if (![_errorLabel.text isEqualToString:error] || _bannerView.hidden) {
        _errorLabel.text = error;
        
        _bannerView.frame = CGRectMake(0, -BANNERHEIGHT, self.view.bounds.size.width, BANNERHEIGHT);
        _bannerView.hidden = NO;
        
        [UIView animateWithDuration :0.5 delay:0 options: (UIViewAnimationCurveLinear | UIViewAnimationOptionAllowUserInteraction) animations:^{
            _bannerView.frame = CGRectMake(0, 64, self.view.bounds.size.width, BANNERHEIGHT);
        }
                          completion:^(BOOL finished){
                              [UIView animateWithDuration :0.5 delay:1.5 options: (UIViewAnimationCurveLinear |UIViewAnimationOptionAllowUserInteraction)
                                                animations:^{
                                                    _bannerView.frame = CGRectMake(0, -BANNERHEIGHT, self.view.bounds.size.width, BANNERHEIGHT);
                                                }
                                                completion:^(BOOL finished){
                                                    _bannerView.hidden = YES;
                                                }];
                              
                          }];
        
    }
    
    else {
        
    }
}

- (BOOL)NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

@end
