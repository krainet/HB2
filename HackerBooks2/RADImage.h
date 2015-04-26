
#import "_RADImage.h"
@import UIKit;

@class AGTCoreDataStack;


@interface RADImage : _RADImage {}

#pragma mark - Properties

@property (strong,nonatomic) UIImage *image;

#pragma mark - Factory init
+(instancetype) photoWithImage:(UIImage *) image
                      imageURL:(NSURL *) imageURL
                         stack:(AGTCoreDataStack *) stack;

#pragma mark -Class Methods
+(instancetype) photoWithAsyncImageURL:(NSString *)imageURL
                               Context:(NSManagedObjectContext*) context;

@end
