//
//  AddTripViewController.m
//  WolverEats
//
//  Created by Miller on 2/27/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "AddTripViewController.h"
#import <ActionSheetDatePicker.h>
#import "NSDate+Helper.h"
#import "Backend.h"

@interface AddTripViewController ()

@end


@implementation AddTripViewController

- (id)init {
    if ((self = [super init])){
        // Do any additional setup after loading the view.
        self.title = @"Add a Trip";
        
        int w = self.view.bounds.size.width;
        int h = self.view.bounds.size.height;
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(dismissKeyboard)];
        
        [self.view addGestureRecognizer:tap];
        
        
        _restLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, h/4 - 40, w, 30)];
        _restLabel.text = @"What restaurant are you going to?";
        _restLabel.textAlignment = NSTextAlignmentCenter;
        _restLabel.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:_restLabel];
        
        
        _restaurantText = [[UITextField alloc]initWithFrame: CGRectMake(w/5, h/4, 3*w/5, 30)];
        _restaurantText.backgroundColor = [UIColor whiteColor];
        _restaurantText.textColor = [UIColor blackColor];
        _restaurantText.borderStyle = UITextBorderStyleRoundedRect;
        _restaurantText.textAlignment = NSTextAlignmentLeft;
        _restaurantText.clearButtonMode = UITextFieldViewModeWhileEditing;
        _restaurantText.returnKeyType = UIReturnKeyGo;
        _restaurantText.tag = 1;
        [self.view addSubview: _restaurantText];
        
        
        _expLabel = [[UILabel alloc]initWithFrame:CGRectMake(w/5, h/4 +50, 3*w/5, 30)];
        _expLabel.textColor = [UIColor blackColor];
        _expLabel.textAlignment = NSTextAlignmentCenter;
        _expLabel.text = @"How late will you accept orders?";
        _expLabel.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:_expLabel];
        
        _expButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _expButton.frame = CGRectMake(0, h/4 + 90, w, 30);
        [_expButton setTitle:@"Select" forState:UIControlStateNormal];
        [_expButton addTarget:self action:@selector(expPop) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_expButton];
        
        _etaText = [[UILabel alloc]initWithFrame: CGRectMake(w/5, h/4 + 130, 3*w/5, 30)];
        _etaText.textColor = [UIColor blackColor];
        _etaText.textAlignment = NSTextAlignmentCenter;
        _etaText.text = @"When will you get back to school?";
        _etaText.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:_etaText];
        
        _etaButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _etaButton.frame = CGRectMake(0, h/4 + 170, w, 30);
        [_etaButton setTitle:@"Select" forState:UIControlStateNormal];
        [_etaButton addTarget:self action:@selector(etaPop) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_etaButton];
        
        
        _addTripButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _addTripButton.frame = CGRectMake(0, 3*h/5 + 50, w, 100);
        [_addTripButton setTitle:@"Add Trip" forState:UIControlStateNormal];
        [_addTripButton addTarget: self action:@selector(addTrip) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_addTripButton];
        
        
    }
    return self;
}

- (void)doneClicked {
    
}

- (void)etaPop{
    
    NSDate *date = [NSDate date];
    
    [ActionSheetDatePicker showPickerWithTitle:@"Select Arrival Time" datePickerMode:UIDatePickerModeDateAndTime selectedDate:date minimumDate:date maximumDate:nil doneBlock:^(ActionSheetDatePicker * picker, id selectedDate, id origin) {
        _etaStamp = [selectedDate utcTimeStamp];
        NSString *etaText = [NSDate stringForDisplayFromDate:selectedDate prefixed:NO alwaysDisplayTime:NO];
        
        [_etaButton setTitle:etaText forState:UIControlStateNormal];
        
    }
                                   cancelBlock:^(ActionSheetDatePicker *picker) {
                                       
                                   }
     
                                        origin:self.view];
    
}

- (void)expPop{
    
    NSDate *date = [NSDate date];

    [ActionSheetDatePicker showPickerWithTitle:@"Select an Expiration" datePickerMode:UIDatePickerModeDateAndTime selectedDate:date minimumDate:date maximumDate:nil doneBlock:^(ActionSheetDatePicker * picker, id selectedDate, id origin) {
        _expStamp = [selectedDate utcTimeStamp];
        NSString *expText = [NSDate stringForDisplayFromDate:selectedDate prefixed:NO alwaysDisplayTime:NO];
        
        [_expButton setTitle:expText forState:UIControlStateNormal];
        
        
        
    }
                                   cancelBlock:^(ActionSheetDatePicker *picker) {
                                       
                                   }
     
                                        origin:self.view];
}


-(void)addTrip
{
    
    NSString* restaurant = _restaurantText.text;
    NSNumber *etaNum = [NSNumber numberWithLong:_etaStamp];
    NSNumber *expNum = [NSNumber numberWithLong:_expStamp];
    
    if(!(restaurant && etaNum && expNum)){
        NSLog(@"invalid login");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Trip"
                                                        message:@"You left out some information."
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        alert.tag = 2;
        [alert show];
    }
    else if(! (etaNum > expNum)){
        NSLog(@"invalid login");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Trip"
                                                        message:@"Your ETA has to be after your expiration!"
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil];
        alert.tag = 2;
        [alert show];
    }


    else
    {
    
    [Backend sendRequestWithURL:@"trips/add_trip" Parameters:@{@"restaurant":restaurant, @"eta": etaNum, @"expiration":expNum} Callback:^(NSDictionary * data){
        
        
        if([data objectForKey:@"error"]){
            NSLog(@"invalid login");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request Failed"
                                                            message:@"Your request did not process, please try again later"
                                                           delegate:self
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil];
            alert.tag = 2;
            [alert show];
        }
        
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Great!"
                                                            message:@"We've processed your trip and will let you know when any orders are placed!"
                                                           delegate:self
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil];
            alert.tag = 3;
            [alert show];
        }
    
     
    }];
}
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]){
        //cancel clicked ...do your action
        if (alertView.tag == 3) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else {
        //reset clicked
    }
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
