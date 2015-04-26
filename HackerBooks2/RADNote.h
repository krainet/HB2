#import "_RADNote.h"

@interface RADNote : _RADNote {}
// Custom logic goes here.

+(instancetype) noteWithName:(NSString *) name
                    Book:(RADBook*) book
                     context:(NSManagedObjectContext *) context;

@end
