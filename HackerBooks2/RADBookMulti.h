//
//  RADBookMulti.h
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 19/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RADBookMulti : NSObject

+(instancetype)dictionary;

-(void) addObject:(id) object forKey:(id<NSCopying>) key;
-(NSSet *) objectsForKey:(id<NSCopying>) key;

-(void) removeObject:(id)object forKey:(id<NSCopying>)key;

-(NSUInteger) count;
-(NSArray*) allKeys;

@end
