//
//  RADHelpers.h
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 19/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface RADHelpers : NSObject
#pragma mark - Arrays and Strings

// Utility method to extract items from NSString with a separator and add them to an array
+(NSArray *) explodeWithSeparator:(NSString *) string
                        separatedBy:(NSString *) separator;

// Returns a string containing all the objects in the array, separated by a separator
+(NSString *) implodeWithSeparator:(NSArray *) anArray
                         separatedBy:(NSString *) separator;


+(void) downloadDataWithURL:(NSURL *)url statusOperationWith:(void(^)(NSData *data ,NSURLResponse * response, NSError *error))success failure:(void (^)(NSURLResponse *response, NSError *error))failure;

+(void)alertMessage:(NSError *)error;


@end
