#import "RADNote.h"
#import "RADImage.h"

@interface RADNote ()

// Private interface goes here.

@end

@implementation RADNote

#pragma mark -  Class Methods
+(NSArray *) observableKeys{
    return @[RADNoteAttributes.name, RADNoteAttributes.text, RADNoteRelationships.books];
}

+(instancetype) noteWithName:(NSString *) name
                        Book:(RADBook*) book
                     context:(NSManagedObjectContext *) context{
    
    RADNote *n = [self insertInManagedObjectContext:context];
    
    n.ts_add = [NSDate date];
    n.name = name;
    n.books = book;
    n.images = [RADImage insertInManagedObjectContext:context];
    n.ts_upd = [NSDate date];
    
    return n;
}

#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    self.ts_upd = [NSDate date];
    
}



@end
