//
//  EditEmailViewController.h
//  WolverEats
//
//  Created by Miller on 5/14/15.
//  Copyright (c) 2015 Cameron Cohen and Amelia Miller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditEmailViewController : UIViewController

@property (strong, nonatomic)  UITextField *email;
@property (strong, nonatomic)  UITextField *confirm;
@property (strong, nonatomic)  UIButton *saveButton;

- (BOOL)NSStringIsValidEmail:(NSString *)checkString;

@end
