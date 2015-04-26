// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RADPdf.h instead.

@import CoreData;
#import "RADHackerBooksBaseClass.h"

extern const struct RADPdfAttributes {
	__unsafe_unretained NSString *pdfData;
	__unsafe_unretained NSString *pdfUrl;
} RADPdfAttributes;

extern const struct RADPdfRelationships {
	__unsafe_unretained NSString *books;
} RADPdfRelationships;

@class RADBook;

@interface RADPdfID : NSManagedObjectID {}
@end

@interface _RADPdf : RADHackerBooksBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RADPdfID* objectID;

@property (nonatomic, strong) NSData* pdfData;

//- (BOOL)validatePdfData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* pdfUrl;

//- (BOOL)validatePdfUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) RADBook *books;

//- (BOOL)validateBooks:(id*)value_ error:(NSError**)error_;

@end

@interface _RADPdf (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePdfData;
- (void)setPrimitivePdfData:(NSData*)value;

- (NSString*)primitivePdfUrl;
- (void)setPrimitivePdfUrl:(NSString*)value;

- (RADBook*)primitiveBooks;
- (void)setPrimitiveBooks:(RADBook*)value;

@end
