#import "RADBook.h"
#import "AGTCoreDataStack.h"
#import "RADHelpers.h"
#import "RADTag.h"
#import "RADImage.h"
#import "RADPdf.h"
#import "RADCoreDataUtils.h"
#import "Config.h"


@implementation RADBook


#pragma mark - Inits
+(instancetype) bookWithDictionary:(NSDictionary *) dict
                             stack:(AGTCoreDataStack *) stack{
    
    
    RADBook *book = [NSEntityDescription insertNewObjectForEntityForName:[RADBook entityName]
                                                  inManagedObjectContext:stack.context];
    NSArray *aTags = [RADHelpers explodeWithSeparator:[dict objectForKey:@"tags"] separatedBy:@", "];
    
    book.title = [dict objectForKey:@"title"];
    book.author = [dict objectForKey:@"authors"];
    
    // Add tags to book
    for (NSString *tag in aTags) {
        // Tag exist
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",tag];
        NSArray *results = [RADCoreDataUtils resFromFetchForEntityName:[RADTag entityName]
                                                                    sortedBy:RADTagAttributes.name
                                                                   ascending:YES
                                                               withPredicate:predicate
                                                                     inStack:stack];
        
        if ([results count]!=0) {
            // Add existing tag
            [book addTagsObject:[results lastObject]];
        }
        else{
            // Add new tag
            [book addTagsObject:[RADTag tagWithName:tag stack:stack]];
        }
    }
    
    book.pdfs = [RADPdf pdfWithURL:[NSURL URLWithString:[dict objectForKey:@"pdf_url"]]
                            stack:stack];
    
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dict objectForKey:@"image_url"]]]];
    
    //TODO Async Images
    book.images = [RADImage photoWithImage:img
                                 imageURL:[NSURL URLWithString:[dict objectForKey:@"image_url"]]
                                    stack:stack];
    
    
    return book;
}


//For dumy data
+(instancetype) bookWithTitle:(NSString*) title
                       Author:(NSString*) author
                         Tags:(NSArray*) tags
                       PdfURL:(NSString*) pdfURL
                     ImageURL:(NSString*) imageURL
                      InStack:(AGTCoreDataStack*) stack{
    
    RADBook *book = [NSEntityDescription insertNewObjectForEntityForName:[RADBook entityName]
                                                  inManagedObjectContext:stack.context];
    
    NSArray *aTags = tags;
    book.title = title;
    
    for (NSString *tag in aTags) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",tag];
        NSArray *results = [RADCoreDataUtils resFromFetchForEntityName:[RADTag entityName]
                                                                    sortedBy:RADTagAttributes.name
                                                                   ascending:YES
                                                               withPredicate:predicate
                                                                     inStack:stack];
        
        if ([results count]!=0) {
            [book addTagsObject:[results lastObject]];
        }
        else{
            [book addTagsObject:[RADTag tagWithName:tag stack:stack]];
        }
    }
    
    book.pdfs = [RADPdf pdfWithURL:[NSURL URLWithString:pdfURL]
                             stack:stack];
    book.images = [RADImage photoWithImage:[UIImage imageNamed:@"emptybook.jpg"]
                                  imageURL:[NSURL URLWithString:imageURL]
                                     stack:stack];
    
    return book;

}

#pragma mark - Utils

//Return book Author
-(NSString *) bookAuthors{
    return self.author;
}

//Return book tags "," imploded
-(NSString *) bookTags{
    
    NSMutableString *bookTags = [[NSMutableString alloc]init];
    for (RADTag *tag in self.tags) {
        [bookTags appendString:tag.name];
        [bookTags appendString:@", "];
    }
    [bookTags deleteCharactersInRange:NSMakeRange([bookTags length] -2 ,2)];
    return bookTags;
}

-(BOOL) isFavorite{
    // If contains favorito tag isFavorite
    if ([self.tags.allObjects containsObject:@"favorite"]){
        return YES;
    }
    return NO;
}

-(void) switchFavorite:(BOOL) favorite{

}




#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
        //Action
}




//Setter isFavorite
-(void)setIsFavorite:(BOOL)isFavorite{
    BOOL hasFav = [self hasFavoriteTag];
    if (isFavorite) {
        if (!hasFav) {
            [self insertFavoriteTag];
        }
    }else{
        if (hasFav) {
            [self removeFavoriteTag];
        }
    }
}


-(BOOL) hasFavoriteTag{
    //TODO hasFavoriteTag
    return YES;
}

-(void) insertFavoriteTag{
    NSMutableSet *newSet = [self.tags mutableCopy];
    [newSet addObject:@"favorite"];
    [self setTags:newSet];
}

-(void) removeFavoriteTag{
    NSMutableSet *newSet = [self.tags mutableCopy];
    [newSet removeObject:@"favorite"];
    [self setTags:newSet];
}



//Change Notification
-(void) notifyChanges{
    NSNotification *n = [NSNotification
                         notificationWithName:RADBOOK_DID_CHANGE_NOTIFICATION
                         object:self
                         userInfo:@{BOOK_KEY : self}];
    [[NSNotificationCenter defaultCenter] postNotification:n];
}

@end
