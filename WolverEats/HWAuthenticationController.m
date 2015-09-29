//
//  StudentInfoDownloadViewController.m
//  WolverEats
//
//  Created by James Lennon on 6/9/14.
//  Copyright (c) 2014 James Lennon. All rights reserved.
//

#import "HWAuthenticationController.h"
#import "HTMLParser.h"
#import "MBProgressHUD.h"
//#import "UserData.h"
//#import "SignInViewController.h"

@implementation HWAuthenticationController{
    BOOL alreadyLoaded;
    NSMutableDictionary *info;
}

-(id)init {
    if ((self = [super init])){
        
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    _webView.keyboardDisplayRequiresUserAction = NO;
    [self.view addSubview: _webView];

    
    info = [NSMutableDictionary dictionary];
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
       //https://www.hw.com/students/Login?returnurl=/students/SchoolResources/MyScheduleEvents.aspx
    [_webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.hw.com/students/Login?returnurl=/students/SchoolResources/MyScheduleEvents.aspx"]]];
    }
    
    return self;
}

//- (void)viewWillAppear:(BOOL)animated {
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}

//- (IBAction)backPressed:(id)sender {
//    if ([IHWCurriculum isFirstRun]) [self.navigationController popViewControllerAnimated:YES];
//    else [self.navigationController setViewControllers:@[[[IHWScheduleViewController alloc] initWithNibName:@"IHWScheduleViewController" bundle:nil]] animated:YES];
//}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    BOOL result = ([request.URL isEqual:[NSURL URLWithString:@"https://www.hw.com/students/Login?returnurl=/students/SchoolResources/MyScheduleEvents.aspx"]]
                   || [request.URL isEqual:[NSURL URLWithString:@"http://www.hw.com/students/School-Resources/My-Schedule-Events"]]
                   || [request.URL isEqual:[NSURL URLWithString:@"https://www.hw.com/students/School-Resources/My-Schedule-Events"]]
                   || [request.URL isEqual:[NSURL URLWithString:@"https://www.hw.com/students/SchoolResources/MyScheduleEvents.aspx"]]
                   || [request.URL isEqual:[NSURL URLWithString:@"http://www.hw.com/students/SchoolResources/MyScheduleEvents.aspx"]]);
    return result;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSURL *url = webView.request.mainDocumentURL;
    NSLog(@"URL did finish load: %@", url.description);
    if ([url isEqual:[NSURL URLWithString:@"https://www.hw.com/students/Login/tabid/2279/Default.aspx?returnurl=%2fstudents%2fSchoolResources%2fMyScheduleEvents.aspx"]]) {
        self.webView.hidden = NO;
//        self.loginPromptLabel.hidden = NO;
    } else if ([url isEqual:[NSURL URLWithString:@"http://www.hw.com/students/School-Resources/My-Schedule-Events"]]) {
        self.webView.hidden = YES;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        if (!alreadyLoaded) {
            alreadyLoaded = YES;
//            self.loadingText.text = @"Please wait, finding schedule...";
            [self.webView stringByEvaluatingJavaScriptFromString:@"__doPostBack(\"dnn$ctr8420$InteractiveSchedule$lnkStudentScheduleHTML\", \"\");"];
        } else {
            NSString *scheduleURL = [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementById(\"dnn_ctr8420_InteractiveSchedule_txtWindowPopupUrl\").value"];
            self.resultData = [NSMutableData data];
            [self getInfoFromURL:scheduleURL];
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSURL *failingURL = [[error userInfo] objectForKey:@"NSErrorFailingURLKey"];
    NSLog(@"ERROR loading URL into webView: %@", error.debugDescription);
    if ([failingURL.description hasPrefix:@"http://www.hw.com/Default.aspx?tabid=3215&error="]) {
        [[[UIAlertView alloc] initWithTitle:@"No Connection" message:@"HW.com is currently not available.  Please check your internet connection." delegate:self cancelButtonTitle:@"Try Again" otherButtonTitles:nil] show];
        
    }
}

- (void)getInfoFromURL:(NSString *)urlStr {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.resultData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *name, *schoolID;
    
    NSError *error = nil;
    HTMLParser *parser = [[HTMLParser alloc] initWithData:self.resultData error:&error];
    if (error != nil) { NSLog(@"ERROR parsing HTML: %@", error.debugDescription); return; }
    NSArray *divs = [[parser body] findChildTags:@"div"];
    for (HTMLNode *div in divs) {
        //Loop through all the DIV elements on the (terrible) page (that doesn't conform to HTML specifications at all)
        //This is necessary because the page doesn't use unique IDs for elements (which it should)
        if ([[div getAttributeNamed:@"id"] isEqualToString:@"nameStudentName1-0"]) {
            //We currently don't do anything with the student's name
            NSString *tmp = [[[div findChildTags:@"span"] objectAtIndex:0] contents];
            NSArray *parts = [tmp componentsSeparatedByString:@", "];
            name = [NSString stringWithFormat:@"%@ %@", [self cleanName:parts[1]], [parts[0] capitalizedString]];
            NSLog(@"Welcome, %@", name);
            [info setValue:name forKeyPath:@"name"];
        } else if([[div getAttributeNamed:@"id"] isEqualToString:@"grlvAlphaCode1-0"]){
            NSString *grade = [[[div findChildTags:@"span"] objectAtIndex:0] contents];
            NSLog(@"Grade = %@", grade);
        } else if([[div getAttributeNamed:@"id"] isEqualToString:@"DidaxID1-0"]){
            schoolID = [[[div findChildTags:@"span"] objectAtIndex:0] contents];
            NSLog(@"ID: %@", schoolID);
            [info setValue:schoolID forKeyPath:@"school_id"];
        }
    }
    if (!([info valueForKey:@"name"]!=nil && [info valueForKey:@"school_id"]!=nil)) {
        [self showError];
    }
    
    //[self showSignIn];
    
//    if (shouldShowWarning) {
//        //Show a warning if the schedule was a preliminary schedule
//        [[[UIAlertView alloc] initWithTitle:@"Full Schedule Unavailable" message:@"The full schedule is not yet available, so you will need to edit the courses that are not full-year and set the right semester/trimester." delegate:self cancelButtonTitle:@"Edit Courses" otherButtonTitles:nil] show];
//    } else {
//        //Otherwise go directly to the main schedule page
//        IHWScheduleViewController *svc = [[IHWScheduleViewController alloc] initWithNibName:@"IHWScheduleViewController" bundle:nil];
//        [self.navigationController pushViewController:svc animated:YES];
//        //Clear the ViewController stack
//        [self.navigationController setViewControllers:[NSArray arrayWithObject:svc]];
//    }
}

-(NSString*)cleanName:(NSString*)name{
    NSArray* parts = [name componentsSeparatedByString:@" "];
    return [parts[0] capitalizedString];
}

-(void)showError{
    [[[UIAlertView alloc] initWithTitle:@"Try Again" message:@"An error ocurred, please try again." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Intro"];
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)dealloc {
    self.webView.delegate = nil;
    //[super dealloc];
}

@end
