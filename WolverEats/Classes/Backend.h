//
//  NSObject+Backend.h
//  WolverEats
//
//  Created by James Lennon on 2/3/15.
//  Copyright (c) 2015 James Lennon. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const BASE_URL;

@interface Backend : NSObject

+(void)sendRequestWithURL:(NSString*)url Parameters:(NSDictionary*)params Callback:(void (^)(NSDictionary*))callback Failure:(void (^)(void))failure;
+(void)sendRequestWithURL:(NSString*)url Parameters:(NSDictionary*)params Callback:(void (^)(NSDictionary*))callback;
+(void)setCredentialsToEmail:(NSString*)email Password:(NSString*)password;
+(BOOL)loadCredentials;
+(void)updateEmail:(NSString *)email;

@end
