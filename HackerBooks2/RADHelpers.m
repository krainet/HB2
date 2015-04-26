//
//  RADHelpers.m
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 19/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "RADHelpers.h"

@implementation RADHelpers

#pragma mark - Utils

// String to array
+(NSArray *) explodeWithSeparator:(NSString *)string
                        separatedBy:(NSString *) separator{
    NSArray *arrayStrings = [string componentsSeparatedByString:separator];
    return arrayStrings;
}

// Array to String
+(NSString *) implodeWithSeparator:(NSArray *) anArray
                         separatedBy:(NSString *) separator{
    NSString *string = @"";
    for (NSString *str in anArray) {
        string = [string stringByAppendingString:str];
        string = [string stringByAppendingString:separator];
    }
    NSString *stringOfItems = [string substringWithRange:NSMakeRange(0,[string length]-2)];
    return stringOfItems;
}

+(void) downloadDataWithURL:(NSURL *)url statusOperationWith:(void(^)(NSData *data ,NSURLResponse * response, NSError *error))success failure:(void (^)(NSURLResponse *response, NSError *error))failure{
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{@"Accept"    : @"application/json"};
    // Inicialización de la sesión
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    // Tarea de gestión de datos
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
        if (HTTPResponse.statusCode == 200) {
            if (!error) {
                if (data != nil) {
                    success(data,response,error);
                }else{
                    NSLog(@"Data error...");
                    failure(response,error);
                }
            }else{
                failure(response,error);
            }
        }else{
            [self alertMessage:error];
            failure(response,error);
        }
        
    }];
    [dataTask resume];
}

+(void)alertMessage:(NSError *)error{
    NSLog(@"Error... %@",error);
}


@end
