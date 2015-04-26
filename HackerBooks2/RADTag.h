#import "_RADTag.h"
@class AGTCoreDataStack;

@interface RADTag : _RADTag {}

#pragma mark - Factory init
+(instancetype) tagWithName:(NSString *) name
                      stack:(AGTCoreDataStack *) stack;


@end
