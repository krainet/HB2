#import "RADPdf.h"
#import "AGTCoreDataStack.h"

@interface RADPdf ()

// Private interface goes here.

@end

@implementation RADPdf

//Observables
+(NSArray *) observableKeys{
    // Observo las propiedades de las relaciones
    return @[];
}


#pragma mark - Inits
+(instancetype) pdfWithURL:(NSURL *) url
                     stack:(AGTCoreDataStack *) stack{
    
    RADPdf *pdf = [NSEntityDescription insertNewObjectForEntityForName:[RADPdf entityName]
                                                inManagedObjectContext:stack.context];
    pdf.pdfUrl = [url absoluteString];
    //Emtpty data
    pdf.pdfData = nil;
    return pdf;
}


#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    // Actions
}


@end
