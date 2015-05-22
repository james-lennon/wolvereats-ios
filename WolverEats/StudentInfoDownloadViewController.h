//
//  StudentInfoDownloadViewController.h
//  WolverEats
//
//  Created by James Lennon on 6/9/14.
//  Copyright (c) 2014 James Lennon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentInfoDownloadViewController : UIViewController <UIWebViewDelegate, NSURLConnectionDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) NSMutableData *resultData;

@end
