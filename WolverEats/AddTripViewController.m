//
//  AddTripViewController.m
//  WolverEats
//
//  Created by Miller on 2/27/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "AddTripViewController.h"

@interface AddTripViewController ()

@end


@implementation AddTripViewController

- (id)init {
    if ((self = [super init])){
    // Do any additional setup after loading the view.
    self.title = @"Add a Trip"; 
    
    int w = self.view.bounds.size.width;
    int h = self.view.bounds.size.height;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
        
    [self.view addGestureRecognizer:tap];

    
    _addLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, h/5, w, 100)];
    _addLabel.text = @"Add a Trip!";
    _addLabel.textAlignment = NSTextAlignmentCenter;
    _addLabel.font = [UIFont systemFontOfSize:30];
    //[self.view addSubview:_addLabel];
    
    
    _restaurantText = [[UITextField alloc]initWithFrame: CGRectMake(w/5, h/4, 3*w/5, 30)];
    _restaurantText.placeholder = @"Restaurant";
    _restaurantText.backgroundColor = [UIColor whiteColor];
    _restaurantText.textColor = [UIColor blackColor];
    _restaurantText.borderStyle = UITextBorderStyleRoundedRect;
    _restaurantText.textAlignment = NSTextAlignmentLeft;
    _restaurantText.clearButtonMode = UITextFieldViewModeWhileEditing;
    _restaurantText.returnKeyType = UIReturnKeyGo;
    _restaurantText.tag = 1;
    [self.view addSubview: _restaurantText];
        
    _etaText = [[UILabel alloc]initWithFrame: CGRectMake(w/5, h/4 + 50, 3*w/5, 30)];
    _etaText.textColor = [UIColor blackColor];
    _etaText.textAlignment = NSTextAlignmentLeft;
    _etaText.text = @"Estimated Time of Arrival:";
    _etaText.font = [UIFont systemFontOfSize:14];

    _etaButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _etaButton.frame = CGRectMake(3*w/5 + 10, h/4 + 50, w/5, 30);
    [_etaButton setTitle:@"Select" forState:UIControlStateNormal];
    [_etaButton addTarget:self action:@selector(popUp) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_etaButton];


    [self.view addSubview:_etaText];
        
    
    _addTripButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _addTripButton.frame = CGRectMake(0, 3*h/5 + 50, w, 100);
    [_addTripButton setTitle:@"Add Trip" forState:UIControlStateNormal];
    [_addTripButton addTarget: self action:@selector(placeOrder) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_addTripButton];
    }
    return self; 
}

- (void)popUp{
    
    
   /* _pickerViewPopup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    
    UIDatePicker *pickerView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
    pickerView.datePickerMode = UIDatePickerModeDate;
    pickerView.hidden = NO;
    pickerView.date = [NSDate date];
    [_pickerViewPopup addSubview:pickerView];
    
    UIToolbar *pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    pickerToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    [barItems addObject:doneBtn];
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed:)];
    [barItems addObject:cancelBtn];
    
    [pickerToolbar setItems:barItems animated:YES];
    
    [_pickerViewPopup addSubview:pickerToolbar];
    [_pickerViewPopup addSubview:pickerView];
    [_pickerViewPopup showInView:self.view];
    [_pickerViewPopup setBounds:CGRectMake(0,0,320, 464)];
    */
    
}

-(void)placeOrder
{
    
}

-(void)doneButtonPressed:(id)sender{
    //Do something here here with the value selected using [pickerView date] to get that value
    
    [_pickerViewPopup dismissWithClickedButtonIndex:1 animated:YES];
}

-(void)cancelButtonPressed:(id)sender{
    [_pickerViewPopup dismissWithClickedButtonIndex:1 animated:YES];
}

            

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissKeyboard {
    [_restaurantText resignFirstResponder];
 
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
