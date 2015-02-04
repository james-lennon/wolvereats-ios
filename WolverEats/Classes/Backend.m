//
//  NSObject+Backend.m
//  WolverEats
//
//  Created by James Lennon on 2/3/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import "Backend.h"
#import <AFNetworking.h>

NSString *const BASE_URL = @"http://localhost:8888/hwgrub/";

@implementation Backend

static NSDictionary* credentials;

+(void)sendRequestWithURL:(NSString *)url Parameters:(NSDictionary *)params Callback:(void (^)(NSDictionary *))callback Failure:(void (^)(void))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    NSMutableDictionary* dataToSend = [NSMutableDictionary dictionary];
    [dataToSend addEntriesFromDictionary:params];
    
    if(credentials == nil){
        NSLog(@"Credentials are nil in request to %@", url);
    }else{
        [dataToSend addEntriesFromDictionary:credentials];
    }
    
    [manager POST:[NSString stringWithFormat:@"%@%@", BASE_URL, url] parameters:dataToSend success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        callback(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        failure();
        //Show offline
    }];
}

+(void)sendRequestWithURL:(NSString *)url Parameters:(NSDictionary *)params Callback:(void (^)(NSDictionary *))callback{
    [self sendRequestWithURL:url Parameters:params Callback:callback Failure:^{}];
}

+(void)setCredentialsToEmail:(NSString *)email Password:(NSString *)password{
    credentials = @{@"email":email, @"password":password, @"no_hash":@1};
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"credentialsData"];
    
    [NSKeyedArchiver archiveRootObject:credentials toFile:filePath];
}

+(BOOL)loadCredentials{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectoryPath stringByAppendingPathComponent:@"credentialsData"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *savedData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if([savedData objectForKey:@"email"] && [savedData objectForKey:@"password"]){
            credentials = [NSDictionary dictionaryWithDictionary:savedData];
            return YES;
        }
    }
    return NO;
}

@end
