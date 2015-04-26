// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RADNote.h instead.

@import CoreData;
#import "RADHackerBooksBaseClass.h"

extern const struct RADNoteAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *text;
	__unsafe_unretained NSString *ts_add;
	__unsafe_unretained NSString *ts_upd;
} RADNoteAttributes;

extern const struct RADNoteRelationships {
	__unsafe_unretained NSString *books;
	__unsafe_unretained NSString *images;
} RADNoteRelationships;

@class RADBook;
@class RADImage;

@interface RADNoteID : NSManagedObjectID {}
@end

@interface _RADNote : RADHackerBooksBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RADNoteID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* text;

//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* ts_add;

//- (BOOL)validateTs_add:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* ts_upd;

//- (BOOL)validateTs_upd:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) RADBook *books;

//- (BOOL)validateBooks:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) RADImage *images;

//- (BOOL)validateImages:(id*)value_ error:(NSError**)error_;

@end

@interface _RADNote (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

- (NSDate*)primitiveTs_add;
- (void)setPrimitiveTs_add:(NSDate*)value;

- (NSDate*)primitiveTs_upd;
- (void)setPrimitiveTs_upd:(NSDate*)value;

- (RADBook*)primitiveBooks;
- (void)setPrimitiveBooks:(RADBook*)value;

- (RADImage*)primitiveImages;
- (void)setPrimitiveImages:(RADImage*)value;

@end
