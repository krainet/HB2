#import "_RADPdf.h"
@class AGTCoreDataStack;

@interface RADPdf : _RADPdf {}

#pragma mark - Init
+(instancetype) pdfWithURL:(NSURL *) url
                     stack:(AGTCoreDataStack *) stack;


@end
