//
//  RADBookMulti.m
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 19/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "RADBookMulti.h"

@interface RADBookMulti ()
@property (nonatomic, strong) NSMutableDictionary *dict;
@end

@implementation RADBookMulti

#pragma mark -  Class Methods
+(instancetype)dictionary{
    return [[self alloc] init];
}

#pragma mark - init
-(id) init{
    if (self = [super init]) {
        _dict = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark -  accessors
-(void) addObject:(id) object
           forKey:(id<NSCopying>) key{
    
    NSMutableSet *objs = [self.dict objectForKey:key];
    if (!objs) {
        objs = [NSMutableSet set];
    }
    
    [objs addObject:object];
    [self.dict setObject:objs
                  forKey:key];
}

-(NSSet *) objectsForKey:(id<NSCopying>) key{
    
    NSMutableSet *objs = [self.dict objectForKey:key];
    if (!objs) {
        objs = [NSMutableSet set];
    }
    
    return objs;
}

-(void) removeObject:(id)object
              forKey:(id<NSCopying>)key{
    
    NSMutableSet *objs = [self.dict objectForKey:key];
    if (objs) {
        [objs removeObject:object];
        if ([objs count] > 0) {
            [self.dict setObject:objs
                          forKey:key];
        }else{
            // ELiminamos ese set y su key del diccionario
            [self.dict removeObjectForKey:key];
        }
        
    }
}

-(NSUInteger) count{
    /**
     The number of unique objects in all the buckets
     */
    NSMutableSet *total = [NSMutableSet set];
    for (NSMutableSet *bucket in [self.dict allValues]) {
        [total unionSet:bucket];
    }
    return total.count;
}

-(NSArray*) allKeys{
    return [self.dict allKeys];
}


#pragma mark - NSObject
-(NSString*) description{
    return [NSString stringWithFormat:@"<%@:\n %@>", [self class], _dict];
}


@end
