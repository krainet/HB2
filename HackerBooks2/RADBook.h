#import "_RADBook.h"
@class AGTCoreDataStack;


@import Foundation;
@import UIKit;


@class RADBook;

@protocol RADBookDelegate <NSObject>

-(void) bookDidChange:(RADBook*) book;

@end


@interface RADBook : _RADBook {}

@property (nonatomic) BOOL isFavorite;


#pragma mark - Inits
+(instancetype) bookWithDictionary:(NSDictionary *) dict
                             stack:(AGTCoreDataStack *) stack;


//For dumy data
+(instancetype) bookWithTitle:(NSString*) title
                       Author:(NSString*) author
                         Tags:(NSArray*) tags
                       PdfURL:(NSString*) pdfURL
                     ImageURL:(NSString*) imageURL
                      InStack:(AGTCoreDataStack*) stack;


#pragma mark - Methods
-(NSString *) bookAuthors;
-(NSString *) bookTags;



@end
