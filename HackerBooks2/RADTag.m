#import "RADTag.h"
#import "RADBook.h"
#import "AGTCoreDataStack.h"

@interface RADTag ()

// Private interface goes here.

@end

@implementation RADTag

//Observables
+(NSArray *) observableKeys{
    // Observo las propiedades de las relaciones
    return @[RADTagAttributes.name,RADTagRelationships.books];
}



#pragma mark - Inits
+(instancetype) tagWithName:(NSString *) name
                      stack:(AGTCoreDataStack *) stack{
    
    RADTag *tag = [NSEntityDescription insertNewObjectForEntityForName:[RADTag entityName]
                                                inManagedObjectContext:stack.context];
    tag.name = name;
    return tag;
}

#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    // Action
    
}

@end
